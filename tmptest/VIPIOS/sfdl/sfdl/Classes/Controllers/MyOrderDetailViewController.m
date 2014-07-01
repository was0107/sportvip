//
//  MyOrderDetailViewController.m
//  sfdl
//
//  Created by allen.wang on 7/1/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "ProductDetailViewController.h"

@interface MyOrderDetailViewController ()
@property (nonatomic, assign) OrderItem             *detailItem;
@property (nonatomic, retain) ViewOrderRequest      *request;
@property (nonatomic, retain) ViewOrderResponse     *response;
@end

@implementation MyOrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"Order Detail";
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (void) configTableView
{
    __block MyOrderDetailViewController *blockSelf = self;
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
        cell.topLabel.text = [blockSelf.detailItem.titleArray objectAtIndex:indexPath.row];
        cell.subLabel.text = blockSelf.detailItem.sendTime;
        cell.rightLabel.text = blockSelf.detailItem.status;
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.detailItem.titleArray count];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  64.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ProductItem *productItem = [[[ProductItem alloc] init] autorelease];
        productItem.productId = [blockSelf.detailItem.productIdArray objectAtIndex:indexPath.row];
        productItem.productName = [blockSelf.detailItem.titleArray objectAtIndex:indexPath.row];
        ProductDetailViewController *controller = [[[ProductDetailViewController alloc] init] autorelease];
        controller.productItem = productItem;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
    };
    [self.view addSubview:self.tableView];
}

- (void) dealWithData
{
    [self.tableView reloadData];
}

- (void) sendRequestToServer
{
    __block MyOrderDetailViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[ViewOrderResponse alloc] initWithJsonString:content];
        blockSelf.detailItem = [blockSelf.response orderItem];
        [blockSelf dealWithData];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    if (!_request) {
        self.request = [[[ViewOrderRequest alloc] init] autorelease];
    }
    self.request.username = [UserDefaultsManager userName];
    self.request.orderId = self.item.orderId;
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}



@end
