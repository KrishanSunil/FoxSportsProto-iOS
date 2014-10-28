//
//  UIViewController+FPAdditions.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "UIViewController+FPAdditions.h"
#import "NSObject+FPAdditions.h"
#import <Masonry/Masonry.h>

@implementation UIViewController (FPAdditions)

- (void)fp_addChildVC:(UIViewController *)childVC containerView:(UIView *)containerView
{
    [self addChildViewController:childVC];
    [containerView addSubview:childVC.view];
    [childVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView);
    }];

    [childVC didMoveToParentViewController:self];
}

+ (instancetype)fp_instantiatedFromStoryboardNamed:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:[self fp_identifier]];
}

@end
