//
//  FPMatch.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMatch.h"
#import <Mantle/Mantle.h>
#import "FPBaseModel+FPAdditions.h"

#import "FPTeam.h"
#import "FPEvent.h"

#import "FPGoalEvent.h"
#import "FPYellowCardEvent.h"
#import "FPRedCardEvent.h"
#import "FPSubstitutionEvent.h"

@implementation FPMatch

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"matchID": @"id",
             @"name": @"name",
             @"startTimeH1": @"start_time_h1",
             @"startTimeH2": @"start_time_h2",
             @"teamA": @"team_A",
             @"teamB": @"team_B",
             @"events": @"time_line",
             };
}

+ (NSValueTransformer *)teamAJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:FPTeam.class];
}

+ (NSValueTransformer *)teamBJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:FPTeam.class];
}

+ (NSValueTransformer *)eventsJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^NSArray *(NSArray *array) {
        return [self eventsFromValue:array];
    }];
}

#pragma mark - Helper
+ (NSArray *)eventsFromValue:(NSArray *)array
{
    NSMutableArray *events = [NSMutableArray array];

    NSDictionary *eventTypeMapping = [FPEvent eventTypeMapping];
    for (NSDictionary *dict in array) {

        NSString *kind = dict[@"kind"];
        FPEventType eventType = [eventTypeMapping[kind] integerValue];
        FPEvent *event = nil;

        switch (eventType) {
            case FPEventTypeGoal:
                event = [FPGoalEvent fp_modelFromJSONDictionary:dict];
                break;
            case FPEventTypeYellowCard:
                event = [FPYellowCardEvent fp_modelFromJSONDictionary:dict];
                break;
            case FPEventTypeRedCard:
                event = [FPRedCardEvent fp_modelFromJSONDictionary:dict];
                break;
            case FPEventTypeSubstitution:
                event = [FPSubstitutionEvent fp_modelFromJSONDictionary:dict];
                break;
            default:
                break;
        }

        [events addObject:event];
    }

    return events;
}

@end
