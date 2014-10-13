//
//  EnquiryListViewController.m
//  sfdl
//
//  Created by boguang on 14-7-28.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "EnquiryListViewController.h"
#import "ProductRequest.h"
#import "CreateObject.h"
#import "ViewEnquiryViewContrller.h"

@interface EnquiryListViewController ()

@property (nonatomic, retain) EnquiryListRequest  *request;
@property (nonatomic, retain) EnquiryListResponse *response;

@end

@implementation EnquiryListViewController


- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showRight] setTitleContent:@"INQUIRY LIST"];
    [self sendRequestToServer];
}

- (IBAction)rightButtonAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) configTableView
{
    __block typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.contentView.backgroundColor = kWhiteColor;
            UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
            imageView.backgroundColor  = kClearColor;
            cell.backgroundView = imageView;
            
            cell.topLabel.frame = CGRectMake(4, 4, 170, 40);
            cell.topLabel.font = HTFONTSIZE(kFontSize14);
            cell.topLabel.numberOfLines = 2;
            cell.topLabel.textColor = cell.topLabel.textColor = kGrayColor;
            
            cell.subLabel.frame = CGRectMake(180, 4, 64, 40);
            cell.subLabel.font = HTFONTSIZE(kFontSize16);
            cell.subLabel.textAlignment = NSTextAlignmentCenter;
            cell.subLabel.numberOfLines = 2;
            cell.subLabel.textColor = cell.subLabel.textColor = kGrayColor;
            
            cell.rightLabel.frame = CGRectMake(254, 6, 64, 20);
            cell.rightLabel.font = HTFONTSIZE(kFontSize16);
            cell.rightLabel.textAlignment = NSTextAlignmentCenter;
            cell.rightLabel.numberOfLines = 1;
            cell.rightLabel.textColor = cell.rightLabel.textColor =  kGrayColor;
            
            cell.subRightLabel.frame = CGRectMake(254, 30, 64, 20);
            cell.subRightLabel.font = HTFONTSIZE(kFontSize12);
            cell.subRightLabel.textAlignment = NSTextAlignmentCenter;
            cell.subRightLabel.numberOfLines = 1;
            cell.subRightLabel.textColor = cell.subRightLabel.textColor = kLightGrayColor;
            
            CALayer *layer = [CALayer layer];
            layer.frame = CGRectMake(175, 0, 1, 50);
            layer.backgroundColor = [[UIColor getColor:@"EBEAF1"] CGColor];
            [cell.contentView.layer addSublayer:layer];
            
            layer = [CALayer layer];
            layer.frame = CGRectMake(250, 0, 1, 50);
            layer.backgroundColor = [[UIColor getColor:@"EBEAF1"] CGColor];
            [cell.contentView.layer addSublayer:layer];
            
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
            [cell.contentView addSubview:cell.rightLabel];
            [cell.contentView addSubview:cell.subRightLabel];
        }
        EnquiryItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.title;
        cell.subLabel.text = item.content;
        cell.rightLabel.text = [item.sendTime substringWithRange:NSMakeRange(11, 5)];
        cell.subRightLabel.text = [item.sendTime substringToIndex:10];
        cell.content = item;
        
        if (![item isItemReaded]) {
            cell.backgroundView.backgroundColor = kRedColor;
            cell.topLabel.textColor = kWhiteColor;
            cell.subLabel.textColor = kWhiteColor;
            cell.rightLabel.textColor = kWhiteColor;
            cell.subRightLabel.textColor = kWhiteColor;
        }
        else {
            cell.backgroundView.backgroundColor = kClearColor;
            cell.topLabel.textColor = kGrayColor;
            cell.subLabel.textColor = kGrayColor;
            cell.rightLabel.textColor = kGrayColor;
            cell.subRightLabel.textColor = kLightGrayColor;
        }
        
//        cell.topLabel.text = @"The different series of deutz gensets have different features";
//        cell.subLabel.text = @"user name";
//        cell.rightLabel.text = @"08:59";
//        cell.subRightLabel.text = @"2014-09-03";
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  50.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        EnquiryItem *item = [blockSelf.response at:indexPath.row ];
        item.readFlag = kEmptyString;
        ViewEnquiryViewContrller *controller = [[[ViewEnquiryViewContrller alloc] init] autorelease];
        controller.item = item;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
        [blockSelf.tableView reloadData];
        
    };
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf.request firstPage];
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        if (blockSelf.response && ![blockSelf.request isFristPage]) {
            [blockSelf sendRequestToServer];
        }
    };
    
    [self.view addSubview:self.tableView];
    
    [self.tableView doSendRequest:YES];
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
    __block typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        if ([_request isFristPage]) {
            blockSelf.response = [[EnquiryListResponse alloc] initWithJsonString:content];
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
        self.request = [[[EnquiryListRequest alloc] init] autorelease];
    }
    self.request.username = [UserDefaultsManager userName];
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

@end
