//
//  FPMoviePlayer+TimeObserver.m
//  FoxPlay
//
//  Created by Khoa Pham on 9/7/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMoviePlayer+TimeObserver.h"
#import "FPMoviePlayer_Private.h"
#import "FPMoviePlayer+AVPlayerItem.h"

@implementation FPMoviePlayer (TimeObserver)

- (void)beginAddingTimeObserver
{
    self.timeObservers = [NSMutableArray array];

    [self addPeriodTimeObserverForTick];

    for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(moviePlayerBeginAddingTimeObserver:)]) {
            [delegate moviePlayerBeginAddingTimeObserver:self];
        }
    }
}

- (void)removeTimeObservers
{
    for (id timeObserver in self.timeObservers) {
        [self.avPlayer removeTimeObserver:timeObserver];
    }

    [self.timeObservers removeAllObjects];
}

- (void)removeTimeObserver:(id)timeObserver
{
    [self.avPlayer removeTimeObserver:timeObserver];
    [self.timeObservers removeObject:timeObserver];
}

- (void)addPeriodTimeObserverForTick
{
    __weak typeof(self) weakSelf = self;
    [self addPeriodTimeObserverForInterval:0.5 block:^(NSTimeInterval timeInterval) {
        [weakSelf didTick];
    }];
}

- (void)didTick
{
    for (id<FPMoviePlayerDelegate> delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(moviePlayerDidTick:)]) {
            [delegate moviePlayerDidTick:self];
        }
    }
}

- (id)addPeriodTimeObserverForInterval:(NSTimeInterval)timeInterval block:(FPMoviePlayerPeriodTimeBlock)block
{
    CMTime cmTime = CMTimeMakeWithSeconds(timeInterval, kPreferredTimeScale);

    id timeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:cmTime
                                                                  queue:dispatch_get_main_queue()
                                                             usingBlock:^(CMTime time)
                       {
                           NSTimeInterval interval = CMTimeGetSeconds(time);
                           block(interval);
                       }];

    [self.timeObservers addObject:timeObserver];

    return timeObserver;
}

- (id)addBoundaryTimeObserverForTimes:(NSArray *)times block:(FPMoviePlayerBoundaryTimeBlock)block
{
    NSMutableArray *cmTimes = [NSMutableArray array];
    for (NSNumber *number in times) {
        CMTime cmTime = CMTimeMakeWithSeconds([number floatValue], kPreferredTimeScale);
        [cmTimes addObject:[NSValue valueWithCMTime:cmTime]];
    }

    return [self addBoundaryTimeObserverForCMTimes:cmTimes block:block];
}

- (id)addBoundaryTimeObserverForCMTimes:(NSArray *)cmTimes block:(FPMoviePlayerBoundaryTimeBlock)block
{
    id timeObserver = [self.avPlayer addBoundaryTimeObserverForTimes:cmTimes
                                                               queue:dispatch_get_main_queue()
                                                          usingBlock:block];

    [self.timeObservers addObject:timeObserver];

    return timeObserver;
}

@end
