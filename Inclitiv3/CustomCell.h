//
//  CustomCellTableViewCell.h
//  InclitiV2
//
//  Created by Claudia Liem on 30/09/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descNewsLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageNews;

@end
