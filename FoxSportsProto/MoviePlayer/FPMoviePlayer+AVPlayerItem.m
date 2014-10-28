//
//  FPMoviePlayer+AVPlayerItem.m
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer+AVPlayerItem.h"
#import "FPMoviePlayer_Private.h"
#import <KVOController/FBKVOController.h>
#import "FPMoviePlayer+TimeObserver.h"

@implementation FPMoviePlayer (AVPlayerItem)

#pragma mark - AVPlayerItem
- (void)observeAVPlayerItem:(AVPlayerItem *)playerItem
{
    self.playerItemKVOController = [[FBKVOController alloc] initWithObserver:self];

    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
    [self.playerItemKVOController observe:playerItem keyPath:@"status" options:options
                                   action:@selector(playerItemDidChangeStatus:object:)];

    [self.playerItemKVOController observe:playerItem keyPath:@"duration" options:options
                                   action:@selector(playerItemDidLoadDuration:object:)];

    [self.playerItemKVOController observe:playerItem keyPath:@"playbackBufferEmpty" options:options
                                   action:@selector(playerItemDidChangeLoadState:object:)];

    [self.playerItemKVOController observe:playerItem keyPath:@"playbackLikelyToKeepUp" options:options
                                   action:@selector(playerItemDidChangeLoadState:object:)];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidPlayToEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:playerItem];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemFailedToPlayToEnd:)
                                                 name:AVPlayerItemFailedToPlayToEndTimeErrorKey
                                               object:playerItem];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemPlaybackStalled:)
                                                 name:AVPlayerItemPlaybackStalledNotification
                                               object:playerItem];
}

- (void)unobserveAVPlayerItem
{
    AVPlayerItem *playerItem = self.avPlayer.currentItem;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:nil
                                                  object:playerItem];
}

#pragma mark - Delegate
- (void)playerItemDidChangeStatus:(NSDictionary *)change object:(id)object
{
    AVPlayerItemStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayer:didChangeStatus:)]) {
                [delegate moviePlayer:self didChangeStatus:status];
            }
        }
    });
}

- (void)playerItemDidLoadDuration:(NSDictionary *)change object:(id)object
{
    CMTime duration = kCMTimeIndefinite;
    [[change objectForKey:NSKeyValueChangeNewKey] getValue:&duration];

    if (CMTIME_IS_INDEFINITE(duration) || CMTIME_IS_INVALID(duration)) {
        return;
    }

    // duration KVO is fired many times, so we unobserve it after get the right duration
    AVPlayerItem *playerItem = object;
    [self.playerItemKVOController unobserve:playerItem keyPath:@"duration"];

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayerDidLoadDuration:)]) {
                [delegate moviePlayerDidLoadDuration:self];
            }
        }
    });
}

- (void)playerItemDidChangeLoadState:(NSDictionary *)change object:(id)object
{
    AVPlayerItem *playerItem = object;

    FPMoviePlayerLoadState loadState = FPMoviePlayerLoadStateUnknown;
    loadState = playerItem.isPlaybackBufferEmpty ? FPMoviePlayerLoadStateStalled : FPMoviePlayerLoadStatePlayable;

    if (playerItem.isPlaybackLikelyToKeepUp) {
        loadState = FPMoviePlayerLoadStatePlaythroughOK;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayer:didChangeLoadState:)]) {
                [delegate moviePlayer:self didChangeLoadState:loadState];
            }
        }
    });
}

- (void)playerItemDidPlayToEnd:(NSNotification *)note
{
    self.didPlayToEnd = YES;

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayer:didFinish:)]) {
                [delegate moviePlayer:self didFinish:nil];
            }
        }
    });
}

- (void)playerItemFailedToPlayToEnd:(NSNotification *)note
{
    NSError *error = [note.userInfo objectForKey:AVPlayerItemFailedToPlayToEndTimeErrorKey];

    NSLog(@"playerItemFailedToPlayToEnd %@", error);

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayer:didFinish:)]) {
                [delegate moviePlayer:self didFinish:error];
            }
        }
    });
}

- (void)playerItemPlaybackStalled:(NSNotification *)note
{
    FPMoviePlayerLoadState loadState = FPMoviePlayerLoadStateStalled;

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayer:didChangeLoadState:)]) {
                [delegate moviePlayer:self didChangeLoadState:loadState];
            }
        }
    });
}


@end
