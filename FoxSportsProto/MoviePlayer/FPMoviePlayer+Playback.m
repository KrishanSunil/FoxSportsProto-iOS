//
//  FPMoviePlayer+Playback.m
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer+Playback.h"
#import "FPMoviePlayer_Private.h"

@implementation FPMoviePlayer (Playback)

- (NSTimeInterval)currentPlaybackTime
{
    AVPlayerItem *playerItem = self.avPlayer.currentItem;
    return CMTimeGetSeconds(playerItem.currentTime);
}

- (void)setCurrentPlaybackTime:(NSTimeInterval)currentPlaybackTime
{
    [self playerDidBeginSeeking];

    __weak typeof(self) weakSelf = self;
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(currentPlaybackTime, kPreferredTimeScale)
              toleranceBefore:kCMTimeZero
               toleranceAfter:kCMTimeZero
            completionHandler:^(BOOL finished)
     {
         if (finished) {
             [weakSelf playerDidEndSeeking];
         }
     }];
}

- (NSTimeInterval)duration
{
    return CMTimeGetSeconds(self.playerItemDuration);
}

- (NSTimeInterval)playableDuration
{
    return CMTimeGetSeconds(self.playerItemPlayableDuration);
}

- (CMTime)playerItemPlayableDuration
{
    AVPlayerItem *playerItem = self.avPlayer.currentItem;

    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        NSArray *loadTimeRanges = playerItem.loadedTimeRanges;

        CMTime currentTime = playerItem.currentTime;

        __block CMTimeRange aTimeRange;
        [loadTimeRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            aTimeRange = [[loadTimeRanges objectAtIndex:0] CMTimeRangeValue];

            if (CMTimeRangeContainsTime(aTimeRange, currentTime)) {
                *stop = YES;
            }
        }];

        return CMTimeRangeGetEnd(aTimeRange);

    } else {
        return kCMTimeZero;
    }
}

- (CMTime)playerItemDuration
{
	AVPlayerItem *playerItem = self.avPlayer.currentItem;

    if (CMTIME_IS_INDEFINITE(playerItem.duration) || CMTIME_IS_INVALID(playerItem.duration)) {
        return kCMTimeZero;
    }
    
    return playerItem.duration;
}

#pragma mark - Seek
- (void)playerDidBeginSeeking
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayerDidBeginSeeking:)]) {
                [delegate moviePlayerDidBeginSeeking:self];
            }
        }
    });
}

- (void)playerDidEndSeeking
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(moviePlayerDidEndSeeking:)]) {
                [delegate moviePlayerDidEndSeeking:self];
            }
        }
    });
}

@end
