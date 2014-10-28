//
//  FPMoviePlayer.m
//  FoxPlay
//
//  Created by Khoa Pham on 9/4/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer.h"
#import "FPMoviePlayer_Private.h"
#import "FPMoviePlayer+TimeObserver.h"
#import "FPMoviePlayer+AVPlayer.h"
#import "FPMoviePlayer+AVPlayerItem.h"
@import UIKit;

@implementation FPMoviePlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegates = [NSHashTable weakObjectsHashTable];
        [self registerNotifications];
    }

    return self;
}

- (void)dealloc
{
    [self unregisterNotifications];
}

#pragma mark - Public Interface
- (void)addDelegate:(id<FPMoviePlayerDelegate>)delegate
{
    [self.delegates addObject:delegate];
}

- (void)playURL:(NSURL *)URL
{
    if (self.avPlayer.currentItem) {
        [self unobserveAVPlayerItem];
        [self removeTimeObservers];
    }

    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:URL];

    if (self.avPlayer) {
        if (self.avPlayer.currentItem && self.avPlayer.currentItem != playerItem) {
            [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
        }
    } else {
        [self setupAVPlayerWithPlayerItem:playerItem];
    }

    self.didPlayToEnd = NO;
    [self observeAVPlayerItem:playerItem];
    [self beginAddingTimeObserver];

    // Play
    [self.avPlayer play];
}

- (void)play
{
    // If we are at the end of the movie, we must seek to the beginning first before starting playback
    if (self.didPlayToEnd) {
        self.didPlayToEnd = NO;

        [self.avPlayer seekToTime:kCMTimeZero];
    }

    [self.avPlayer play];
}

- (void)playOnly
{
    // If user uses slider, the movie player should not back to the beginning
    [self.avPlayer play];
}

- (void)pause
{
    [self.avPlayer pause];
}

- (void)backToStart
{
    [self.avPlayer seekToTime:kCMTimeZero];
    [self.avPlayer pause];
}

- (void)terminate
{
    [self.avPlayer pause];

    [self removeTimeObservers];
    self.playerKVOController = nil;
    self.playerItemKVOController = nil;

    self.avPlayerLayer.player = nil;
    [self.avPlayerLayer removeFromSuperlayer];
    self.avPlayerLayer = nil;
    self.avPlayer = nil;
}

#pragma mark - Resume
- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleApplicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:[UIApplication sharedApplication]];
}

- (void)unregisterNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleApplicationDidBecomeActive:(NSNotification *)note
{
    [self playOnly];
}

@end
