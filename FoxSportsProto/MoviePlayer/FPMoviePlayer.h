//
//  FPMoviePlayer.h
//  FoxPlay
//
//  Created by Khoa Pham on 9/4/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

@import Foundation;
@import AVFoundation;

typedef NS_ENUM(NSUInteger, FPMoviePlayerPlaybackState) {
    FPMoviePlayerPlaybackStatePlaying,
    FPMoviePlayerPlaybackStatePaused,
};

typedef NS_ENUM(NSUInteger, FPMoviePlayerLoadState) {
    FPMoviePlayerLoadStateUnknown,
    FPMoviePlayerLoadStatePlayable,
    FPMoviePlayerLoadStatePlaythroughOK,
    FPMoviePlayerLoadStateStalled,
};

typedef void (^FPMoviePlayerPeriodTimeBlock)(NSTimeInterval timeInterval);
typedef void (^FPMoviePlayerBoundaryTimeBlock)();

@class FPMoviePlayer;

@protocol FPMoviePlayerDelegate <NSObject>

@optional
- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didFinish:(NSError *)error;
- (void)moviePlayerDidChangeNowPlayingMovie:(FPMoviePlayer *)moviePlayer;
- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangePlaybackState:(FPMoviePlayerPlaybackState)playbackState;
- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangeStatus:(AVPlayerItemStatus)status;
- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangeLoadState:(FPMoviePlayerLoadState)loadState;
- (void)moviePlayerDidTickForPeriodTime:(FPMoviePlayer *)moviePlayer;
- (void)moviePlayerDidLoadDuration:(FPMoviePlayer *)moviePlayer;

- (void)moviePlayerDidBeginSeeking:(FPMoviePlayer *)moviePlayer;
- (void)moviePlayerDidEndSeeking:(FPMoviePlayer *)moviePlayer;

- (void)moviePlayerBeginAddingTimeObserver:(FPMoviePlayer *)moviePlayer;
- (void)moviePlayerDidTick:(FPMoviePlayer *)moviePlayer;

@end



@interface FPMoviePlayer : NSObject

@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, assign) BOOL didPlayToEnd;

- (void)addDelegate:(id<FPMoviePlayerDelegate>)delegate;
- (void)playURL:(NSURL *)URL;

- (void)play;
- (void)playOnly;
- (void)pause;
- (void)terminate;
- (void)backToStart;

@end