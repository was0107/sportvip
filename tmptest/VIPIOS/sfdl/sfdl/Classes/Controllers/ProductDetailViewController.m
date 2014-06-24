//
//  ProductDetailViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()<ViewPagerDataSource, ViewPagerDelegate>
@property (nonatomic, retain) ProductDetailIntroController *introController;
@property (nonatomic, retain) ProductDetailCommentController *commentController;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad
{
    
    self.dataSource = self;
    self.delegate = self;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (ProductDetailIntroController *) introController
{
    if (!_introController) {
        _introController = [[ProductDetailIntroController alloc] init];
        _introController.productItem = self.productItem;
    }
    return _introController;
}


- (ProductDetailCommentController *) commentController
{
    if (!_commentController) {
        _commentController = [[ProductDetailCommentController alloc] init];
        _commentController.productItem = self.productItem;
    }
    return _commentController;
}


#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 2;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.text = (0 == index) ? @"Product Detail" : @"Comments";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if (index == 0) {
        return self.introController;
    }
    return self.commentController;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

@end



@implementation ProductDetailIntroController

-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 304, 20)];
        _labelOne.textColor  = [UIColor getColor:kCellLeftColor];
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kSystemFontSize15);
        //        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        //        _labelOne.text = version;
    }
    return _labelOne;
}


-(UILabel *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[UILabel alloc]initWithFrame:CGRectMake(8, 24, 304, 20)];
        _labelTwo.textColor  = [UIColor getColor:kCellLeftColor];
        _labelTwo.backgroundColor = kClearColor;
        _labelTwo.font = HTFONTSIZE(kSystemFontSize15);
        //        NSString *version = [NSString stringWithFormat:kAboutItemStringVersion,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        //        _labelOne.text = version;
    }
    return _labelTwo;
}
-(UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 44, 320, kContentBoundsHeight-84)];
        //        _labelTwo.textColor  = [UIColor getColor:kCellLeftColor];
        //        _labelTwo.textAlignment = NSTextAlignmentCenter;
        _webView.backgroundColor = kClearColor;
        //        _labelTwo.font = HTFONTSIZE(kSystemFontSize14);
        //        _labelTwo.text = lLabelTwoString;
        //        _labelTwo.numberOfLines = 0;
        
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.labelOne];
    [self.view addSubview:self.labelTwo];
    [self.view addSubview:self.webView];
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}
- (void) sendRequestToServer
{
     self.labelOne.text = [NSString stringWithFormat:@"产品类型：%@",self.productItem.productTypeName];
     self.labelTwo.text = [NSString stringWithFormat:@"产品名称：%@",self.productItem.productName];
    [self.webView loadHTMLString:self.productItem.productDesc baseURL:nil];
//    __weak ProductDetailIntroController *blockSelf = self;
//    idBlock successedBlock = ^(id content){
//        DEBUGLOG(@"success conent %@", content);
//        blockSelf.response = [[ProductDetailResponse alloc] initWithJsonString:content];
//    };
//    
//    idBlock failedBlock = ^(id content){
//        DEBUGLOG(@"failed content %@", content);
//    };
//    
//    idBlock errBlock = ^(id content){
//        DEBUGLOG(@"error content %@", content);
//    };
//    if (!_request) {
//        self.request = [[[ViewProductRequest alloc] init] autorelease];
//    }
//    self.request.productId = self.productItem.productId;
//    
//    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

@end



@implementation ProductDetailCommentController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (int) tableViewType
{
    return eTypeNone;
}


- (void) configTableView
{
    __block ProductDetailCommentController *blockSelf = self;
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
        CommentItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.username;
        cell.subLabel.text = item.createTime;
        cell.rightLabel.text = item.comments;
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return [blockSelf.response arrayCount];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  64.0f;
    };

    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    [self.view addSubview:self.tableView];
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
    __weak ProductDetailCommentController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[CommentsResponse alloc] initWithJsonString:content];
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
        self.request = [[[CommentListRequest alloc] init] autorelease];
    }
    self.request.productId = self.productItem.productId;
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}
@end