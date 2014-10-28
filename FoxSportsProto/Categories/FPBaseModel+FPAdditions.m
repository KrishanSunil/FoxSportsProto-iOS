//
//  FPBaseModel+FPAdditions.m
//  FoxPlay
//
//  Created by Khoa Pham on 8/15/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseModel+FPAdditions.h"

@implementation FPBaseModel (FPAdditions)

+ (instancetype)fp_modelFromJSONDictionary:(NSDictionary *)JSONDictionary
{
    NSError *error;
    return [MTLJSONAdapter modelOfClass:self fromJSONDictionary:JSONDictionary error:&error];
}

+ (NSArray *)fp_modelsFromJSONArray:(NSArray *)JSONArray
{
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:JSONArray error:nil];
}

@end
