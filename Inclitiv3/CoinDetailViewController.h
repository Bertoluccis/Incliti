//
//  CoinDetailViewController.h
//  Inclitiv3
//
//  Created by 5848 on 3/10/2017.
//  Copyright © 2017 5848. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelCoinName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCoin;
@property (weak, nonatomic) IBOutlet UILabel *labelCoinPrice;



@property (nonatomic, strong) NSString *coin;
@property (nonatomic, strong) NSString *coinPrice;
@property (nonatomic, strong) UIImage *coinImage;

- (IBAction)openBuyUrl:(id)sender;
- (IBAction)openSellUrl:(id)sender;

@end
