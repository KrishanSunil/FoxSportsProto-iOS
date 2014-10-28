//
//  FPTeam.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPTeam.h"
#import <Mantle/Mantle.h>

@implementation FPTeam

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"teamID": @"team_id",
             @"name": @"name",
             @"shortName": @"short_name",
             @"logoURL": @"logo_url",
             };
}

+ (NSValueTransformer *)logoURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
