//
//  FPMoviePlayer+AVPlayerItem.h
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer.h"

@class AVPlayerItem;

@interface FPMoviePlayer (AVPlayerItem)

- (void)observeAVPlayerItem:(AVPlayerItem *)playerItem;
- (void)unobserveAVPlayerItem;
- (void)playerItemDidPlayToEnd:(NSNotification *)note;

@end
