//
//  FPMatchNetworkClient.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMatchNetworkClient.h"
#import "FPNetworkClient.h"
#import "FPMedia.h"
#import "FPBaseModel+FPAdditions.h"
#import "FPMatch.h"

@implementation FPMatchNetworkClient

- (void)getMatchForMedia:(FPMedia *)media success:(FPMatchBlock)success failure:(FPErrorBlock)failure
{
    FPNetworkClient *client = [FPNetworkClient networkClient];

    NSString *fullPath = [NSString stringWithFormat:@"http://private-9c54-foxplay.apiary-mock.com/fox/media/%@", media.mediaID];

    [client get:fullPath parameters:nil success:^(NSArray *objects) {
        FPMatch *match = [FPMatch fp_modelFromJSONDictionary:objects.firstObject];
        if (success) {
            success(match);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
