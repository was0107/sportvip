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


@interface BaseTableViewController : ShareTitleViewController

@property (nonatomic,retain) BaseTableView *tableView;


- (BOOL) useTablViewToShow;

-(void)refreshTableView;
@end
