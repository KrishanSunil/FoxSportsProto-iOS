//
//  FPMovieLoadingVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/21/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMovieLoadingVC.h"
#import "FPMoviePlayerHeader.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface FPMovieLoadingVC () <FPMoviePlayerDelegate>

@end

@implementation FPMovieLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MoviePlayer
- (void)setMoviePlayer:(FPMoviePlayer *)moviePlayer
{
    _moviePlayer = moviePlayer;
    [_moviePlayer addDelegate:self];
}


#pragma mark - FPMoviePlayerDelegate
- (void)moviePlayerDidChangeNowPlayingMovie:(FPMoviePlayer *)moviePlayer
{
    [SVProgressHUD show];
}

- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didFinish:(NSError *)error
{
    [SVProgressHUD dismiss];
}

- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangeLoadState:(FPMoviePlayerLoadState)loadState
{
    switch (loadState) {
        case FPMoviePlayerLoadStateStalled:
            if (!moviePlayer.didPlayToEnd) {
                [SVProgressHUD show];
            }
            break;
        case FPMoviePlayerLoadStatePlayable:
            break;
        case FPMoviePlayerLoadStatePlaythroughOK:
            [SVProgressHUD dismiss];
            break;
        default:
            break;
    }
}

- (void)moviePlayer:(FPMoviePlayer *)moviePlayer didChangeStatus:(AVPlayerItemStatus)status
{
    switch (status) {
        case AVPlayerItemStatusUnknown:
            [SVProgressHUD show];
            break;
        case AVPlayerItemStatusFailed:
            [SVProgressHUD showErrorWithStatus:nil];
            break;
        case AVPlayerItemStatusReadyToPlay:
            [SVProgressHUD dismiss];
            break;
        default:
            break;
    }
}

- (void)moviePlayerDidBeginSeeking:(FPMoviePlayer *)moviePlayer
{
    [SVProgressHUD show];
}

- (void)moviePlayerDidEndSeeking:(FPMoviePlayer *)moviePlayer
{
    [SVProgressHUD dismiss];
}


@end
