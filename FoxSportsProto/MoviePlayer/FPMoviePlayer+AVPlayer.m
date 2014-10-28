//
//  FPMoviePlayer+AVPlayer.m
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer+AVPlayer.h"
#import "FPMoviePlayer_Private.h"
#import <KVOController/FBKVOController.h>

@implementation FPMoviePlayer (AVPlayer)

- (void)setupAVPlayerWithPlayerItem:(AVPlayerItem *)playerItem
{
    self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndPause;

    [self.avPlayerLayer setPlayer:self.avPlayer];
    [self observeAVPlayer];
}

- (void)observeAVPlayer
{
    self.playerKVOController = [[FBKVOController alloc] initWithObserver:self];

    NSKeyValueObservingOptions options = NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew;
    [self.playerKVOController observe:self.avPlayer keyPath:@"currentItem" options:options
                               action:@selector(playerDidChangeCurrentItem:object:)];
    [self.playerKVOController observe:self.avPlayer keyPath:@"rate" options:options
                               action:@selector(playerDidChangeRate:object:)];
}

#pragma mark - Delegate
- (void)playerDidChangeCurrentItem:(NSDictionary *)change object:(id)object
{
    AVPlayerItem *newPlayerItem = [change objectForKey:NSKeyValueChangeNewKey];

    if (!newPlayerItem || [newPlayerItem isKindOfClass:[NSNull class]]) {
        return;
    }

    // Re assign the layer
    [self.avPlayerLayer setPlayer:self.avPlayer];

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayerDidChangeNowPlayingMovie:)]) {
                [delegate moviePlayerDidChangeNowPlayingMovie:self];
            }
        }
    });
}

- (void)playerDidChangeRate:(NSDictionary *)change object:(id)object
{
    FPMoviePlayerPlaybackState state;
    state = self.avPlayer.rate == 1 ? FPMoviePlayerPlaybackStatePlaying : FPMoviePlayerPlaybackStatePaused;

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayer:didChangePlaybackState:)]) {
                [delegate moviePlayer:self didChangePlaybackState:state];
            }
        }
    });
}


@end
