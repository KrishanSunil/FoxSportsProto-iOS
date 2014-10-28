//
//  FPEvent.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseModel.h"

typedef NS_ENUM(NSUInteger, FPEventType) {
    FPEventTypeUnknown,
    FPEventTypeGoal,
    FPEventTypeRedCard,
    FPEventTypeYellowCard,
    FPEventTypeSubstitution,
};

@interface FPEvent : FPBaseModel

@property (nonatomic, strong) NSNumber *eventID;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, strong) NSNumber *matchTime;
@property (nonatomic, assign) FPEventType eventType;
@property (nonatomic, strong) NSNumber *teamID;
@property (nonatomic, strong) NSURL *imageURL;

+ (NSDictionary *)eventTypeMapping;
- (NSString *)eventDescription;
- (NSString *)eventIconName;


@end
