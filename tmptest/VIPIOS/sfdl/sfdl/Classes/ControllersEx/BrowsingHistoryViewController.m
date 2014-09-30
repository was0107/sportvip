//
//  BrowsingHistoryViewController.m
//  sfdl
//
//  Created by boguang on 14-9-15.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "BrowsingHistoryViewController.h"
#import "NewsTableViewCellEx.h"

#import "ProductRequest.h"
#import "ProductResponse.h"
@interface BrowsingHistoryViewController ()

@property (nonatomic, retain) BrowsingHistoryListRequest  *request;
@property (nonatomic, retain) BrowsingHistoryListResponse *response;
@end

@implementation BrowsingHistoryViewController


- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    [super reduceMemory];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"BROWSING HISTORY"];

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
            cell.contentView.backgroundColor = kWhiteColor;
            [cell configWithType:0];
        }
        
        [cell showLeft:(indexPath.row %2 != 0)];
        HistoryItem *item = (HistoryItem *) [blockSelf.response at:indexPath.row];
        [cell setContent:item];
        return cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  50.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        NSString *controller = controllerIndexArray[indexPath.row];
//        Class class = NSClassFromString(controller);
//        BaseTitleViewController *vc1 = [[[class alloc] init] autorelease];
//        [blockSelf.navigationController hidesBottomBarWhenPushed];
//        [blockSelf.navigationController pushViewController:vc1 animated:YES];
    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf.request firstPage];
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        if (blockSelf.request  && ![blockSelf.request isFristPage]) {
            [blockSelf sendRequestToServer];
        }
    };
    
    [self.view addSubview:self.tableView];
    
    [self sendRequestToServer];
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
        if ([_request isFristPage]) {
            blockSelf.response = [[BrowsingHistoryListResponse alloc] initWithJsonString:content];
        } else {
            [blockSelf.response appendPaggingFromJsonString:content];
        }
        [_request nextPage];
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
        self.request = [[[BrowsingHistoryListRequest alloc] init] autorelease];
    }
    self.request.username = [self currentUserId];
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}



@end
