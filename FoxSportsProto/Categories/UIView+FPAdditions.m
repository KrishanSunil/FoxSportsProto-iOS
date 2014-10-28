//
//  UIView+FPAdditions.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "UIView+FPAdditions.h"
#import "NSObject+FPAdditions.h"

@implementation UIView (FPAdditions)

+ (UINib *)fp_nib
{
    return [UINib nibWithNibName:[self fp_identifier] bundle:nil];
}


@end
