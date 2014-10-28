//
//  FPMediaNetworkClient.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPBlockDef.h"

@interface FPMediaNetworkClient : NSObject

- (void)getMediaListWithSuccess:(FPArrayBlock)success failure:(FPErrorBlock)failure;

@end
