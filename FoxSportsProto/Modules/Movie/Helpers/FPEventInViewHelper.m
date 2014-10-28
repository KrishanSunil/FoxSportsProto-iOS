//
//  FPEventInViewHelper.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPEventInViewHelper.h"
#import "FPEvent.h"

@implementation FPEventInViewHelper

+ (CGFloat)xPositionForTime:(NSTimeInterval)time viewWidth:(CGFloat)width duration:(NSTimeInterval)duration
{
    return time / duration * width;
}

+ (NSTimeInterval)timeForXPosition:(CGFloat)xPosition viewWidth:(CGFloat)width duration:(NSTimeInterval)duration
{
    return xPosition / width * duration;
}

+ (NSArray *)eventsCloseToTime:(NSTimeInterval)time within:(NSTimeInterval)seconds events:(NSArray *)events
{
    NSMutableArray *results = [NSMutableArray array];
    for (FPEvent *event in events) {
        if (fabs((event.time.floatValue - time)) <= seconds) {
            [results addObject:event];
        }
    }

    return results;
}

@end
