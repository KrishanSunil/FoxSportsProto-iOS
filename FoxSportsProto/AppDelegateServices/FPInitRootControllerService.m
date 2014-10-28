//
//  FPInitRootControllerService.m
//  FoxPlay
//
//  Created by Huy Le on 5/21/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPInitRootControllerService.h"
#import "AppDelegate.h"
#import "FPHomeVC.h"
#import "UIViewController+FPAdditions.h"

#import <FLEX/FLEXManager.h>

@interface FPInitRootControllerService()

@end

@implementation FPInitRootControllerService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self appDelegate].window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIWindow *window = [self appDelegate].window;

    FPHomeVC *homeVC = [FPHomeVC fp_instantiatedFromStoryboardNamed:@"Home"];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    navC.navigationBarHidden = YES;
    window.rootViewController = navC;

    [window makeKeyAndVisible];

#if DEBUG
    //[[FLEXManager sharedManager] showExplorer];
#endif

    return YES;
}

- (AppDelegate *)appDelegate {
    return (id)[[UIApplication sharedApplication] delegate];
}

@end
