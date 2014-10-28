//
//  FPMovieBottomBarVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMovieBottomBarVC.h"
#import "FPMoviePlayerHeader.h"
#import "FPMatchManager.h"

#import "FPMatch.h"
#import "FPTeam.h"
#import "FPEvent.h"

#import "FPMovieControlHandler.h"
#import "FPTimelineView.h"
#import "FPEventInViewHelper.h"
#import "UIViewController+FPAdditions.h"
#import "FPEventPopupVC.h"

#import <ViewUtils/ViewUtils.h>

@interface FPMovieBottomBarVC () <FPMoviePlayerDelegate, FPMatchManagerDelegate, FPTimelineViewDelegate, FPEventPopupVCDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet FPMovieControlHandler *movieControlHandler;

@property (weak, nonatomic) IBOutlet UIView *volumeView;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *teamALabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBLabel;
@property (weak, nonatomic) IBOutlet FPTimelineView *timelineView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@property (weak, nonatomic) IBOutlet UIView *popupContainerView;
@property (nonatomic, strong) FPEventPopupVC *popupVC;

@property (nonatomic, strong) FPMatch *match;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popupContainerViewLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popupContainerViewHeightConstraint;

@end

@implementation FPMovieBottomBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.volumeView.hidden = YES;
    self.teamALabel.text = nil;
    self.teamBLabel.text = nil;

    [self.movieControlHandler setup];
    self.timelineView.delegate = self;

    [self setupPopupVC];
    self.popupContainerView.hidden = YES;

    [self setupGR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.view removeGestureRecognizer:self.tapGR];
}

#pragma mark - Setup
- (void)setupPopupVC
{
    self.popupVC = [FPEventPopupVC fp_instantiatedFromStoryboardNamed:@"EventPopup"];
    self.popupVC.delegate = self;
    [self fp_addChildVC:self.popupVC containerView:self.popupContainerView];
}

- (void)setupGR
{
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    self.tapGR.delegate = self;
    [self.view addGestureRecognizer:self.tapGR];
}

#pragma mark - GR
- (void)viewTapped:(UITapGestureRecognizer *)tapGR
{
    self.popupContainerView.hidden = YES;
    self.volumeView.hidden = YES;

    if ([self.delegate respondsToSelector:@selector(movieBottomBarVCDidTap)]) {
        [self.delegate movieBottomBarVCDidTap];
    }
}

#pragma mark - MoviePlayer
- (void)setMoviePlayer:(FPMoviePlayer *)moviePlayer
{
    _moviePlayer = moviePlayer;

    [moviePlayer addDelegate:self];
    self.movieControlHandler.moviePlayer = moviePlayer;
}

#pragma mark - MoviePlayerDelegate
- (void)moviePlayerDidLoadDuration:(FPMoviePlayer *)moviePlayer
{
    [self.timelineView updateForMatch:self.match mediaDuration:self.moviePlayer.duration];
}

#pragma mark - Action
- (IBAction)volumeButtonTouched:(id)sender {
    self.volumeView.hidden = !self.volumeView.hidden;
}

#pragma mark - Volume Slider
- (IBAction)volumeSliderValueChanged:(id)sender {
    [self.moviePlayer setVolume:self.volumeSlider.value];
}

#pragma mark - MatchManager
- (void)setMatchManager:(FPMatchManager *)matchManager
{
    _matchManager = matchManager;

    [matchManager addDelegate:self];
}

#pragma mark - MatchManagerDelegate
- (void)matchManagerDidUpdateMatch:(FPMatch *)match
{
    self.match = match;

    self.teamALabel.text = match.teamA.shortName;
    self.teamBLabel.text = match.teamB.shortName;

    [self.timelineView updateForMatch:match mediaDuration:self.moviePlayer.duration];
}

#pragma mark - Slider Event
- (IBAction)sliderTouchTouchDown:(id)sender
{
    [self handleSliderBegin];
}

- (IBAction)sliderValueChanged:(id)sender
{
    [self handleSliderChange];
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
    [self unscheduleHidingPopup];
}

- (void)handleSliderChange
{
    NSTimeInterval time = [FPEventInViewHelper timeForXPosition:self.slider.value viewWidth:self.slider.maximumValue duration:self.moviePlayer.duration];

    NSArray *events = [FPEventInViewHelper eventsCloseToTime:time within:5*60 events:self.match.events];

    if (events.count > 0) {

        CGPoint position = CGPointMake(self.slider.value/self.slider.maximumValue * self.slider.width, 0);
        CGPoint convertedPosition = [self.view convertPoint:position fromView:self.slider];
        self.popupContainerViewLeadingConstraint.constant = convertedPosition.x - 150;

        self.popupContainerView.hidden = NO;
        [self.popupVC updateForEvents:events];
    } else {
        self.popupContainerView.hidden = YES;
    }
}

- (void)handleSliderEnd
{
    self.popupContainerView.hidden = YES;
}

#pragma mark - FPTimeLineDelegate
- (void)timelineView:(FPTimelineView *)timelineView didSelectTime:(NSTimeInterval)time position:(CGPoint)position
{
    NSArray *events = [FPEventInViewHelper eventsCloseToTime:time within:5*60 events:self.match.events];

    if (events.count > 0) {
        CGPoint convertedPosition = [self.view convertPoint:position fromView:timelineView];
        self.popupContainerViewLeadingConstraint.constant = convertedPosition.x - 150;

        self.popupContainerView.hidden = NO;
        [self.popupVC updateForEvents:events];

        [self scheduleHidingPopup];
    } else {
        self.popupContainerView.hidden = YES;
    }
}


#pragma mark - EventPopupVCDelegate
- (void)eventPopupVCDidSelectEvent:(FPEvent *)event
{
    self.popupContainerView.hidden = YES;
    self.moviePlayer.currentPlaybackTime = event.time.floatValue;
}

- (void)eventPopupVCDidChangeHeight:(CGFloat)height
{
    height = MIN(height, 240);
    self.popupContainerViewHeightConstraint.constant = height;
}

#pragma mark - Popup Visibility Scheduler
- (void)hidePopup
{
    self.popupContainerView.hidden = YES;
}

- (void)scheduleHidingPopup
{
    [self unscheduleHidingPopup];

    [self performSelector:@selector(hidePopup)
               withObject:nil
               afterDelay:10];
}

- (void)unscheduleHidingPopup
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(hidePopup)
                                               object:nil];
}

// MARK: GestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.popupContainerView];
    return !CGRectContainsPoint(self.popupContainerView.bounds, point);
}

@end
