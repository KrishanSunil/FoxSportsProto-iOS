//
//  FPEventPopupVC.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPEvent;

@protocol FPEventPopupVCDelegate <NSObject>

- (void)eventPopupVCDidSelectEvent:(FPEvent *)event;
- (void)eventPopupVCDidChangeHeight:(CGFloat)height;

@end

@interface FPEventPopupVC : UIViewController

@property (nonatomic, weak) id<FPEventPopupVCDelegate> delegate;

- (void)updateForEvents:(NSArray *)events;

@end
