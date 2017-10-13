//
//  CoinsTableViewController.m
//  InclitiV2
//
//  Created by Claudia Liem on 1/10/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import "CoinsTableViewController.h"
#import "CustomCoinViewCell.h"
#import "CoinDetailViewController.h"

@interface CoinsTableViewController ()

@end

@implementation CoinsTableViewController

@synthesize coinsList;
@synthesize imagesURLs;
@synthesize coinNames;
@synthesize coinInfo;
@synthesize coinPrice;
@synthesize tableViewCoins = _tableViewCoins;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Coins";
    
    [self loadCoins];
    
    [self loadCoinInfo];
    
    // Remove empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}


- (void)loadCoins{
    
    NSString *baseLinkUrl = [NSString stringWithFormat:@"https://www.cryptocompare.com"];
    NSString *coinUrl = [[NSString alloc] init];
    NSString *completeUrl = [[NSString alloc] init];
    NSError *error;
    
    NSString *url_string = [NSString stringWithFormat: @"https://www.cryptocompare.com/api/data/coinlist/"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray  *dataJson = [json valueForKey:@"Data"];
    
    NSMutableArray  *tmpImg = [[NSMutableArray alloc] init];
    NSMutableArray  *tmpCoinName = [[NSMutableArray alloc] init];
    NSMutableArray  *tmpName = [[NSMutableArray alloc] init];
    //NSMutableArray  *tmpNameTop5 = [[NSMutableArray alloc] init];
    
    for (id key in dataJson) {
        
        //NSDictionary *coinsss = [dataJson valueForKey:key];
        
        if([[[dataJson valueForKey:key] valueForKey:@"Name"] isEqualToString:@"BTC"] ||
           [[[dataJson valueForKey:key] valueForKey:@"Name"] isEqualToString:@"ETH"] ||
           [[[dataJson valueForKey:key] valueForKey:@"Name"] isEqualToString:@"XRP"] ||
           [[[dataJson valueForKey:key] valueForKey:@"Name"] isEqualToString:@"BCH"] ||
           [[[dataJson valueForKey:key] valueForKey:@"Name"] isEqualToString:@"LTC"]){
            
            //URL IMage
            coinUrl  = [[dataJson valueForKey:key] valueForKey:@"ImageUrl"];
            completeUrl = baseLinkUrl;
            [tmpImg addObject:[completeUrl stringByAppendingString:coinUrl]];
            coinUrl = @"";
            
            //Name
            [tmpCoinName addObject:[[dataJson valueForKey:key] valueForKey:@"CoinName"]];
            
            //Short Name
            [tmpName addObject:[[dataJson valueForKey:key] valueForKey:@"Name"]];
            
        }
        
    }
    
    
    self.coinNames = [[NSMutableArray alloc] initWithArray:tmpCoinName];
    self.coinsList = [[NSMutableArray alloc] initWithArray:tmpName];
    self.imagesURLs = [[NSMutableArray alloc] initWithArray:tmpImg];
    
    //self.coinsTop5 = [[NSMutableArray alloc] initWithArray:tmpNameTop5];

}

//Process de request and parse JSON into dictionary
- (void)loadCoinInfo {
    //Example of requexst https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=BTC,USD,EUR
    
    self.coinPrice = [[NSMutableArray alloc] init];
    
    if(coinsList.count > 0){
        NSString *linkUrl1 = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym="];
        NSString *linkUrl2 = [NSString stringWithFormat:@"&tsyms=BTC,USD,AUD"];
        NSMutableString *linkUrlAux = [[NSMutableString alloc] init];
        NSMutableArray  *tmpPrices = [[NSMutableArray alloc] init];
        
        NSError *error;
        
        //Download Prices
        //FIX FIX FIX FIX FIX FIX FIX FIX FIX  FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX FIX
        for(NSString *key in coinsList){
            [linkUrlAux appendString:linkUrl1];
            [linkUrlAux appendString:key];
            [linkUrlAux appendString:linkUrl2];
            
            NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:linkUrlAux]];
            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            [tmpPrices addObject:json];
            [linkUrlAux setString:@""];
        }
        self.coinPrice = [[NSMutableArray alloc] initWithArray:tmpPrices];
        
    }else{
        NSLog(@"Cound not load prices.");
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.coinNames count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *customCellIdentifier = @"CustomViewCell";
    
    CustomCoinViewCell *cell = (CustomCoinViewCell *)[self.tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //Configure title and news description
    cell.nameCoin.text = self.coinsList[indexPath.row];
    cell.shortNameCoin.text = self.coinNames[indexPath.row];
    
    NSMutableString *finalPrice = [[NSMutableString alloc] init];
    NSString *coinprice = [NSString stringWithFormat:@"%@", [self.coinPrice[indexPath.row] valueForKey:@"AUD"]];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    float value = [numberFormatter numberFromString:coinprice].floatValue;
    NSMutableString* priceRouded = [NSMutableString stringWithFormat:@"%.4f", value];
    
    [finalPrice appendString:@"A$"];
    [finalPrice appendString:priceRouded];

    [cell.priceButton setTitle:finalPrice forState:UIControlStateNormal];
    
    
    //Configure the images
    NSString *urlString = self.imagesURLs[indexPath.row];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *imgNews = [[UIImage alloc] initWithData:imageData];
    cell.imgCoin.image = imgNews;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCoinDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CoinDetailViewController *destViewController = segue.destinationViewController;
        
        //Name
        destViewController.coin = [self.coinNames objectAtIndex:indexPath.row];
        
        
        //Price
        NSMutableString *finalPrice = [[NSMutableString alloc] init];
        NSString *coinprice = [NSString stringWithFormat:@"%@", [self.coinPrice[indexPath.row] valueForKey:@"AUD"]];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        float value = [numberFormatter numberFromString:coinprice].floatValue;
        NSMutableString* priceRouded = [NSMutableString stringWithFormat:@"%.4f", value];
        
        [finalPrice appendString:@"A$"];
        [finalPrice appendString:priceRouded];
        destViewController.coinPrice = finalPrice;
        
        //Image
        //Configure the images
        NSString *urlString = self.imagesURLs[indexPath.row];
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *imgCoin = [[UIImage alloc] initWithData:imageData];
        destViewController.coinImage = imgCoin;
        
        
        [self.tableView reloadData];
    }
}

@end
