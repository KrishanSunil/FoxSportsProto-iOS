//
//  FPEventTableViewCell.m
//  FoxSportsProto
//
//  Created by Khoa Pham on 10/23/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

#import "FPEventTableViewCell.h"
#import "FPEvent.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface FPEventTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;


@end

@implementation FPEventTableViewCell

- (void)awakeFromNib {
    self.contentView.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForModel:(FPEvent *)event
{
    [self.eventImageView setImageWithURL:event.imageURL];
    self.eventTimeLabel.text = [NSString stringWithFormat:@"%0.f'", event.matchTime.floatValue/60];
    self.eventDescriptionLabel.text = event.eventDescription;
}

@end
