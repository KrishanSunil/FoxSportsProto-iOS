//
//  NSObject+FPAdditions.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "NSObject+FPAdditions.h"

@implementation NSObject (FPAdditions)

+ (NSString *)fp_identifier
{
    return NSStringFromClass(self);
}

@end
