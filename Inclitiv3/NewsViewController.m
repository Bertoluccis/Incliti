//
//  NewsViewController.m
//  InclitiV2
//
//  Created by Claudia Liem on 30/09/2017.
//  Copyright © 2017 Julio Bertolucci. All rights reserved.
//

#import "NewsViewController.h"
#import "CustomCell.h"

@interface NewsViewController ()
@property (strong,  nonatomic) NSArray *imagesURLs;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"News";
    
    [self refreshImages];
    
    [self loadNews];
    
    // Remove empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadNews{
    
    NSError *error;
    
    NSMutableArray *news = [[NSMutableArray alloc] init];
    
    NSString *url_string = [NSString stringWithFormat: @"https://newsapi.org/v1/articles?source=abc-news-au&sortBy=top&apiKey=d1b0cce3fea14c819a7c3291660f3b0a"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray  *dataJson = [json valueForKey:@"articles"];
    
    for (id tempObject in dataJson) {
        [news addObject:tempObject];
    }
    
    self.newsArray = [[NSArray alloc] initWithArray:news];
    
    [self.tableView reloadData];
    
}

//Process de request and parse JSON into dictionary
- (void)refreshImages {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://newsapi.org/v1/articles?source=abc-news-au&sortBy=top&apiKey=d1b0cce3fea14c819a7c3291660f3b0a"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //articles array > urlToImage
        self.imagesURLs = [dictionary valueForKeyPath:@"articles.urlToImage"];
        
        [self.tableView reloadData];
        
    }];
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    //Opens external website of the new
    NSURL *url = [NSURL URLWithString:[self.newsArray[indexPath.row] valueForKey:@"url"]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *customCellIdentifier = @"SimpleTableCell";
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //Configure title and news description
    cell.titleLabel.text = [self.newsArray[indexPath.row] valueForKey:@"title"];
    cell.descNewsLabel.text = [self.newsArray[indexPath.row] valueForKey:@"description"];
    
    //Configure the images
    NSString *urlString = self.imagesURLs[indexPath.row];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *imgNews = [[UIImage alloc] initWithData:imageData];
    cell.imageNews.image = imgNews;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end


/*
 //"https://www.parsehub.com/api/v2/projects/tqpJpb7K-idZ/last_ready_run/data"
 //d1b0cce3fea14c819a7c3291660f3b0a
 //https://newsapi.org/v1/articles?source=abc-news-au&sortBy=top&apiKey=d1b0cce3fea14c819a7c3291660f3b0a
 NSMutableArray *api_param = [[NSMutableArray alloc] init];
 [api_param addObject:@"'api_key': 'tTTbwn5-5bfu'"];
 
 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 [manager GET:@"https://newsapi.org/v1/articles?source=abc-news-au&sortBy=top&apiKey=d1b0cce3fea14c819a7c3291660f3b0a" parameters:nil */
