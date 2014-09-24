//
//  ProductCategoryViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductCategoryViewController.h"
#import "ProductListViewController.h"
#import "ProductRequest.h"
#import "ProductResponse.h"

@interface ProductCategoryViewController ()
@property (nonatomic, retain) ProductTypeReponse    *response;
@property (nonatomic, retain) ProductTypeRequest *request;
@end

@implementation ProductCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"Product List";
    // Do any additional setup after loading the view.
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

- (void) configTableView
{
    __unsafe_unretained ProductCategoryViewController *blockSelf = self;
//    NSArray *titleIndexArray = @[@"Open Type Generator Sets",@"Slient Type Generator Sets",@"Trailer Type Generator Sets",@"Mobile Light Tower", \
//                                 @"High-volt Generator Sets",@"Alternator",@"Options"];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.leftImageView .frame = CGRectMake(10, 5, 40, 40);
            cell.topLabel.frame = CGRectMake(54, 5, 250, 40);
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.leftImageView];
        }
        ProductTypeItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.productTypeName;
        
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.productTypeImg]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 100)];
                                        cell.leftImageView.image = image1;
                                    }
                                    failure:^(NSError *error){
                                        cell.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  50.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ProductTypeItem *item = [blockSelf.response at:indexPath.row ];
        ProductListViewController *controller = [[[ProductListViewController alloc] init] autorelease];
        controller.secondTitleLabel.text = item.productTypeName;
        controller.productTypeId = item.productTypeId;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];

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

    
    [self.view addSubview:self.tableView];
    
    [self.tableView doSendRequest:YES];
//    [self sendRequestToServer];
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
    __unsafe_unretained ProductCategoryViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        if ([_request isFristPage]) {
            blockSelf.response = [[ProductTypeReponse alloc] initWithJsonString:content];
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
        self.request = [[[ProductTypeRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}
@end
