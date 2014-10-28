//
//  FPSubstitutionEvent.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPSubstitutionEvent.h"

@implementation FPSubstitutionEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *JSONKeyPathsByPropertyKey =
    [NSMutableDictionary dictionaryWithDictionary:@{@"playerInName": @"player_in",
                                                    @"playerOutName": @"player_out",
                                                    }];

    [JSONKeyPathsByPropertyKey addEntriesFromDictionary:[super JSONKeyPathsByPropertyKey]];
    return JSONKeyPathsByPropertyKey;
}

- (NSString *)eventDescription
{
    return [NSString stringWithFormat:@"%@ is substituted by %@", self.playerOutName, self.playerInName];
}

- (NSString *)eventIconName
{
    return @"switch_player";
}

@end
