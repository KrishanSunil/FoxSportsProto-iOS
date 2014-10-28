//
//  FPMediaCell.h
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FPMedia;

@interface FPMediaCell : UICollectionViewCell

- (void)configureForModel:(FPMedia *)media;

@end
