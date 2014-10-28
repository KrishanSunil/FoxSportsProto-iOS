//
//  FPDeviceManagerService.m
//  FoxPlay
//
//  Created by Khoa Pham on 7/15/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPDeviceManagerService.h"
#import "FPDeviceManager.h"

@implementation FPDeviceManagerService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FPDeviceManager sharedManager] load];

    return YES;
}

@end
