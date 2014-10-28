//
//  FPMoviePlayerVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayerVC.h"
#import "FPMedia.h"
#import "UIViewController+FPAdditions.h"
#import "FPMovieOnlyVC.h"
#import "FPMovieLoadingVC.h"
#import "FPMovieTopBarVC.h"
#import "FPMovieBottomBarVC.h"
#import "FPMoviePlayerHeader.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "FPMatchManager.h"
#import "FPMovieStatsVC.h"
#import "UIView+UpdateAutoLayoutConstraints.h"

#import <ViewUtils/ViewUtils.h>

@interface FPMoviePlayerVC () <FPMovieBottomBarVCDelegate, FPMoviePlayerDelegate>

@property (nonatomic, strong) FPMovieOnlyVC *movieOnlyVC;
@property (nonatomic, strong) FPMovieLoadingVC *movieLoadingVC;
@property (nonatomic, strong) FPMovieTopBarVC *movieTopBarVC;
@property (nonatomic, strong) FPMovieBottomBarVC *movieBottomVC;

@property (nonatomic, strong) FPMovieStatsVC *statsAVC;
@property (nonatomic, strong) FPMovieStatsVC *statsBVC;

@property (weak, nonatomic) IBOutlet UIView *movieOnlyContainerView;
@property (weak, nonatomic) IBOutlet UIView *movieTopBarContainerView;
@property (weak, nonatomic) IBOutlet UIView *movieBottomBarContainerView;
@property (weak, nonatomic) IBOutlet UIView *statsAContainerView;
@property (weak, nonatomic) IBOutlet UIView *statsBContainerView;

@property (nonatomic, strong) FPMatchManager *matchManager;

@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign) BOOL isStatsViewShowing;
@property (nonatomic, assign) BOOL isStatsViewAnimating;

@end

@implementation FPMoviePlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildVCs];
    [self wireUpTopVCActions];
    [self setupMoviePlayer];
    [self setupMatchManager];
    [self playMedia];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupChildVCs
{
    // Only
    self.movieOnlyVC = [FPMovieOnlyVC fp_instantiatedFromStoryboardNamed:@"MovieOnly"];
    [self fp_addChildVC:self.movieOnlyVC containerView:self.movieOnlyContainerView];

    // Top
    self.movieTopBarVC = [FPMovieTopBarVC fp_instantiatedFromStoryboardNamed:@"MovieTopBar"];
    [self fp_addChildVC:self.movieTopBarVC containerView:self.movieTopBarContainerView];

    // Bottom
    self.movieBottomVC = [FPMovieBottomBarVC fp_instantiatedFromStoryboardNamed:@"MovieBottomBar"];
    self.movieBottomVC.delegate = self;
    [self fp_addChildVC:self.movieBottomVC containerView:self.movieBottomBarContainerView];

    // Loading
    self.movieLoadingVC = [[FPMovieLoadingVC alloc] init];
    [self fp_addChildVC:self.movieLoadingVC containerView:self.view];

    // Stats
    self.statsAVC = [FPMovieStatsVC fp_instantiatedFromStoryboardNamed:@"MovieStats"];
    [self fp_addChildVC:self.statsAVC containerView:self.statsAContainerView];
    [self.statsAContainerView constraintForAttribute:NSLayoutAttributeLeading].constant -= self.view.width;

    self.statsBVC = [FPMovieStatsVC fp_instantiatedFromStoryboardNamed:@"MovieStats"];
    [self fp_addChildVC:self.statsBVC containerView:self.statsBContainerView];
    [self.statsBContainerView constraintForAttribute:NSLayoutAttributeTrailing].constant -= self.view.width;
}

- (void)setupMoviePlayer
{
    FPMoviePlayer *moviePlayer = self.movieOnlyVC.moviePlayer;

    [moviePlayer addDelegate:self];

    self.movieTopBarVC.moviePlayer = moviePlayer;
    self.movieBottomVC.moviePlayer = moviePlayer;
    self.movieLoadingVC.moviePlayer = moviePlayer;
}

- (void)setupMatchManager
{
    FPMatchManager *matchManager = [[FPMatchManager alloc] initWithMedia:self.media];

    self.matchManager = matchManager;
    self.movieTopBarVC.matchManager = matchManager;
    self.movieBottomVC.matchManager = matchManager;

    [matchManager pullMatch];
}

- (void)wireUpTopVCActions
{
    [self.movieTopBarVC.playerStatsButton addTarget:self action:@selector(playerStatsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.movieTopBarVC.teamStatsButton addTarget:self action:@selector(teamStatsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.movieTopBarVC.heatmapButton addTarget:self action:@selector(heatMapAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - TopVC Action
- (void)playerStatsAction:(UIButton *)sender
{
    [self statsAction:sender];

    if (!self.selectedButton) {
        return;
    }

    [self.statsAVC loadULRString:@"http://fox-sport.s3-website-ap-southeast-1.amazonaws.com/#/player/right/real_madrid"];
    [self.statsBVC loadULRString:@"http://fox-sport.s3-website-ap-southeast-1.amazonaws.com/#/player/left/barcelona"];
}

- (void)teamStatsAction:(UIButton *)sender
{
    [self statsAction:sender];

    if (!self.selectedButton) {
        return;
    }

    [self.statsAVC loadULRString:@"http://fox-sport.s3-website-ap-southeast-1.amazonaws.com/#/team/1"];
    [self.statsBVC loadULRString:@"http://fox-sport.s3-website-ap-southeast-1.amazonaws.com/#/team/1"];
}

- (void)heatMapAction:(UIButton *)sender
{
    [self statsAction:sender];

    if (!self.selectedButton) {
        return;
    }

    [self.statsAVC loadULRString:@"http://fox-sport.s3-website-ap-southeast-1.amazonaws.com/#/heatmap/right/real_madrid"];
    [self.statsBVC loadULRString:@"http://fox-sport.s3-website-ap-southeast-1.amazonaws.com/#/heatmap/left/barcelona"];
}

- (void)statsAction:(UIButton *)button
{
    self.selectedButton.selected = NO;

    if (self.selectedButton == button) {
        [self hideStatsView];
        self.selectedButton = nil;
    } else {
        [self showStatsView];
        self.selectedButton = button;
        button.selected = YES;
    }
}

- (void)showStatsView
{
    if (self.isStatsViewShowing) {
        return;
    }

    [self toggleStatsViewVisibility:YES];
}

- (void)hideStatsView
{
    if (!self.isStatsViewShowing) {
        return;
    }

    [self toggleStatsViewVisibility:NO];
}

- (void)toggleStatsViewVisibility:(BOOL)visible
{
    if (self.isStatsViewAnimating) {
        return;
    }

    self.isStatsViewShowing = visible;

    self.isStatsViewAnimating = YES;
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat distance = self.isStatsViewShowing ? 0 : -self.view.width;
        [self.statsAContainerView constraintForAttribute:NSLayoutAttributeLeading].constant = distance;
        [self.statsBContainerView constraintForAttribute:NSLayoutAttributeTrailing].constant = distance;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isStatsViewAnimating = NO;
    }];
}

// MARK: MovieBottomBarVCDelegate
- (void)movieBottomBarVCDidTap
{
    [self hideStatsView];
    self.selectedButton.selected = NO;
    self.selectedButton = nil;
}

// MARK: MoviePlayerDelegate
- (void)moviePlayerDidTick:(FPMoviePlayer *)moviePlayer
{
    if (self.isStatsViewShowing && self.selectedButton == self.movieTopBarVC.heatmapButton) {
        [self.statsAVC updateHeatmap];
        [self.statsBVC updateHeatmap];
    }
}

#pragma mark - Play
- (void)playMedia
{
    //self.media.streamURL = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"];
    self.media.streamURL = [NSURL URLWithString:@"http://foxplayasia-vh.akamaihd.net/i/vod/,FOX_SPORTS_Asia_Dev_CP/2014-10-25T16-00-39.767Z--6536.266__244101.mp4,.csmil/master.m3u8"];
    [self.movieOnlyVC playURL:self.media.streamURL];
}

@end
