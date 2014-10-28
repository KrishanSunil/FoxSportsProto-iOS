//
//  FPMoviePlayer_Private.h
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer.h"

static NSInteger const kPreferredTimeScale = 1000;

@class FBKVOController;
@class AVPlayer;

@interface FPMoviePlayer ()

@property (nonatomic, strong) AVPlayer *avPlayer;

@property (nonatomic, strong) id periodTimeObserver;

@property (nonatomic, strong) NSHashTable *delegates;
@property (nonatomic, strong) FBKVOController *playerKVOController;
@property (nonatomic, strong) FBKVOController *playerItemKVOController;

@property (nonatomic, strong) NSMutableArray *timeObservers;

@end
