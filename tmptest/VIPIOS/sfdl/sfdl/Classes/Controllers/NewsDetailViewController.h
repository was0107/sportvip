//
//  NewsDetailViewController.h
//  sfdl
//
//  Created by micker on 6/8/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "BaseSecondTitleViewController.h"
#import "LoginResponse.h"

@interface NewsDetailViewController : BaseSecondTitleViewController
@property (nonatomic, assign) NewsItem *newItem;

@property (nonatomic, assign) NSMutableArray *newsList;
@end
