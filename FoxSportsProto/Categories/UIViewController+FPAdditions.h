//
//  UIViewController+FPAdditions.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FPAdditions)

- (void)fp_addChildVC:(UIViewController *)childVC containerView:(UIView *)containerView;
+ (instancetype)fp_instantiatedFromStoryboardNamed:(NSString *)storyboardName;

@end
