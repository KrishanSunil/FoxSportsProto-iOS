//
//  FPMovieOnlyVC.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseVC.h"

@class FPMoviePlayer;

@interface FPMovieOnlyVC : FPBaseVC

@property (nonatomic, strong, readonly) FPMoviePlayer *moviePlayer;

- (void)playURL:(NSURL *)url;

@end
