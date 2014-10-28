//
//  FPMovieOnlyVC.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMovieOnlyVC.h"
#import "FPMoviePlayerHeader.h"

@interface FPMovieOnlyVC ()

@property (nonatomic, strong, readwrite) FPMoviePlayer *moviePlayer;
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;

@end

@implementation FPMovieOnlyVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    [self setupMoviePlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.avPlayerLayer.frame = self.view.bounds;
}

#pragma mark - MoviePlayer
- (void)setupMoviePlayer
{
    self.avPlayerLayer = [[AVPlayerLayer alloc] init];
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    [self.view.layer addSublayer:self.avPlayerLayer];

    self.moviePlayer = [[FPMoviePlayer alloc] init];
    self.moviePlayer.avPlayerLayer = self.avPlayerLayer;
}

#pragma mark - Public Interface
- (void)playURL:(NSURL *)url
{
    [self.moviePlayer playURL:url];
}

@end
