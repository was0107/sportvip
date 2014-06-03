//
//  BaseTableViewController.m
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
@synthesize tableView = _tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IOS_7_OR_GREATER) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self configEmptyTipsView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    [self configTableView];
    [self.view addSubview:self.tableView];
    if (IS_IOS_7_OR_GREATER){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }


}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_tableView);
    [super reduceMemory];
}

- (int) tableViewType
{
    return eTypeRefreshHeader | eTypeFooter;
}

- (CGRect) tableViewFrame
{
    return kContentFrame;
}

- (int) tableviewStyle
{
    if (IS_IOS_7_OR_GREATER)
	{
	return  UITableViewStyleGrouped;
	}
    else
	{
	return UITableViewStylePlain;
	}
}

- (BaseTableView *) tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:[self tableViewFrame] style:[self tableviewStyle] type:[self tableViewType] delegate:nil];
        _tableView.rowHeight = 44.0f;
        _tableView.parentView = self.view;
        _tableView.backgroundColor = kClearColor;
        _tableView.backgroundView = nil;
        _tableView.tableFooterView = nil;
        _tableView.tableHeaderView = nil;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (void) configTableView
{
    DEBUGLOG(@"configTableView");
    //    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
    //        };
    //
    //    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
    //    };
    //
    //    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
    //    };
    //
    //    self.tableView.cellEditBlock = ^(UITableView *tableView, NSIndexPath *indexPath)
    //    {
    //    };
    //
    //    self.tableView.cellEditActionBlock = ^(UITableView *tableView, NSInteger editingStyle, NSIndexPath *indexPath){
    //
    //    };
    //
    //    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
    //
    //    };
    //
    //    self.tableView.refreshBlock = ^(id content) {
    //    };
    //
    //    self.tableView.loadMoreBlock = ^(id content) {
    //
    //    };
}

-(void) configEmptyTipsView
{

}

-(void)refreshTableView
{
    self.tableView.refreshBlock(nil);
}
@end
