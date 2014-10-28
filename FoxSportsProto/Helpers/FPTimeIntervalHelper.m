//
//  FPTimeIntervalHelper.m
//  FoxPlay
//
//  Created by Khoa Pham on 6/18/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPTimeIntervalHelper.h"

static double kNSTimeIntervalEqualCompareThreshold = 0.01;

#define FP_SECONDS_PER_MINUTE (60)
#define FP_MINUTES_PER_HOUR (60)
#define FP_SECONDS_PER_HOUR (FP_SECONDS_PER_MINUTE * FP_MINUTES_PER_HOUR)
#define FP_HOURS_PER_DAY (24)

NSComparisonResult NSTimeIntervalCompare(NSTimeInterval time1, NSTimeInterval time2)
{
    if (abs(time2 - time1) < kNSTimeIntervalEqualCompareThreshold) {
        return NSOrderedSame;
    } else if (time1 < time2) {
        return NSOrderedAscending;
    } else {
        return NSOrderedDescending;
    }
}

NSString * FPClockStringFromTimeInterval(NSTimeInterval time)
{
    // Convert the time to an integer, as we don't need double precision, and we do need to use the modulous operator
    int ti = time;


    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d",
            (ti / FP_SECONDS_PER_HOUR) % FP_HOURS_PER_DAY,
            (ti / FP_SECONDS_PER_MINUTE) % FP_MINUTES_PER_HOUR,
            ti % FP_SECONDS_PER_MINUTE];
}
