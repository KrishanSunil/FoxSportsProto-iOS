//
//  FPMedia.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPBaseModel.h"

@interface FPMedia : FPBaseModel

@property (nonatomic, strong) NSNumber *mediaID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) NSURL *streamURL;

@end
