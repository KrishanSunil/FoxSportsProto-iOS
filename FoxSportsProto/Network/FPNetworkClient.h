//
//  FPNetworkClient.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

@import Foundation;
#import "FPBlockDef.h"

@interface FPNetworkClient : NSObject

+ (FPNetworkClient *)networkClient;
+ (FPNetworkClient *)fileNetworkClient;


- (void)get:(NSString *)urlString
 parameters:(NSDictionary *)parameters
    success:(FPAnyBlock)success
    failure:(FPErrorBlock)failure;

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
     success:(FPAnyBlock)success
     failure:(FPErrorBlock)failure;

- (void)delete:(NSString *)urlString
parameters:(NSDictionary *)parameters
success:(FPAnyBlock)success
failure:(FPErrorBlock)failure;

@end
