//
//  DidContactClassesViewController.m
//  sport
//
//  Created by allen.wang on 6/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "DidContactClassesViewController.h"
#import "PaggingRequest.h"
#import "PaggingResponse.h"
#import "STLocationInstance.h"
#import "TeacherTableViewCell.h"
#import "CheckClassTableViewCell.h"
#import "TeacherViewController.h"

@interface DidContactClassesViewController ()

@property (nonatomic, retain) CheckCoachesRequest *coachesRequest;
@property (nonatomic, retain) CoachsResponse *coachesResponse;
@end

@implementation DidContactClassesViewController

- (void) dealloc
{
    TT_RELEASE_SAFELY(_coachesResponse);
    TT_RELEASE_SAFELY(_coachesRequest);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackViewId = @"已经联系过的教练页面";
    // Do any additional setup after loading the view.
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight);
}

- (void) configTableView
{
    __block DidContactClassesViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier1 = @"HOME_TABLEVIEW_CELL_IDENTIFIER1";
        TeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell){
            cell = [[[TeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1] autorelease];
        }
        [cell configWithType:0];
        CoacheItem *item = [blockSelf.coachesResponse at:indexPath.row];
        [cell configWithData:item];
        return (UITableViewCell *)cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  (CGFloat)(110.0f);
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.coachesResponse arrayCount];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return (CGFloat)0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TeacherViewController *controller = [[[TeacherViewController alloc] init] autorelease];
        CoacheItem *item = [blockSelf.coachesResponse at:indexPath.row];
        controller.item = item;
        [controller setHidesBottomBarWhenPushed:YES];
        [blockSelf.navigationController pushViewController:controller animated:YES];
    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf.coachesRequest firstPage];
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
    self.tableView.didReachTheEnd = [_coachesResponse lastPage];
    if ([self.coachesResponse isEmpty]) {
        [self.tableView showEmptyView:YES];
    }
    else {
        [self.tableView showEmptyView:NO];
    }
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (CheckCoachesRequest *) coachesRequest
{
    if (!_coachesRequest) {
        _coachesRequest = [[CheckCoachesRequest alloc] init];
    }
    return _coachesRequest;
}

- (void) startLocation
{
    __block DidContactClassesViewController *blockSelf = self;
    [STLocationInstance sharedInstance].placeBlock = ^(id place) {
        CLPlacemark *placemark = (CLPlacemark *) place;
        blockSelf.coachesRequest.longitude = placemark.location.coordinate.longitude;
        blockSelf.coachesRequest.latitude = placemark.location.coordinate.latitude;
        [SVProgressHUD showSuccessWithStatus:@"定位成功"];
        [blockSelf sendRequestToServer];
    };
}


- (void) sendRequestToServer
{
    if (![STLocationInstance sharedInstance].checkinLocation) {
        [SVProgressHUD showWithOnlyStatus:@"正在定位..." duration:30];
        [self startLocation];
        return;
    }
    
    __block DidContactClassesViewController *blockSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succeed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        if ([_coachesRequest isFristPage]) {
            blockSelf.coachesResponse = [[[CoachsResponse alloc] initWithJsonString:content] autorelease];
        } else {
            [blockSelf.coachesResponse appendPaggingFromJsonString:content];
        }
        [_coachesRequest nextPage];
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
    self.coachesRequest.userId = [self currentUserId];
    self.coachesRequest.longitude = [STLocationInstance sharedInstance].checkinLocation.coordinate.longitude;
    self.coachesRequest.latitude = [STLocationInstance sharedInstance].checkinLocation.coordinate.latitude;
    [WASBaseServiceFace serviceWithMethod:[self.coachesRequest URLString] body:[self.coachesRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}
@end
