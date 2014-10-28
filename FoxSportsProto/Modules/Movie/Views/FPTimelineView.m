//
//  FPTimelineView.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPTimelineView.h"
#import "FPEvent.h"
#import "FPMatch.h"
#import "FPTeam.h"
#import "FPEventInViewHelper.h"

#import <ViewUtils/ViewUtils.h>

static CGFloat kTopPadding = 22;

@interface FPTimelineView ()

@property (nonatomic, assign) NSTimeInterval mediaDuration;
@property (nonatomic, strong) FPMatch *match;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation FPTimelineView

- (void)awakeFromNib
{
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)dealloc
{
    [self removeGestureRecognizer:self.tapGestureRecognizer];
}

- (void)updateForMatch:(FPMatch *)match mediaDuration:(NSTimeInterval)duration
{
    self.mediaDuration = duration;
    self.match = match;

    if (!match || duration <=0) {
        return;
    }

    [self removeAllSubviews];

    for (FPEvent *event in match.events) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.size = CGSizeMake(15, 15);
        imageView.image = [UIImage imageNamed:event.eventIconName];

        CGFloat x = [FPEventInViewHelper xPositionForTime:event.time.floatValue viewWidth:self.width duration:duration];
        CGFloat y = [event.teamID isEqualToNumber:match.teamA.teamID] ? kTopPadding : self.bounds.size.height - 10;

        imageView.center = CGPointMake(x + 5, y);

        [self addSubview:imageView];
    }

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (!self.match) {
        return;
    }

    // H1
    for (int i=0; i<=45; i+=5) {
        CGFloat x = [FPEventInViewHelper xPositionForTime:self.match.startTimeH1.floatValue + i*60
                                                viewWidth:self.width duration:self.mediaDuration];
        NSString *text = [NSString stringWithFormat:@"%d", i];
        [self drawIndicatorAtPoint:CGPointMake(x, self.height/2) text:text];
    }

    // H2
    for (int i=0; i<=45; i+=5) {
        CGFloat x = [FPEventInViewHelper xPositionForTime:self.match.startTimeH2.floatValue + i*60
                                                viewWidth:self.width duration:self.mediaDuration];
        NSString *text = [NSString stringWithFormat:@"%d", i+45];
        [self drawIndicatorAtPoint:CGPointMake(x, self.height/2) text:text];
    }
}

- (void)drawIndicatorAtPoint:(CGPoint)point text:(NSString *)text
{
    UIImage *image = [UIImage imageNamed:@"divide"];
    [image drawAtPoint:CGPointMake(point.x + 3, point.y-10)];

     [text drawAtPoint:point withAttributes:@{
                                              NSForegroundColorAttributeName: [UIColor yellowColor]
                                              }];
}

#pragma mark - Gesture
- (void)viewTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    CGPoint point = [tapGestureRecognizer locationInView:self];

    NSTimeInterval time = [FPEventInViewHelper timeForXPosition:point.x viewWidth:self.width duration:self.mediaDuration];

    [self didSelectTime:time position:point];
}

#pragma mark - Delegate
- (void)didSelectTime:(NSTimeInterval)time position:(CGPoint)position
{
    if ([self.delegate respondsToSelector:@selector(timelineView:didSelectTime:position:)]) {
        [self.delegate timelineView:self didSelectTime:time position:position];
    }
}

#pragma mark - Helper
- (void)removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
