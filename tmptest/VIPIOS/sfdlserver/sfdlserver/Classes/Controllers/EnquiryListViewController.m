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


- (void) configTableView
{
    __block typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(10, 10, 300, 25);
            cell.subLabel.frame = CGRectMake(10, 35, 300, 25);
//            cell.leftImageView .frame = CGRectMake(4, 6, 55, 55);
//            cell.rightButton.frame = CGRectMake(220, 30, 90,35);
//            [cell.rightButton setTitle:@" Add To Cart" forState:UIControlStateNormal];
//            [CreateObject addTargetEfection:cell.rightButton];
            cell.topLabel.numberOfLines = 2;
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize15);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
//            [cell.contentView addSubview:cell.leftImageView];
//            [cell.contentView addSubview:cell.rightButton];
        }
        EnquiryItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.title;
        cell.subLabel.text = item.content;
        cell.content = item;
//        [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.productImg]
//                           placeholderImage:[UIImage imageNamed:kImageDefault]
//                                    success:^(UIImage *image){
//                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 100)];
//                                        cell.leftImageView.image = image1;
//                                    }
//                                    failure:^(NSError *error){
//                                        cell.leftImageView.image = [UIImage imageNamed:kImageDefault];
//                                    }];
//        cell.block = ^(id content)
//        {
//            [[ProductCart sharedInstance] addProductItem:content];
//            ProductCartViewController *controller = [[[ProductCartViewController alloc] init] autorelease];
//            controller.hidesBottomBarWhenPushed = YES;
//            [blockSelf.navigationController pushViewController:controller animated:YES];
//        };
        
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  70.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        EnquiryItem *item = [blockSelf.response at:indexPath.row ];
        ViewEnquiryViewContrller *controller = [[[ViewEnquiryViewContrller alloc] init] autorelease];
        //        controller.secondTitleLabel.text = item.productName;
        controller.item = item;
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
