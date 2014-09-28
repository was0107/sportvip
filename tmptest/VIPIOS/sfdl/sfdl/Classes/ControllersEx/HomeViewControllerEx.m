//
//  HomeViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "HomeViewControllerEx.h"
#import <objc/message.h>
#import "CreateObject.h"
#import "CustomSearchBar.h"
#import "CustomImageTitleButton.h"
#import "SearchViewController.h"
#import "UINavigationItem+Space.h"
#import "XLCycleScrollView.h"
#import "UIImageLabelEx.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "BaseWebViewController.h"
#import "ProductSearchExViewController.h"
#import "CustomThreeButton.h"
#import "ProductDetailViewControllerEx.h"
#import "PopInputView.h"


@interface HomeViewControllerEx ()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView *cycleView;
@property (nonatomic, retain) UIImageView   *topImageView;
@property (nonatomic, retain) CustomSearchBarEx *searchView;

@property (nonatomic, retain) BannerResponse     *pictureResponse;
@property (nonatomic, retain) BannerRequest      *pictureRequest;

@property (nonatomic, retain) ProductForHomePageRequest  *request;
@property (nonatomic, retain) ProductForHomePageResponse *response;
@property (nonatomic, retain) UIView            *headerView;

@end

@implementation HomeViewControllerEx

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_cycleView);
    TT_RELEASE_SAFELY(_topImageView);
    TT_RELEASE_SAFELY(_searchView);
    TT_RELEASE_SAFELY(_pictureRequest);
    TT_RELEASE_SAFELY(_pictureResponse);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_headerView);
    [super reduceMemory];
}


- (NSString *)tabImageName
{
    return @"home_black";
}

- (NSString *)tabSelectedImageName
{
    return @"home_white";
}

- (id) showLeft
{
    
    UIBarButtonItem *right = [[[UIBarButtonItem alloc] initWithCustomView:[self leftViewTemp]] autorelease];
    [self.navigationItem mySetLeftBarButtonItem:right];
    return self;
}

- (UIView *) leftViewTemp
{
    UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 60, 44)] autorelease];
    bgView.image = [UIImage imageNamed:@"icon"];
    return bgView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showRight] showLeft];
    [self.customTitleLable setText:@""];
    [self.headerView addSubview:self.searchView];
    [self.headerView addSubview:self.cycleView];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self sendToGetListData];
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (UIView *) headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        
    }
    return _headerView;
}


- (CustomSearchBarEx *) searchView
{
    if (!_searchView) {
//        __unsafe_unretained typeof(self) blockSelf = self;
        _searchView = [[CustomSearchBarEx alloc] initWithFrame:CGRectMake(0, 102.0,320,50.0)];
        _searchView.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToInquiry:)] autorelease];
        [_searchView addGestureRecognizer:gesture];
    }
    return _searchView;
}

- (void) goToInquiry:(UIGestureRecognizer *) recognizer
{
    Class class = NSClassFromString(@"InquiryFormViewController");
    UIViewController *controller = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UIImageView *) topImageView
{
    if (!_topImageView) {
        int flag =  (iPhone5) ? 120 : 110;
        int flag1 =  (iPhone5) ? 0 : 44;
        
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60.0,320, kContentBoundsHeight- kContentBoundsHeight + 2 * flag - 60.0f - flag1)];
        
        _topImageView.backgroundColor = kGridTableViewColor;
    }
    return _topImageView;
}



#pragma mark - XLCycleScrollViewDatasource

- (XLCycleScrollView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0.0,320, 100.0f)];
        _cycleView.backgroundColor = kClearColor;
        _cycleView.delegate = self;
        _cycleView.dataSource = self;
        _cycleView.pageControl.currentPageIndicatorTintColor = kOrangeColor;
        [_cycleView reloadData];
    }
    return _cycleView;
}

- (NSInteger)numberOfPages
{
    return [self.pictureResponse count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0,320, 100)];
    imageView.image = [UIImage imageNamed:@"icon"];
    if (index >= 0 && index < [self.pictureResponse count]) {
        
        BannerItem *pictureItem = [self.pictureResponse at:index];
        [imageView setImageWithURL:[NSURL URLWithString:pictureItem.bannerImg]
                  placeholderImage:[UIImage imageNamed:kImageDefault]
                           success:^(UIImage *image){
                               UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(320, 120)];
                               imageView.image = image1;
                               
                           }
                           failure:^(NSError *error){
                               imageView.image = [UIImage imageNamed:kImageDefault];
                           }];
    }
    
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    DEBUGLOG(@"selected index:%ld", (long)index);
}


- (CGRect)tableViewFrame
{
    return kContentWithTabBarFrame;
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __unsafe_unretained typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = TABLE_VIEW_HEADERVIEW(20.1f);
    self.tableView.separatorColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"SETTING_TABLEVIEW_CELL_IDENTIFIER";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = kClearColor;
            cell.backgroundColor = kClearColor;
            CustomThreeButton *button1 = [[[CustomThreeButton alloc] initWithFrame:CGRectMake(0, 0, 107, 130)] autorelease];
            CustomThreeButton *button2 = [[[CustomThreeButton alloc] initWithFrame:CGRectMake(108, 0, 107, 130)] autorelease];
            CustomThreeButton *button3 = [[[CustomThreeButton alloc] initWithFrame:CGRectMake(216, 0, 107, 130)] autorelease];
            [button1 addTarget:self action:@selector(buttonActionProduct:) forControlEvents:UIControlEventTouchUpInside];
            [button2 addTarget:self action:@selector(buttonActionProduct:) forControlEvents:UIControlEventTouchUpInside];
            [button3 addTarget:self action:@selector(buttonActionProduct:) forControlEvents:UIControlEventTouchUpInside];

            [cell.contentView addSubview:button1];
            [cell.contentView addSubview:button2];
            [cell.contentView addSubview:button3];
            
            button1.tag = 1000 + 0;
            button2.tag = 1000 + 1;
            button3.tag = 1000 + 2;
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(107, 0, 1, 130)] autorelease];
            lineView.backgroundColor = kGrayColor;
            lineView.alpha = 0.3f;
            [cell.contentView addSubview:lineView];
            lineView = [[[UIView alloc] initWithFrame:CGRectMake(215, 0, 1, 130)] autorelease];
            lineView.backgroundColor = kGrayColor;
            lineView.alpha = 0.3f;
            [cell.contentView addSubview:lineView];
            
            lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 129.5f, 320, 0.5f)] autorelease];
            lineView.backgroundColor = kGrayColor;
            lineView.alpha = 0.3f;
            [cell.contentView addSubview:lineView];
            
            lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)] autorelease];
            lineView.backgroundColor = kGrayColor;
            lineView.alpha = 0.3f;
            [cell.contentView addSubview:lineView];
        }
        NSMutableArray *array = (1 == indexPath.section) ? [blockSelf.response hotArray] : [blockSelf.response result];
        for (int i =0 ; i < 3 ; i++) {
            CustomThreeButton *button = (CustomThreeButton *)[cell.contentView viewWithTag:1000+i];
            if (indexPath.row * 3 + i < [array count]) {
                HomeProductItem *item = [array objectAtIndex:indexPath.row * 3 + i];
                [button setContent:item];
                [button setHidden:NO];
            } else {
                [button setHidden:YES];
                [button setContent:nil];
            }
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)((((eSectionIndex01 == section) ? [[blockSelf.response hotArray] count] : ([[blockSelf.response result] count])) + 2) /3);
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView) {
        return (NSInteger)2;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  130.0f;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 44.0f;
    };
    
    self.tableView.sectionFooterHeightBlock = ^(UITableView *tableView, NSInteger section)
    {
        return 0.0f;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section)
    {
        UIView *footerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)]autorelease];
        footerView.backgroundColor = blockSelf.view.backgroundColor;
        UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(10,9,200,30)] autorelease];
        label1.text = (eSectionIndex01 == section) ? @"HOT PRODUCTS" : @"MOST POPULATE";
        label1.font = HTFONTSIZE(kFontSize16);
        label1.textColor = kBlackColor;
        label1.backgroundColor = kClearColor;
        
        UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(220,4,90,40)] autorelease];
        label2.text = @"MORE";
        label2.font = HTFONTSIZE(kFontSize14);
        label2.textColor = kGrayColor;
        label2.backgroundColor = kClearColor;
        label2.textAlignment = NSTextAlignmentRight;
        label2.userInteractionEnabled = YES;
        footerView.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToMore:)] autorelease];
        [label2 addGestureRecognizer:gesture];
        
        [footerView addSubview:label1];
        [footerView addSubview:label2];
        return footerView;
    };
    
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    [self.view addSubview: self.tableView];
}

- (void) goToMore:(UIGestureRecognizer *) recognizer
{
    Class class = NSClassFromString(@"MiddleViewController");
    UIViewController *controller = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}


- (IBAction)buttonActionProduct:(id)sender
{
    CustomTwoButton *button = (CustomTwoButton *) sender;
    if (button && button.content) {
        ProductDetailViewControllerEx *controller = [[[ProductDetailViewControllerEx alloc] init] autorelease];
        controller.productItem = button.content;
        [self.navigationController pushViewController:controller animated:YES];
    }
}



- (void) sendRequestToServer
{
    __unsafe_unretained typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.pictureResponse = [[BannerResponse alloc] initWithJsonString:content];
        [_cycleView reloadData];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    
    if (!_pictureRequest) {
        self.pictureRequest = [[[BannerRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.pictureRequest URLString] body:[self.pictureRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}


- (void) sendToGetListData
{
    __unsafe_unretained typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[ProductForHomePageResponse alloc] initWithJsonString:content];
        [blockSelf.tableView reloadData];
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
        self.request = [[[ProductForHomePageRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}


@end
