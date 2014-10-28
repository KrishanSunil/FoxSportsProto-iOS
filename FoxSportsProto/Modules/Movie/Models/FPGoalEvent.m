//
//  FPGoalEvent.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPGoalEvent.h"

@implementation FPGoalEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *JSONKeyPathsByPropertyKey =
    [NSMutableDictionary dictionaryWithDictionary:@{@"playerName": @"player_name"
                                                    }];

    [JSONKeyPathsByPropertyKey addEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
    return JSONKeyPathsByPropertyKey;
}

- (NSString *)eventDescription
{
    return [NSString stringWithFormat:@"%@ scores a goal", self.playerName];
}

- (NSString *)eventIconName
{
    return @"goal";
}

@end
