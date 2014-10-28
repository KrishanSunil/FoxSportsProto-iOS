//
//  FPMatch+FPScore.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMatch.h"

@interface FPMatch (FPScore)

- (NSInteger)scoreForTeam:(FPTeam *)team until:(NSTimeInterval)time;

@end
