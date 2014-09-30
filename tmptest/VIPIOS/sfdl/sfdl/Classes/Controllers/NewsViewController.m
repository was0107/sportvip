//
//  NewsViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailViewController.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "NewsTableViewCellEx.h"

@interface NewsViewController ()
@property (nonatomic, retain) NewsListRequest *request;
@property (nonatomic, retain) NewsResponse    *response;
@end

@implementation NewsViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showType] showRight];
//    self.secondTitleLabel.text = @"News";
    [self setTitleContent:@"NEWS"];

}

- (CGRect)tableViewFrame
{
    return kContentWithTabBarFrame;
}

- (int) tableViewType
{
    return  eTypeRefreshHeader | eTypeFooter;
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
            cell.contentView.backgroundColor = kWhiteColor;
        }
        [cell showLeft:(indexPath.row %2 != 0)];
        NewsItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.newsTitle;
        cell.rightLabel.text = [item.creationTime substringFromIndex:8];
        cell.subRightLabel.text = [item.creationTime substringToIndex:7];
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
        NewsItem *item = [blockSelf.response at:indexPath.row ];
        NewsDetailViewController *controller = [[[NewsDetailViewController alloc] init] autorelease];
        controller.newsList = [blockSelf.response result];
        controller.newItem = item;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
//        [controller setHidesBottomBarWhenPushed:YES];
        [blockSelf.navigationController pushViewController:controller animated:YES];
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
            blockSelf.response = [[NewsResponse alloc] initWithJsonString:content];
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
        self.request = [[[NewsListRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}


@end
