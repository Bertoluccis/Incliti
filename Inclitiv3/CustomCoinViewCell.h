//
//  CustomCoinViewCell.h
//  InclitiV2
//
//  Created by Claudia Liem on 1/10/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCoinViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgCoin;
@property (weak, nonatomic) IBOutlet UILabel *nameCoin;
@property (weak, nonatomic) IBOutlet UILabel *shortNameCoin;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end
