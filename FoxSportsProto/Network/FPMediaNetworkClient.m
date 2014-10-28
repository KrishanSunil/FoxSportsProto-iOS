//
//  FPMediaNetworkClient.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMediaNetworkClient.h"
#import "FPNetworkClient.h"
#import "FPMedia.h"
#import "FPBaseModel+FPAdditions.h"

@implementation FPMediaNetworkClient

- (void)getMediaListWithSuccess:(FPArrayBlock)success
                        failure:(FPErrorBlock)failure
{
    FPNetworkClient *client = [FPNetworkClient networkClient];
    [client get:@"http://private-9c54-foxplay.apiary-mock.com/fox/media/list" parameters:nil success:^(id object)
    {
        NSArray *mediaList = [FPMedia fp_modelsFromJSONArray:object];
        if (success) {
            success(mediaList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
