//
//  FPTimelineView.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/22/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPTimelineView;
@class FPMatch;

@protocol FPTimelineViewDelegate <NSObject>

@optional
- (void)timelineView:(FPTimelineView *)timelineView didSelectTime:(NSTimeInterval)time position:(CGPoint)position;

@end

@interface FPTimelineView : UIView

@property (nonatomic, weak) id<FPTimelineViewDelegate> delegate;

- (void)updateForMatch:(FPMatch *)match mediaDuration:(NSTimeInterval)duration;

@end
