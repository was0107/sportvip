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

@interface NewsViewController ()
@property (nonatomic, retain) NewsListRequest *request;
@property (nonatomic, retain) NewsResponse    *response;
@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"News";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) tableViewType
{
    return  eTypeRefreshHeader | eTypeFooter;
}

- (void) configTableView
{
    __block NewsViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
        BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(10, 4, 300, 20);
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.numberOfLines = 1;
            cell.topLabel.font = HTFONTSIZE(kFontSize17);
            
            cell.subLabel.frame = CGRectMake(10, 24, 300, 40);
            cell.subLabel.textColor = kBlackColor;
            cell.subLabel.numberOfLines = 2;
            cell.subLabel.font = HTFONTSIZE(kFontSize15);
            
            cell.subRightLabel.frame = CGRectMake(180, 58, 130, 20);
            cell.subRightLabel.textAlignment = UITextAlignmentRight;
            cell.subRightLabel.textColor = kBlackColor;
            cell.subRightLabel.font = HTFONTSIZE(kFontSize13);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
            [cell.contentView addSubview:cell.subRightLabel];
        }
        
        NewsItem *item = [blockSelf.response at:indexPath.row ];

        cell.topLabel.text = item.newsTitle;
        cell.subLabel.text = item.abstract;
        cell.subRightLabel.text = item.creationTime;
        [cell.subRightLabel sizeThatFits:CGSizeMake(300, 40)];
        return cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  80.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return [blockSelf.response arrayCount];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NewsItem *item = [blockSelf.response at:indexPath.row ];
        NewsDetailViewController *controller = [[[NewsDetailViewController alloc] init] autorelease];
        controller.newItem = item;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    [self.view addSubview:self.tableView];
    
//    [self dealWithData];
    [self sendRequestToServer];
    
//       [self.tableView doSendRequest:YES];
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
    __weak NewsViewController *blockSelf = self;
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