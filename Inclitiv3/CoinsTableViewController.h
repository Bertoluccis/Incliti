//
//  CoinsTableViewController.h
//  InclitiV2
//
//  Created by Claudia Liem on 1/10/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinsTableViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *coinsList;
@property (nonatomic, retain) NSMutableArray *imagesURLs;
@property (nonatomic, retain) NSMutableArray *coinNames;
@property (nonatomic, retain) NSMutableArray *coinInfo;
@property (nonatomic, retain) NSMutableArray *coinPrice;
@property (strong, nonatomic) IBOutlet UITableView *tableViewCoins;

@end
