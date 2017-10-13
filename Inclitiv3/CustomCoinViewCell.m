//
//  CustomCoinViewCell.m
//  InclitiV2
//
//  Created by Claudia Liem on 1/10/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import "CustomCoinViewCell.h"

@implementation CustomCoinViewCell

@synthesize imgCoin = _imgCoin;
@synthesize nameCoin = _nameCoin;
@synthesize shortNameCoin = _shortNameCoin;
@synthesize priceButton = _priceButton;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
