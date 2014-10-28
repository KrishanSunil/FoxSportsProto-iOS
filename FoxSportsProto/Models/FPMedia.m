//
//  FPMedia.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMedia.h"
#import <Mantle/Mantle.h>

@implementation FPMedia

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"mediaID": @"id",
             @"name": @"name",
             @"thumbnailURL": @"thumbnail_url",
             @"streamURL": @"stream_url",
             };
}

+ (NSValueTransformer *)thumbnailURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)streamURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
