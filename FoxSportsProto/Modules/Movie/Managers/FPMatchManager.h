//
//  FPMatchManager.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FPMatchManager;
@class FPMedia;
@class FPMatch;

@protocol FPMatchManagerDelegate <NSObject>

@optional
- (void)matchManagerDidUpdateMatch:(FPMatch *)match;

@end

@interface FPMatchManager : NSObject

- (instancetype)initWithMedia:(FPMedia *)media;
- (void)addDelegate:(id<FPMatchManagerDelegate>)delegate;

- (void)pullMatch;

@end
