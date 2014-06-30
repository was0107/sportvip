//
//  DidCheckClassesViewController.m
//  sport
//
//  Created by allen.wang on 6/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "DidCheckClassesViewController.h"
#import "ClassTableViewCell.h"
#import "TeacherTableViewCell.h"
#import "TeacherViewController.h"
#import "CheckClassTableViewCell.h"
#import "PaggingRequest.h"
#import "PaggingResponse.h"

@interface DidCheckClassesViewController ()

@property (nonatomic, retain) CheckClassesRequest *request;
@property (nonatomic, retain) CheckClassesResponse *response;
@end

@implementation DidCheckClassesViewController


- (void) dealloc
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackViewId = @"已经查看课程的页面";
    // Do any additional setup after loading the view.
}


- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight);
}

- (void) configTableView
{
    __block DidCheckClassesViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
       
        static NSString *identifier1 = @"HOME_TABLEVIEW_CELL_IDENTIFIER1";
        CheckClassTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell1){
            cell1 = [[CheckClassTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        [cell1 configWithType:0];
        CheckClassItem *classItem = [blockSelf.response at:indexPath.row];
        [cell1 configWithData:classItem];
        return (UITableViewCell *)cell1;

    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  (CGFloat)110.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response count];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return (CGFloat)0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TeacherViewController *controller = [[[TeacherViewController alloc] init] autorelease];
        CheckClassItem *classItem = [blockSelf.response at:indexPath.row];
        CoacheItem *coachItem = [[[CoacheItem alloc] init] autorelease];
        coachItem.itemId = classItem.coachId;
        coachItem.name = classItem.coachName;
        controller.item = coachItem;
        [controller setHidesBottomBarWhenPushed:YES];
        [blockSelf.navigationController pushViewController:controller animated:YES];

    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf.request firstPage];
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    [self.view addSubview:self.tableView];
    
    [self sendRequestToServer];
}


- (void) dealWithData
{
    self.tableView.didReachTheEnd = [_response lastPage];
    if ([self.response isEmpty]) {
        [self.tableView showEmptyView:YES];
    }
    else {
        [self.tableView showEmptyView:NO];
    }
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (CheckClassesRequest *) request
{
    if (!_request) {
        _request = [[CheckClassesRequest alloc] init];
    }
    return _request;
}


- (void) sendRequestToServer
{
    __block DidCheckClassesViewController *blockSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succeed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        if ([_request isFristPage]) {
            blockSelf.response = [[[CheckClassesResponse alloc] initWithJsonString:content] autorelease];
        } else {
            [blockSelf.response appendPaggingFromJsonString:content];
        }
        [_request nextPage];
        [blockSelf dealWithData];
        [SVProgressHUD dismiss];
    };
    
    idBlock failedBlock = ^(id content) {
        DEBUGLOG(@"failed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        [SVProgressHUD dismiss];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        [SVProgressHUD dismiss];
    };
    self.request.userId = [self currentUserId];
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

@end
