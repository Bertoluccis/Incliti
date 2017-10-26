//
//  GetDataApi.h
//  Inclitiv3
//
//  Created by user129339 on 10/26/17.
//  Copyright © 2017 5848. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDataApi : NSObject

@property (nonatomic) NSString *baseLinkUrl;
@property (nonatomic) NSString *coinUrl;
@property (nonatomic) NSString *completeUrl;
@property (nonatomic) NSError *error;

@end
