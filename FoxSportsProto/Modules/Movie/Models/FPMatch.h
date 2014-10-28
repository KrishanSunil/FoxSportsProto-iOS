//
//  FPMatch.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseModel.h"

@class FPTeam;

@interface FPMatch : FPBaseModel

@property (nonatomic, strong) NSNumber *matchID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *startTimeH1;
@property (nonatomic, strong) NSNumber *startTimeH2;
@property (nonatomic, strong) FPTeam *teamA;
@property (nonatomic, strong) FPTeam *teamB;
@property (nonatomic, strong) NSArray *events;

@end
