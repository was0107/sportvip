//
//  InquiryViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "InquiryViewControllerEx.h"
#import "NewsTableViewCellEx.h"
#import "InquiryDetailViewController.h"
#import "ProductResponse.h"
#import "ProductRequest.h"

@interface InquiryViewControllerEx ()

@property (nonatomic, retain) OrdertListRequest *request;
@property (nonatomic, retain) OrdersResponse    *response;
@end

@implementation InquiryViewControllerEx

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"INQUIRY"];
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (CGRect)tableViewFrame
{
    return kContentWithTabBarFrame;
}

- (void) configTableView
{
    __unsafe_unretained typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
        NewsTableViewCellEx *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[NewsTableViewCellEx alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            [cell configWithType:0];
        }
        
        [cell showLeft:(indexPath.row %2 != 0)];
        OrderItem *item = [blockSelf.response at:indexPath.row ];
        [cell setContent:item];
        return cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  50.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
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
        InquiryDetailViewController *controller = [[[InquiryDetailViewController alloc] init] autorelease];
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
    __unsafe_unretained typeof(self) blockSelf = self;
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
