//
//  FPMoviePlayer+TimeObserver.h
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer.h"

@interface FPMoviePlayer (TimeObserver)

- (void)beginAddingTimeObserver;
- (void)removeTimeObserver:(id)timeObserver;
- (void)removeTimeObservers;
- (id)addPeriodTimeObserverForInterval:(NSTimeInterval)timeInterval block:(FPMoviePlayerPeriodTimeBlock)block;
- (id)addBoundaryTimeObserverForTimes:(NSArray *)times block:(FPMoviePlayerBoundaryTimeBlock)block;

@end
