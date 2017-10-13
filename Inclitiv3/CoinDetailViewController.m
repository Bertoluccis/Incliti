//
//  CoinDetailViewController.m
//  Inclitiv3
//
//  Created by 5848 on 3/10/2017.
//  Copyright © 2017 5848. All rights reserved.
//

#import "CoinDetailViewController.h"

@interface CoinDetailViewController ()

@end


@implementation CoinDetailViewController

@synthesize labelCoinName;
@synthesize imgCoin;
@synthesize labelCoinPrice;
@synthesize coin;
@synthesize coinPrice;
@synthesize coinImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    labelCoinName.text = coin;
    labelCoinPrice.text = coinPrice;
    imgCoin.image = coinImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)openBuyUrl:(id)sender {
    //Opens external website of the new
    NSURL *url = [NSURL URLWithString:@"https://www.plus500.com.au"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (IBAction)openSellUrl:(id)sender {
    //Opens external website of the new
    NSURL *url = [NSURL URLWithString:@"https://www.markets.com.au/"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
