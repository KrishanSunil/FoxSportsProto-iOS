//
//  FPMovieControlHandler.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMovieControlHandler.h"
#import <UIKit/UIKit.h>
#import "FPMoviePlayerHeader.h"
#import "FPTimeIntervalHelper.h"

@interface FPMovieControlHandler () <FPMoviePlayerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *rewindButton;
@property (weak, nonatomic) IBOutlet UIButton *fastForwardButton;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isDurationDetermined;
@property (nonatomic, assign) BOOL isSeeking;
@property (nonatomic, assign) BOOL isSliderInteracting;

@end

@implementation FPMovieControlHandler

- (void)setup
{
    self.isDurationDetermined = NO;

    [self setupSlider];
    [self updatePlayingProfressInfoToBeginning];
}

#pragma mark - Setup
- (void)setupSlider
{
    [self.slider setThumbImage:[UIImage imageNamed:@"arrow_play"] forState:UIControlStateNormal];
}

#pragma mark - MoviePlayer
- (void)setMoviePlayer:(FPMoviePlayer *)moviePlayer
{
    _moviePlayer = moviePlayer;

    [moviePlayer addDelegate:self];
}

#pragma mark - MoviePlayerDelegate
- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangePlaybackState:(FPMoviePlayerPlaybackState)playbackState
{
    switch (playbackState) {
        case FPMoviePlayerPlaybackStatePlaying: {
            self.isPlaying = YES;
            break;
        }
        case FPMoviePlayerPlaybackStatePaused: {
            self.isPlaying = NO;
            break;
        }
        default:

            break;
    }
}

- (void)moviePlayerDidLoadDuration:(FPMoviePlayer *)moviePlayer
{
    self.isDurationDetermined = YES;

    self.slider.minimumValue = 0;
    self.slider.maximumValue = floor(self.moviePlayer.duration);

    [self updateTimeLabelsWithCurrentTime:0
                                 duration:self.moviePlayer.duration];
}

- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didFinish:(NSError *)error
{
    [self updatePlayingProgressInfoToEnd];
}

- (void)moviePlayerDidChangeNowPlayingMovie:(FPMoviePlayer *)moviePlayer
{
    [self updatePlayingProfressInfoToBeginning];
}

- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangeStatus:(AVPlayerItemStatus)status
{
    switch (status) {
        case AVPlayerItemStatusUnknown:
            break;
        case AVPlayerItemStatusFailed:
            break;
        case AVPlayerStatusReadyToPlay:
        default:
            break;
    }
}

- (void)moviePlayerDidTick:(FPMoviePlayer *)moviePlayer
{
    [self handleMoviePlayerTick];
}

#pragma mark - Logic
- (void)setIsPlaying:(BOOL)isPlaying
{
    _isPlaying = isPlaying;

    self.playButton.selected = isPlaying;
}


#pragma mark - Action
- (IBAction)previousButtonTouched:(id)sender {
    [self seek:-30];
}

- (IBAction)nextButtonTouched:(id)sender {
    [self seek:30];
}

- (IBAction)playButtonTouched:(id)sender {
    if (self.isPlaying) {
        [self.moviePlayer pause];
    } else {
        [self.moviePlayer play];
    }
}

#pragma mark - Seek
- (void)seek:(NSTimeInterval)timeInterval
{
    if (!self.isSeeking) {
        self.isSeeking = YES;

        [self beginSeeking];
    }

    [self didSeek:timeInterval];
    [self scheduleEndSeeking];
}

- (void)scheduleEndSeeking
{
    [self unscheduleEndSeeking];
    [self performSelector:@selector(endSeeking) withObject:nil afterDelay:1];
}

- (void)unscheduleEndSeeking
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(endSeeking) object:nil];
}

- (void)beginSeeking
{
    self.isSeeking = NO;

    [self handleSliderBegin];
}

- (void)endSeeking
{
    [self handleSliderEnd];
}

- (void)didSeek:(NSTimeInterval)timeInterval
{
    CGFloat seekPosition = self.slider.value + timeInterval;

    seekPosition = MAX(0, seekPosition);
    seekPosition = MIN(seekPosition, self.slider.maximumValue);

    self.slider.value = seekPosition;

    [self handleSliderChange];
}

#pragma mark - Slider Event
- (IBAction)sliderValueChanged:(id)sender
{
    [self handleSliderChange];
}

- (IBAction)sliderTouchTouchDown:(id)sender
{
    [self handleSliderBegin];
}

- (IBAction)sliderTouchUpInside:(id)sender
{
    [self handleSliderEnd];
}

- (IBAction)sliderTouchUpOutside:(id)sender
{
    [self handleSliderEnd];
}


#pragma mark - Slider Handling
- (void)handleSliderBegin
{
    self.isSliderInteracting = YES;
    [self.moviePlayer pause];
}

- (void)handleSliderChange
{
    [self updateTimeLabelsWithCurrentTime:self.slider.value
                                 duration:self.moviePlayer.duration];
}

- (void)handleSliderEnd
{
    self.moviePlayer.currentPlaybackTime = floor(self.slider.value);
    [self.moviePlayer playOnly];

    self.isSliderInteracting = NO;
}

#pragma mark - Tick
- (void)handleMoviePlayerTick
{
    if (self.isSliderInteracting) {
        return;
    }

    if (!self.isDurationDetermined) {
        return;
    }

    if (self.isPlaying) {
        [self updatePlayingProgressInfo];
    }
}

#pragma mark - Time Label
- (void)updateTimeLabelsWithCurrentTime:(double)currentTime
                               duration:(double)duration
{
    currentTime = MAX(0, currentTime);

    self.timeLabel.text = FPClockStringFromTimeInterval(floor(currentTime));
    self.totalTimeLabel.text = FPClockStringFromTimeInterval(floor(duration));
}

- (void)updatePlayingProgressInfo
{
    self.slider.value = floor(self.moviePlayer.currentPlaybackTime);

    [self updateTimeLabelsWithCurrentTime:self.moviePlayer.currentPlaybackTime
                                 duration:self.moviePlayer.duration];
}

- (void)updatePlayingProgressInfoToEnd
{
    self.isPlaying = NO;
    self.slider.value = self.slider.maximumValue;
    [self updateTimeLabelsWithCurrentTime:self.slider.maximumValue
                                 duration:self.slider.maximumValue];
}

- (void)updatePlayingProfressInfoToBeginning
{
    self.isPlaying = NO;
    self.slider.value = 0;
    [self updateTimeLabelsWithCurrentTime:0 duration:0];
}

#pragma mark - Duration
- (void)setIsDurationDetermined:(BOOL)isDurationDetermined
{
    _isDurationDetermined = isDurationDetermined;

    self.slider.userInteractionEnabled = isDurationDetermined;
    self.rewindButton.userInteractionEnabled = isDurationDetermined;
    self.fastForwardButton.userInteractionEnabled = isDurationDetermined;
}

@end
