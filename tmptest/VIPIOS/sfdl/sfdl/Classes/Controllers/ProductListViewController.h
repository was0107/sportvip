//
//  ProductListViewController.h
//  sfdl
//
//  Created by micker on 6/8/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "BaseSecondTitleViewController.h"
#import "ProductResponse.h"

@interface ProductListViewController : BaseSecondTitleViewController
@property (nonatomic, copy  ) NSString        *productTypeId;
@property (nonatomic, retain) ProductResponse *response;
@property (nonatomic, assign) ProductTypeItem *productItem;
@property (nonatomic, copy)   NSString        *sectionTitle;
@property (nonatomic, copy)   NSString        *searchText;
@end
