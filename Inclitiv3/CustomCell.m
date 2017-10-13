//
//  CustomCellTableViewCell.m
//  InclitiV2
//
//  Created by Claudia Liem on 30/09/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize titleLabel = _titleLabel;
@synthesize descNewsLabel = _descNewsLabel;
@synthesize imageNews = _imageNews;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
