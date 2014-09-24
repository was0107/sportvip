//
//  AgentListViewController.m
//  sfdl
//
//  Created by Erlang on 14-6-15.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "AgentListViewController.h"
#import "AgentDetailViewController.h"
#import "ProductRequest.h"
#import "ProductResponse.h"

@interface AgentListViewController ()
@property (nonatomic, retain) AgentListRequest *request;
@property (nonatomic, retain) AgentResponse    *response;
@property (nonatomic, retain) NSMutableDictionary *diction;

@end

@implementation AgentListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"FIND YOUR DEALER"];
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
    self.diction = [NSMutableDictionary dictionary];
    __block AgentListViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
        BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame              = CGRectMake(10, 4, 100, 36);
            cell.topLabel.textColor          = kLightGrayColor;
            cell.topLabel.numberOfLines      = 1;
            cell.topLabel.textAlignment      = NSTextAlignmentRight;
            cell.topLabel.font               = HTFONTSIZE(kFontSize15);

            cell.subLabel.frame              = CGRectMake(115, 4, 185, 36);
            cell.subLabel.textColor          = kBlackColor;
            cell.subLabel.numberOfLines      = 0;
            cell.subLabel.font               = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
        }
        
        AgentItem *item = [blockSelf.response at:indexPath.section ];
        cell.topLabel.text = [item.keysArray objectAtIndex:indexPath.row];
        cell.subLabel.text = [item.valuesArray objectAtIndex:indexPath.row];
        return cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  44.0f;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        NSNumber *value = [self.diction objectForKey:kIntToString(section)];
        BOOL flag = YES;
        if (value) {
            flag = [value boolValue];
        } else {
            return 0;
        }
        return (flag) ? 7 : 0 ;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 46.0F;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section)
    {
        UIView *footerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 46)]autorelease];
        footerView.backgroundColor = kClearColor;
        UIView *footerView1 = [[[UIView alloc]initWithFrame:CGRectMake(0, 10, 320, 36)]autorelease];
        footerView1.backgroundColor = kOrangeColor;
        UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(20,0,280,36)] autorelease];
        label1.text = @"COMPANY";
        label1.font = HTFONTSIZE(kFontSize15);
        label1.textColor = kWhiteColor;
        [footerView1 addSubview:label1];
        footerView1.tag = 1000+ section;
        UIGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionGesture:)] autorelease];
        [footerView1 addGestureRecognizer:gesture];
        [footerView addSubview:footerView1];
        return footerView;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf.request firstPage];
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

- (void) sectionGesture:(UIGestureRecognizer *)recognizer
{
    NSUInteger section = recognizer.view.tag - 1000;
    NSNumber *value = [self.diction objectForKey:kIntToString(section)];
    BOOL flag = YES;
    if (value) {
        flag = ![value boolValue];
    }
    [self.diction setObject:[NSNumber numberWithBool:flag] forKey:kIntToString(section)];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
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
    __block AgentListViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        if ([_request isFristPage]) {
            blockSelf.response = [[AgentResponse alloc] initWithJsonString:content];
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
        self.request = [[[AgentListRequest alloc] init] autorelease];
    }
    self.request.name = self.name;
    self.request.productTypeId = self.typeItem.productTypeId;
    self.request.regionId = self.regionItem.regionId;
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}



@end
