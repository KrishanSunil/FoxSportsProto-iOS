//
//  FPDeviceManager.h
//  FoxPlay
//
//  Created by Khoa Pham on 7/15/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

@import Foundation;

@interface FPDeviceManager : NSObject

@property (nonatomic, copy, readonly) NSString *deviceID;
@property (nonatomic, copy, readonly) NSString *deviceName;

+ (instancetype)sharedManager;
- (void)load;

@end
