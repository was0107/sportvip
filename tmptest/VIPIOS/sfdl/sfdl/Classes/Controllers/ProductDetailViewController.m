//
//  ProductDetailViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "CreateObject.h"
#import "CustomLeftImageButton.h"
#import "LeaveMessageViewController.h"
#import "BaseWebViewController.h"
#import "ContactUsViewController.h"
#import "UIView+extend.h"
#import "ProductCartViewController.h"


@interface ProductDetailViewController ()<ViewPagerDataSource, ViewPagerDelegate>
@property (nonatomic, retain) ProductDetailIntroController *introController;
@property (nonatomic, retain) ProductDetailCommentController *commentController;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad
{
    
    self.dataSource = self;
    self.delegate = self;
    self.tabWidth = 160.0f;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (ProductDetailIntroController *) introController
{
    if (!_introController) {
        _introController = [[ProductDetailIntroController alloc] init];
        _introController.parentNavigationController = self.navigationController;
        _introController.productItem = self.productItem;
    }
    return _introController;
}


- (ProductDetailCommentController *) commentController
{
    if (!_commentController) {
        _commentController = [[ProductDetailCommentController alloc] init];
        _commentController.parentNavigationController = self.navigationController;
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
    label.text = (0 == index) ? @"Product Details" : @"Comments";
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
            return 0.0;
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
            return [kBlueColor colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

@end



@implementation ProductDetailIntroController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.leftImageView];
    [self.view addSubview:self.labelOne];
    
    UILabel *quantityLabel = [[[UILabel alloc] initWithFrame:CGRectMake(108, 14, 100, 40)] autorelease];
    quantityLabel.text = @"Quantity:";
    quantityLabel.textColor  = [UIColor getColor:kCellLeftColor];
    quantityLabel.font = HTFONTSIZE(kSystemFontSize15);
    [self.view addSubview:quantityLabel];
    [self.view addSubview:self.labelTwo];
    [self.view addSubview:self.rightButton];
    [self.view addSubview:self.webView];
    
    CGFloat yPosition = self.webView.y + self.webView.height;
    
    NSString *image[] = {@"icon",@"icon",@"icon"};
    NSString *names[] = {@"Video",@"Leave Messages",@"Contact Us"};
    for (int i = 0; i< 3; i++) {
        CustomLeftImageButton *imageButton = [[[CustomLeftImageButton alloc] initWithFrame:CGRectMake(i * 105 + 1, yPosition, 104, 44)] autorelease];
        imageButton.tag = 1000+i;
        imageButton.backgroundColor = kBlackColor;
        imageButton.leftImageView.image = [UIImage imageNamed:image[i]];
        imageButton.rightLabel.text = names[i];
        imageButton.rightLabel.textColor = kWhiteColor;
        [imageButton addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:imageButton];
    }
    [self sendRequestToServer];
}

- (UIImageView *) leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 100, 100)];
        _leftImageView.backgroundColor = kClearColor;
        _leftImageView.userInteractionEnabled = YES;
        _leftImageView.layer.borderColor = [kButtonNormalColor CGColor];;
        _leftImageView.layer.borderWidth = 2.0f;
        _leftImageView.layer.cornerRadius = 2.0f;
        _leftImageView.image = [UIImage imageNamed:@"btn_tab2"];
    }
    return _leftImageView;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _rightButton.frame =CGRectMake(108, 60+24, 90,24);
        [_rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_rightButton setTitleColor:kBlackColor forState:UIControlStateSelected];
        _rightButton.titleLabel.font = HTFONTSIZE(kSystemFontSize14);
        [_rightButton setTitle:@" Add To Cart" forState:UIControlStateNormal];
        [CreateObject addTargetEfection:_rightButton];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_rightButton addTarget:self action:@selector(buttonOneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UILabel *)labelOne
{
    if (!_labelOne)
    {
        _labelOne = [[UILabel alloc]initWithFrame:CGRectMake(108, 2, 200, 20)];
        _labelOne.textColor  = [UIColor getColor:kCellLeftColor];
        _labelOne.backgroundColor = kClearColor;
        _labelOne.font = HTFONTSIZE(kSystemFontSize15);
    }
    return _labelOne;
}

-(GrowAndDownControl *)labelTwo
{
    if (!_labelTwo)
    {
        _labelTwo = [[GrowAndDownControl alloc]initWithFrame:CGRectMake(104, 44, 180, 40)];
        _labelTwo.content = self.productItem;
        _labelTwo.value = self.productItem.buyCount;
        _labelTwo.block = ^(id content){
            GrowAndDownControl *labelTwo = (GrowAndDownControl *) content;
            ProductItem *item = labelTwo.content;
            item.buyCount = labelTwo.value;
        };
    }
    return _labelTwo;
}

-(UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 108, 320, kContentBoundsHeight-84-40-44-24)];
        _webView.backgroundColor = kClearColor;
    }
    return _webView;
}

-(IBAction)buttonOneAction:(id)sender
{
    [[ProductCart sharedInstance] addProductItem:self.productItem];
    ProductCartViewController *controller = [[[ProductCartViewController alloc] init] autorelease];
    controller.hidesBottomBarWhenPushed = YES;
    [self.parentNavigationController pushViewController:controller animated:YES];
}

-(IBAction)bottomAction:(id)sender
{
    CustomLeftImageButton *button = (CustomLeftImageButton *) sender;
    int position = button.tag - 1000;
    if (0 == position) {
        BaseWebViewController *webController = [[[BaseWebViewController alloc] init] autorelease];
        webController.title = @"Video";
        webController.requestURL = @"http://v.youku.com/v_show/id_XNzM0ODMxNDc2.html?f=22491019&from=y1.3-idx-grid-1519-9909.104039-104169-104167-104057-104041.1-1";
        [self.parentNavigationController hidesBottomBarWhenPushed];
        [self.parentNavigationController pushViewController:webController animated:YES];

    } else if (1 == position) {
        LeaveMessageViewController *controller = [[[LeaveMessageViewController alloc] init] autorelease];
        [self.parentNavigationController hidesBottomBarWhenPushed];
        [self.parentNavigationController pushViewController:controller animated:YES];
        
    } else {
        ContactUsViewController *controller = [[[ContactUsViewController alloc] init] autorelease];
        [self.parentNavigationController hidesBottomBarWhenPushed];
        [self.parentNavigationController pushViewController:controller animated:YES];
    }
}



- (void) sendRequestToServer
{
    __block ProductDetailIntroController *blockSelf = self;
     self.labelOne.text = [NSString stringWithFormat:@"%@",self.productItem.productName];
    [self.webView loadHTMLString:self.productItem.productDesc baseURL:nil];
    [self.leftImageView setImageWithURL:[NSURL URLWithString:self.productItem.productImg]
                       placeholderImage:[UIImage imageNamed:kImageDefault]
                                success:^(UIImage *image){
                                    UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 100)];
                                    blockSelf.leftImageView.image = image1;
                                }
                                failure:^(NSError *error){
                                    blockSelf.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                }];

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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setup];
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (int) tableViewType
{
    return eTypeRefreshHeader;
}

- (UITextView *) commentView
{
    if (!_commentView) {
        _commentView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 60)];
        _commentView.layer.cornerRadius = 2.0f;
        _commentView.layer.borderColor = [kBlueColor CGColor];
        _commentView.layer.borderWidth = 1.0f;
        _commentView.delegate = self;
    }
    return _commentView ;
}

- (UIButton *) submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _submitButton.frame = CGRectMake(10, 75, 80, 30);
        [CreateObject addTargetEfection:_submitButton];
        [_submitButton setTitle:@"submit" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (UIView *) footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 110)];
        [_footerView addSubview:self.commentView];
        [_footerView addSubview:self.submitButton];
        _footerView.backgroundColor = kClearColor;
    }
    return _footerView;
}

- (IBAction)submitButtonAction:(id)sender
{
    if ([self.commentView.text length] == 0) {
        return;
    }
    [self.commentView resignFirstResponder];
    __block ProductDetailCommentController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.commentView.text = @"";
        [blockSelf sendRequestToServer];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    AddCommentRequest *addCommentRequest = [[[AddCommentRequest alloc] init] autorelease];
    addCommentRequest.productId = self.productItem.productId;
    addCommentRequest.username = [UserDefaultsManager userName];
    addCommentRequest.comments = self.commentView.text;
    [WASBaseServiceFace serviceWithMethod:[addCommentRequest URLString] body:[addCommentRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];

}

- (void) configTableView
{
    __block ProductDetailCommentController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];//[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
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
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  64.0f;
    };

    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.refreshBlock = ^(id content) {
//        [blockSelf.request firstPage];
        [blockSelf sendRequestToServer];
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
    __block ProductDetailCommentController *blockSelf = self;
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