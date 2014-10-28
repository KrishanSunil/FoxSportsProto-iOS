//
//  FPNetworkClient.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPNetworkClient.h"
#import <AFNetworking/AFNetworking.h>

@interface FPNetworkClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation FPNetworkClient

+ (FPNetworkClient *)networkClient
{
    FPNetworkClient *client = [[FPNetworkClient alloc] init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    client.manager = manager;

    return client;
}

+ (FPNetworkClient *)fileNetworkClient
{
    FPNetworkClient *client = [[FPNetworkClient alloc] init];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    client.manager = manager;

    return client;
}

#pragma mark - Public Interface
- (void)get:(NSString *)urlString
 parameters:(NSDictionary *)parameters
    success:(FPAnyBlock)success
    failure:(FPErrorBlock)failure
{
    [self.manager GET:urlString
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)post:(NSString *)urlString
  parameters:(NSDictionary *)parameters
     success:(FPAnyBlock)success
     failure:(FPErrorBlock)failure
{
    [self.manager POST:urlString
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)delete:(NSString *)urlString
    parameters:(NSDictionary *)parameters
       success:(FPAnyBlock)success
       failure:(FPErrorBlock)failure {

    [self.manager DELETE:urlString
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}
@end
