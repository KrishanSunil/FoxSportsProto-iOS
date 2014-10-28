//
//  FPMovieControlHandler.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FPMoviePlayer;

@interface FPMovieControlHandler : NSObject

@property (nonatomic, strong) FPMoviePlayer *moviePlayer;

- (void)setup;

@end
