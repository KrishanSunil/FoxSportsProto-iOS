//
//  FPMoviePlayer+Playback.h
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer.h"

@interface FPMoviePlayer (Playback)

@property (nonatomic, assign) NSTimeInterval currentPlaybackTime;
@property (nonatomic, assign, readonly) NSTimeInterval duration;
@property (nonatomic, assign, readonly) NSTimeInterval playableDuration;

@end
