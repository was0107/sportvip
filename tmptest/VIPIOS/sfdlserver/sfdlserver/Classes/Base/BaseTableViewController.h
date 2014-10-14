//
//  BaseTableViewController.h
//  Discount
//
//  Created by micker on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "BaseTableView.h"
#import "BaseTableViewCell.h"


@interface BaseTableViewController : BaseTitleViewController

@property (nonatomic,retain) BaseTableView *tableView;


- (BOOL) useTablViewToShow;

-(void)refreshTableView;
@end
