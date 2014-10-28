//
//  FPMovieTopBarVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMovieTopBarVC.h"
#import "FPMatchManager.h"
#import "FPMoviePlayerHeader.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "FPMatch.h"
#import "FPTeam.h"
#import "FPMatch+FPScore.h"

@interface FPMovieTopBarVC () <FPMoviePlayerDelegate, FPMatchManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *teamALabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamAScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamBScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamAImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamBImageView;

@property (nonatomic, strong) FPMatch *match;


@end

@implementation FPMovieTopBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.teamALabel.text = nil;
    self.teamBLabel.text = nil;

    self.teamAScoreLabel.text = nil;
    self.teamBScoreLabel.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MoviePlayer
- (void)setMoviePlayer:(FPMoviePlayer *)moviePlayer
{
    _moviePlayer = moviePlayer;

    [moviePlayer addDelegate:self];
}

#pragma mark - MoviePlayerDelegate
- (void)moviePlayerDidTick:(FPMoviePlayer *)moviePlayer
{
    // TODO: Optimize
    NSInteger teamAScore = [self.match scoreForTeam:self.match.teamA until:moviePlayer.currentPlaybackTime];
    NSInteger teamBScore = [self.match scoreForTeam:self.match.teamB until:moviePlayer.currentPlaybackTime];

    self.teamAScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)teamAScore];
    self.teamBScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)teamBScore];
}

#pragma mark - Action
- (IBAction)backButtonTouched:(id)sender
{
    [self.moviePlayer terminate];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MatchManager
- (void)setMatchManager:(FPMatchManager *)matchManager
{
    _matchManager = matchManager;

    [matchManager addDelegate:self];
}

- (void)matchManagerDidUpdateMatch:(FPMatch *)match
{
    self.teamALabel.text = match.teamA.name;
    self.teamBLabel.text = match.teamB.name;

    self.match = match;

    [self.teamAImageView setImageWithURL:match.teamA.logoURL];
    [self.teamBImageView setImageWithURL:match.teamB.logoURL];
}

@end
