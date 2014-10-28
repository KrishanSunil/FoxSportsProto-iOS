//
//  FPRedCardEvent.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPRedCardEvent.h"

@implementation FPRedCardEvent

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
    return [NSString stringWithFormat:@"%@ gets a red card", self.playerName];
}

- (NSString *)eventIconName
{
    return @"card_red";
}

@end
