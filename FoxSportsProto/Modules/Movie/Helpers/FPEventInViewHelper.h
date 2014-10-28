//
//  FPEventInViewHelper.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FPEventInViewHelper : NSObject

+ (CGFloat)xPositionForTime:(NSTimeInterval)time viewWidth:(CGFloat)width duration:(NSTimeInterval)duration;
+ (NSTimeInterval)timeForXPosition:(CGFloat)xPosition viewWidth:(CGFloat)width duration:(NSTimeInterval)duration;
+ (NSArray*)eventsCloseToTime:(NSTimeInterval)time within:(NSTimeInterval)seconds events:(NSArray *)events;

@end
