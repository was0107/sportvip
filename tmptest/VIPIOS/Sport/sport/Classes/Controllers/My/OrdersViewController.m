//
//  OrdersViewController.m
//  sport
//
//  Created by allen.wang on 5/20/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrderTableViewCell.h"

@interface OrdersViewController ()

@end

@implementation OrdersViewController


- (void) reduceMemory
{
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部",@"等待付款",@"等待确认", nil];
    if (self.isFinished) {
        array = [NSMutableArray arrayWithObjects:@"全部",@"交易完成",@"交易关闭", nil];
    }
    self.titleArray = array;
    self.currentIndex = 0;
    // Do any additional setup after loading the view.
}


- (void) didSelected:(NSUInteger ) index
{
    
}

- (void) configTableView
{
    __weak OrdersViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"SEARCH_TABLEVIEW_CELL_IDENTIFIER0";
        OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return (UITableViewCell *)cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  72.0f;
    };

    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return 11;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    self.tableView.refreshBlock = ^(id content) {
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    [self.view addSubview:self.tableView];
    
    [self dealWithData];
    
    //    [self.tableView doSendRequest:YES];
}

- (void) dealWithData
{
    //    self.tableView.didReachTheEnd = [_response lastPage];
    //    if ([self.response isEmpty]) {
    //        [self.tableView showEmptyView:YES];
    //    }
    //    else {
    //        [self.tableView showEmptyView:NO];
    //    }
    [self.tableView reloadData];
}


- (void) sendRequestToServer
{
    [self dealWithData];
}


@end
