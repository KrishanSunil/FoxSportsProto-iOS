//
//  UIView+UpdateAutoLayoutConstant.m
//  ConstraintsCodeDemo
//
//  Created by Damien Romito on 13/03/2014.
//  Copyright (c) 2014 Damien Romito. All rights reserved.
//

#import "UIView+UpdateAutoLayoutConstraints.h"

@implementation UIView (UpdateAutoLayoutConstraints)


- (BOOL) setConstraintConstant:(CGFloat)constant forAttribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint * constraint = [self constraintForAttribute:attribute];
    if(constraint)
    {
        constraint.constant = constant;
        return YES;
    }else
    {
        [self.superview addConstraint: [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:constant]];
        return NO;
    }
}


- (CGFloat) constraintConstantforAttribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint * constraint = [self constraintForAttribute:attribute];
    
    if (constraint) {
        return constraint.constant;
    }else
    {
        return NAN;
    }
    
}


- (NSLayoutConstraint*) constraintForAttribute:(NSLayoutAttribute)attribute
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0)
    {
        return nil;
    }else
    {
        return fillteredArray.firstObject;
    }
}


- (void)hideByHeight:(BOOL)hidden andHideTopSpacing:(BOOL)hiddenTopSpacing
{
    [self hideView:hidden byAttribute:NSLayoutAttributeHeight];
    if (hiddenTopSpacing) {
        [self setConstraintConstant:0 forAttribute:NSLayoutAttributeTop];
    }
}


- (void)hideByWidth:(BOOL)hidden
{
    [self hideView:hidden byAttribute:NSLayoutAttributeWidth];
}

- (void)hideByWidth:(BOOL)hidden andHideTrailingSpacing:(BOOL)hiddenTrailingSpacing
{
    [self hideView:hidden byAttribute:NSLayoutAttributeWidth];
    if (hiddenTrailingSpacing) {
        [self setConstraintConstant:0 forAttribute:NSLayoutAttributeTrailing];
    }
}

- (void)hideByWidth:(BOOL)hidden andHideLeadingSpacing:(BOOL)hiddenLeadingSpacing
{
    [self hideView:hidden byAttribute:NSLayoutAttributeWidth];
    if (hiddenLeadingSpacing) {
        [self setConstraintConstant:0 forAttribute:NSLayoutAttributeLeading];
    }
}

- (void)hideView:(BOOL)hidden byAttribute:(NSLayoutAttribute)attribute
{
    if (self.hidden != hidden) {
        CGFloat constraintConstant = [self constraintConstantforAttribute:attribute];
        
        if (hidden)
        {
            
            if (!isnan(constraintConstant)) {
                self.alpha = constraintConstant;
            }else
            {
                CGSize size = [self getSize];
                self.alpha = (attribute == NSLayoutAttributeHeight)?size.height:size.width;
            }
            
            [self setConstraintConstant:0 forAttribute:attribute];
            self.hidden = YES;
            
        }else
        {
            if (!isnan(constraintConstant) ) {
                self.hidden = NO;
                [self setConstraintConstant:self.alpha forAttribute:attribute];
                self.alpha = 1;
            }
        }
    }
}


- (CGSize) getSize
{
    [self updateSizes];
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (void)updateSizes
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)sizeToSubviews
{
    [self updateSizes];
    CGSize fittingSize = [self systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    self.frame = CGRectMake(0, 0, 320, fittingSize.height);
}


@end
