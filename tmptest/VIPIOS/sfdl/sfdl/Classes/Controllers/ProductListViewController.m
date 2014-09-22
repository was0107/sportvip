//
//  ProductListViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductDetailViewController.h"
#import "ProductCart.h"
#import "ProductRequest.h"
#import "CreateObject.h"
#import "CustomThreeButton.h"
#import "ProductCartViewController.h"

@interface ProductListViewController ()

@property (nonatomic, retain) ProductListRequest *request;
@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"PRODUCT"];

    if (!self.productTypeId) {
        [self dealWithData];
        [self.tableView tableViewDidFinishedLoading];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight-0);
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __block ProductListViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.separatorColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = kClearColor;
            cell.backgroundColor = kClearColor;
            CustomTwoButton *button1 = [[[CustomTwoButton alloc] initWithFrame:CGRectMake(0, 0, 159.5f, 180)] autorelease];
            CustomTwoButton *button2 = [[[CustomTwoButton alloc] initWithFrame:CGRectMake(160.5f, 0, 159.5f, 180)] autorelease];
            
            [cell.contentView addSubview:button1];
            [cell.contentView addSubview:button2];
            
            button1.tag = 1000 + 0;
            button2.tag = 1000 + 1;
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(159.5f, 0, 1, 180)] autorelease];
            lineView.backgroundColor = kGrayColor;
            lineView.alpha = 0.3f;
            [cell.contentView addSubview:lineView];
        }
        NSMutableArray *array = [blockSelf.response result];
        for (int i =0 ; i < 2 ; i++) {
            CustomTwoButton *button = (CustomTwoButton *)[cell.contentView viewWithTag:1000+i];
            if (indexPath.row * 2 + i < [array count]) {
                HomeProductItem *item = [array objectAtIndex:indexPath.row * 2 + i];
                [button setContent:item];
                [button setHidden:NO];
            } else {
                [button setHidden:YES];
            }
            
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)([blockSelf.response arrayCount] + 1 ) / 2;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  190.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 52.0f;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        UIView *headerview = nil;
        headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
        headerview.backgroundColor = kClearColor;
        UILabel *titL = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 320, 36)];
        titL.text = [NSString stringWithFormat:@"    %@",self.sectionTitle];
        titL.textColor = kBlackColor;
        titL.backgroundColor = [UIColor whiteColor];
        titL.font = [UIFont boldSystemFontOfSize:15];
        [headerview addSubview:titL];
        return headerview;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        ProductItem *item = [blockSelf.response at:indexPath.row ];
//        ProductDetailViewController *controller = [[[ProductDetailViewController alloc] init] autorelease];
////        controller.secondTitleLabel.text = item.productName;
//        controller.productItem = item;
//        [blockSelf.navigationController hidesBottomBarWhenPushed];
//        [blockSelf.navigationController pushViewController:controller animated:YES];
        
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
    
    if (self.productTypeId) {
//        [self.tableView doSendRequest:YES];
        [self sendRequestToServer];
    }
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
    __weak ProductListViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        if ([_request isFristPage]) {
            blockSelf.response = [[ProductResponse alloc] initWithJsonString:content];
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
        self.request = [[[ProductListRequest alloc] init] autorelease];
    }
    self.request.productTypeId = self.productTypeId;
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

@end
