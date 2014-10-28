//
//  FPMovieBottomBarVC.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseVC.h"

@class FPMoviePlayer;
@class FPMatchManager;

@protocol FPMovieBottomBarVCDelegate <NSObject>

- (void)movieBottomBarVCDidTap;

@end

@interface FPMovieBottomBarVC : FPBaseVC

@property (nonatomic, strong) FPMoviePlayer *moviePlayer;
@property (nonatomic, strong) FPMatchManager *matchManager;
@property (nonatomic, weak) id<FPMovieBottomBarVCDelegate> delegate;

@end
