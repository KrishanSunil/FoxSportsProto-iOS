//
//  FPBaseModel+FPAdditions.h
//  FoxPlay
//
//  Created by Khoa Pham on 8/15/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseModel.h"

@interface FPBaseModel (FPAdditions)

+ (instancetype)fp_modelFromJSONDictionary:(NSDictionary *)JSONDictionary;
+ (NSArray *)fp_modelsFromJSONArray:(NSArray *)JSONArray;

@end
