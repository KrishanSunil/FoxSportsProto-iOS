//
//  FPTeam.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseModel.h"

@interface FPTeam : FPBaseModel

@property (nonatomic, strong) NSNumber *teamID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, strong) NSURL *logoURL;

@end
