//
//  FPMatchManager.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMatchManager.h"
#import "FPMedia.h"
#import "FPMatch.h"
#import "FPMatchNetworkClient.h"

@interface FPMatchManager ()

@property (nonatomic, strong) FPMedia *media;
@property (nonatomic, strong) NSHashTable *delegates;

@end

@implementation FPMatchManager

- (instancetype)initWithMedia:(FPMedia *)media
{
    self = [super init];
    if (self) {
        _media = media;
        _delegates = [NSHashTable weakObjectsHashTable];
    }

    return self;
}

- (void)addDelegate:(id<FPMatchManagerDelegate>)delegate
{
    [self.delegates addObject:delegate];
}

- (void)pullMatch
{
    FPMatchNetworkClient *client = [[FPMatchNetworkClient alloc] init];
    [client getMatchForMedia:self.media success:^(FPMatch *match) {
        [self didUpdateMatch:match];
    } failure:^(NSError *error) {

    }];
}

#pragma mark - Delegate
- (void)didUpdateMatch:(FPMatch *)match
{
    for (id<FPMatchManagerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(matchManagerDidUpdateMatch:)]) {
            [delegate matchManagerDidUpdateMatch:match];
        }
    }
}

@end
