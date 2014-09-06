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

- (int) tableViewType
{
    return (self.productTypeId) ? [super tableViewType] : eTypeNone;
}


- (void) configTableView
{
    __block ProductListViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(70, 10, 166, 50);
            cell.subLabel.frame = CGRectMake(70, 35, 160, 25);
            cell.leftImageView .frame = CGRectMake(10, 6, 55, 55);
            cell.rightButton.frame = CGRectMake(240, 30, 70,35);
            [cell.rightButton setTitle:@" Cart " forState:UIControlStateNormal];
            
            CALayer *layer = [CALayer layer];
            layer.contents = ((UIImage *)[UIImage imageNamed:@"the_cart"]).CGImage;
            layer.frame = CGRectMake(35, 0, 35, 35);
            [cell.rightButton.layer addSublayer:layer];
            
            [CreateObject addTargetEfection:cell.rightButton];
            cell.topLabel.numberOfLines = 0;
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
//            [cell.contentView addSubview:cell.subLabel];
            [cell.contentView addSubview:cell.leftImageView];
            [cell.contentView addSubview:cell.rightButton];
        }
        ProductItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.productName;
        cell.subLabel.text = item.productDesc;
        cell.content = item;
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:item.productImg]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 100)];
                                        cell.leftImageView.image = image1;
                                    }
                                    failure:^(NSError *error){
                                        cell.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];
        cell.block = ^(id content)
        {
            [[ProductCart sharedInstance] addProductItem:content];
            ProductCartViewController *controller = [[[ProductCartViewController alloc] init] autorelease];
            controller.hidesBottomBarWhenPushed = YES;
            [blockSelf.navigationController pushViewController:controller animated:YES];
        };

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
        ProductItem *item = [blockSelf.response at:indexPath.row ];
        ProductDetailViewController *controller = [[[ProductDetailViewController alloc] init] autorelease];
//        controller.secondTitleLabel.text = item.productName;
        controller.productItem = item;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
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
