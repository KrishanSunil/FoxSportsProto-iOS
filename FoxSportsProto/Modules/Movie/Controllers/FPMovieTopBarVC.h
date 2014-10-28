//
//  FPMovieTopBarVC.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseVC.h"

@class FPMoviePlayer;
@class FPMatchManager;

@interface FPMovieTopBarVC : FPBaseVC

@property (nonatomic, strong) FPMoviePlayer *moviePlayer;
@property (nonatomic, strong) FPMatchManager *matchManager;

@property (weak, nonatomic) IBOutlet UIButton *playerStatsButton;
@property (weak, nonatomic) IBOutlet UIButton *teamStatsButton;
@property (weak, nonatomic) IBOutlet UIButton *heatmapButton;

@end
