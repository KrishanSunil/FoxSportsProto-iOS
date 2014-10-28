//
//  FPEventTableViewCell.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPEvent;

@interface FPEventTableViewCell : UITableViewCell

- (void)configureForModel:(FPEvent *)event;

@end
