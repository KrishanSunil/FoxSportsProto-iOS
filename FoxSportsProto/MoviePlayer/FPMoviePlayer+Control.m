//
//  FPMoviePlayer+Control.m
//  FoxPlay
//
//  Created by Khoa Pham on 9/13/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer+Control.h"
#import "FPMoviePlayer_Private.h"
#import "FPMoviePlayer+Playback.h"

@implementation FPMoviePlayer (Control)

- (void)rewind
{
    if (self.duration <=0) {
        return;
    }

    NSTimeInterval rewindTime = self.currentPlaybackTime - 20;
    if (rewindTime > 0) {
        self.currentPlaybackTime = rewindTime;
    }

}

- (void)forward
{
    if (self.duration <= 0) {
        return;
    }

    NSTimeInterval forwardTime = self.currentPlaybackTime + 20;
    if (forwardTime < self.duration) {
        self.currentPlaybackTime = forwardTime;
    }
}

- (void)setVolume:(CGFloat)volume
{
    self.avPlayer.volume = volume;
}

@end
