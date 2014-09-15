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

@interface HomeViewControllerEx ()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView *cycleView;
@property (nonatomic, retain) UIImageView   *topImageView;
@property (nonatomic, retain) CustomSearchBarEx *searchView;

@property (nonatomic, retain) PictureResponse    *pictureResponse;
@property (nonatomic, retain) PictureListRequest *pictureRequest;

@property (nonatomic, retain) UIView            *headerView;

@end

@implementation HomeViewControllerEx


- (NSString *)tabImageName
{
    return @"home_black";
}

- (NSString *)tabSelectedImageName
{
    return @"home_white";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showRight] showLeft];
    [self.customTitleLable setText:@""];
    [self.headerView addSubview:self.searchView];
    [self.headerView addSubview:self.cycleView];
    
    self.tableView.tableHeaderView = self.headerView;
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
//        __block typeof(self) blockSelf = self;
        _searchView = [[CustomSearchBarEx alloc] initWithFrame:CGRectMake(0, 102.0,320,50.0)];
//        _searchView.completeBlok = ^(NSString *result) {
//            if (result.length > 0) {
//                SearchViewController *controller = [[[SearchViewController alloc] init] autorelease];
//                controller.secondTitleLabel.text = result;
//                [blockSelf.navigationController hidesBottomBarWhenPushed];
//                [blockSelf.navigationController pushViewController:controller animated:YES];
//            }
//        };
    }
    return _searchView;
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


- (void) sendRequestToServer
{
    __block typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        if ([_pictureRequest isFristPage]) {
            blockSelf.pictureResponse = [[PictureResponse alloc] initWithJsonString:content];
        } else {
            [blockSelf.pictureResponse appendPaggingFromJsonString:content];
        }
        [_pictureRequest nextPage];
        [_cycleView reloadData];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_pictureRequest) {
        self.pictureRequest = [[[PictureListRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.pictureRequest URLString] body:[self.pictureRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}



#pragma mark - XLCycleScrollViewDatasource

- (XLCycleScrollView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0.0,320, 100.0f)];
        _cycleView.backgroundColor = kClearColor;
        _cycleView.delegate = self;
        _cycleView.dataSource = self;
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
        
        PictureItem *pictureItem = [self.pictureResponse at:index];
        [imageView setImageWithURL:[NSURL URLWithString:pictureItem.mediaUrl]
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
    __block typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = TABLE_VIEW_HEADERVIEW(20.1f);
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"SETTING_TABLEVIEW_CELL_IDENTIFIER";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            CustomThreeButton *button1 = [[[CustomThreeButton alloc] initWithFrame:CGRectMake(0, 0, 107, 130)] autorelease];
            CustomThreeButton *button2 = [[[CustomThreeButton alloc] initWithFrame:CGRectMake(108, 0, 107, 130)] autorelease];
            CustomThreeButton *button3 = [[[CustomThreeButton alloc] initWithFrame:CGRectMake(216, 0, 107, 130)] autorelease];
            
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
            
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (eSectionIndex01 == section) ? 2 : 1;
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
        
        UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(10,9,200,30)] autorelease];
        label1.text = (eSectionIndex01 == section) ? @"HOT PRODUCTS" : @"MOST POPULATE";
        label1.font = HTFONTSIZE(kFontSize16);
        label1.textColor = kBlackColor;
        
        UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(220,14,90,20)] autorelease];
        label2.text = @"MORE";
        label2.font = HTFONTSIZE(kFontSize14);
        label2.textColor = kGrayColor;
        label2.textAlignment = NSTextAlignmentRight;
        label2.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(goToMore:)] autorelease];
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
    
}

@end
