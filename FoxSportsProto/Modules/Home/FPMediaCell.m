//
//  FPMediaCell.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/20/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPMediaCell.h"
#import "FPMedia.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface FPMediaCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation FPMediaCell

- (void)configureForModel:(FPMedia *)media
{
    self.nameLabel.text = media.name;
    [self.thumbnailImageView setImageWithURL:media.thumbnailURL];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        self.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
