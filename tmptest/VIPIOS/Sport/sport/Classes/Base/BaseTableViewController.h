//
//  BaseTableViewController.h
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "BaseTableView.h"
#import "BaseTableViewCell.h"
#import "UIPopoverListView.h"
#import "PaggingItem.h"
#import "DataManager.h"


@interface BaseTableViewController : BaseTitleViewController
@property (nonatomic,retain) BaseTableView *tableView;
@property (nonatomic, retain) UIPopoverListView *poplistview ;

@property (nonatomic, assign) NSMutableArray *telArray;

-(void)refreshTableView;
@end
