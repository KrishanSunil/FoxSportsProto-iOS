//
//  FPDeviceManager.m
//  FoxPlay
//
//  Created by Khoa Pham on 7/15/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPDeviceManager.h"
@import UIKit;

static NSString *const kDeviceIDKey = @"kDeviceIDKey";
static NSString *const kDeviceNameKey = @"kDeviceNameKey";

@interface FPDeviceManager ()

@property (nonatomic, copy, readwrite) NSString *deviceID;
@property (nonatomic, copy, readwrite) NSString *deviceName;

@end

@implementation FPDeviceManager

+ (instancetype)sharedManager
{
    static FPDeviceManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FPDeviceManager alloc] init];
    });

    return instance;
}

- (void)load
{
    // DeviceID and name are mean to be generated once
    [self loadDeviceID];
    [self loadDeviceName];
}

#pragma mark - Helper
- (void)loadDeviceID
{
    NSString *deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceIDKey];
    if (!deviceID) {
        deviceID = [[NSUUID UUID] UUIDString];
        deviceID = [deviceID stringByAppendingString:@"-ios"];

        [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:kDeviceIDKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.deviceID = deviceID;
}

- (void)loadDeviceName
{
    self.deviceName = [[UIDevice currentDevice] name];
}


@end
