//
//  FPEvent.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPEvent.h"
#import <Mantle/Mantle.h>

@implementation FPEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"eventID": @"event_id",
             @"eventType": @"event_type",
             @"teamID": @"team_id",
             @"imageURL": @"event_img",
             @"time": @"time",
             @"matchTime": @"match_time",
             };
}

+ (NSValueTransformer *)eventTypeJSONTransformer
{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:[self eventTypeMapping]
                                                             defaultValue:@(FPEventTypeUnknown)
                                                      reverseDefaultValue:nil];
}

+ (NSDictionary *)eventTypeMapping
{
    return @{@"goals": @(FPEventTypeGoal),
             @"red_card": @(FPEventTypeRedCard),
             @"yellow_card": @(FPEventTypeYellowCard),
             @"substitution": @(FPEventTypeSubstitution)
             };
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

#pragma mark - Useful Property
- (NSString *)eventDescription
{
    return nil;
}

- (NSString *)eventIconName
{
    return nil;
}

@end
