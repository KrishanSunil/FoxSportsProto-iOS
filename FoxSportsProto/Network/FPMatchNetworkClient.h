//
//  FPMatchNetworkClient.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPBlockDef.h"

@class FPMatch;
@class FPMedia;

typedef void (^FPMatchBlock)(FPMatch *match);

@interface FPMatchNetworkClient : NSObject

- (void)getMatchForMedia:(FPMedia *)media success:(FPMatchBlock)success failure:(FPErrorBlock)failure;

@end
