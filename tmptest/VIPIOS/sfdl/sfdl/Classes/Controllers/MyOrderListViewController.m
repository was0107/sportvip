//
//  MyOrderListViewController.m
//  sfdl
//
//  Created by allen.wang on 6/30/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "ProductResponse.h"
#import "ProductRequest.h"
#import "MyOrderDetailViewController.h"

@interface MyOrderListViewController ()

@property (nonatomic, retain) OrdertListRequest *request;
@property (nonatomic, retain) OrdersResponse    *response;
@end

@implementation MyOrderListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"My order";
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (void) configTableView
{
    __block MyOrderListViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(15, 10, 100, 24);
            cell.subLabel.frame = CGRectMake(120, 10, 190, 24);
            cell.rightLabel.frame = CGRectMake(15, 34, 290, 24);
            cell.topLabel.textColor = kBlackColor;
            cell.subLabel.textColor = kLightGrayColor;
            cell.subLabel.textAlignment = NSTextAlignmentRight;
            cell.topLabel.font = cell.subLabel.font = cell.rightLabel.font = HTFONTSIZE(kFontSize15);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
            [cell.contentView addSubview:cell.rightLabel];
        }
        OrderItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.title;
        cell.subLabel.text = item.sendTime;
        cell.rightLabel.text = item.status;
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return [blockSelf.response arrayCount];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  64.0f;
    };
    
    self.tableView.cellEditBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        OrderItem *item = [blockSelf.response at:indexPath.row ];
        
        return  (2 == item.statusInt) ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
    };
    self.tableView.cellEditActionBlock = ^( UITableView *tableView, NSInteger editingStyle, NSIndexPath *indexPath){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            OrderItem *item = [blockSelf.response at:indexPath.row ];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            [blockSelf sendRequestToDeleteItem:item];
            [tableView reloadData];
        }
    };
    

    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf.request firstPage];
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        if (![blockSelf.request isFristPage]) {
            [blockSelf sendRequestToServer];
        }
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MyOrderDetailViewController *controller = [[[MyOrderDetailViewController alloc] init] autorelease];
        controller.item = [blockSelf.response at:indexPath.row];
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
    };
    
    [self.view addSubview:self.tableView];
}

- (void) dealWithData
{
    self.tableView.didReachTheEnd = [_response reachTheEnd];
    if ([self.response isEmpty]) {
        [self.tableView showEmptyView:YES];
    }
    else {
        [self.tableView showEmptyView:NO];
    }
    [self.tableView reloadData];
}


- (void) sendRequestToServer
{
    __block MyOrderListViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[OrdersResponse alloc] initWithJsonString:content];
        [blockSelf dealWithData];
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    if (!_request) {
        self.request = [[[OrdertListRequest alloc] init] autorelease];
    }
    self.request.username = [UserDefaultsManager userName];
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}


- (void) sendRequestToDeleteItem:(OrderItem *)item
{
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    DeleteOrderRequest *deleteRequest =  [[[DeleteOrderRequest alloc] init] autorelease];
    deleteRequest.username = [UserDefaultsManager userName];
    deleteRequest.orderId = item.orderId;
    [WASBaseServiceFace serviceWithMethod:[deleteRequest URLString] body:[deleteRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];

}


@end
