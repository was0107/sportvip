//
//  AgentListViewController.h
//  sfdl
//
//  Created by Erlang on 14-6-15.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "BaseSecondTitleViewController.h"
#import "ProductRequest.h"
#import "ProductResponse.h"

@interface AgentListViewController : BaseSecondTitleViewController

@property (nonatomic, assign) ProductTypeItem    *typeItem;
@property (nonatomic, assign) RegionItem         *regionItem;
@property (nonatomic, copy)  NSString            *name;

@end
