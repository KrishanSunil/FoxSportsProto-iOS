//
//  FPAFNetworkingService.m
//  FoxPlay
//
//  Created by Phat, Le Tan on 7/4/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPAFNetworkingService.h"
#import <UIKit+AFNetworking.h>

@implementation FPAFNetworkingService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    return YES;
}

@end
