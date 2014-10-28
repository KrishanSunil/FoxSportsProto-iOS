//
//  FPMatch+FPScore.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMatch+FPScore.h"
#import "FPTeam.h"
#import "FPEvent.h"
#import "FPGoalEvent.h"

@implementation FPMatch (FPScore)

- (NSInteger)scoreForTeam:(FPTeam *)team until:(NSTimeInterval)time
{
    NSInteger score = 0;
    for (FPEvent *event in self.events) {
        if ([event isMemberOfClass:FPGoalEvent.class] && [event.teamID isEqualToNumber:team.teamID] && event.time.floatValue <= time) {
            score++;
        }
    }

    return score;
}

@end
