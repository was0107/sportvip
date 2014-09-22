//
//  ProductDetailViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-22.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "ProductDetailViewControllerEx.h"
#import "XLCycleScrollView.h"
#import "RTLabel.h"
#import "LoginRequest.h"
#import "LoginResponse.h"

@interface ProductDetailViewControllerEx ()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView     *cycleView;
@property (nonatomic, retain) ProductDetailResponse *response;
@property (nonatomic, retain) ViewProductRequest    *request;
@property (nonatomic, retain) AboutUsResponse       *aboutResponse;
@property (nonatomic, retain) UIWebView             *content;
@property (nonatomic, retain) UILabel               *productLabel;
@property (nonatomic, retain) RTLabel               *belongLabel,*telLabel,*emailLabel;
@property (nonatomic, retain) UIImageView           *videoImageView;
@property (nonatomic, retain) UIButton              *descButton, *featureButton;
@property (nonatomic, retain) UIView                *topView, *bottomView;

@end

@implementation ProductDetailViewControllerEx

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"PRODUCT"];
    [self.scrollView removeFromSuperview];
    [self.content loadHTMLString:@"<html></html>" baseURL:nil];
    [self sendRequestToGetCompanyServer];
    [self sendRequestToServer];
    [self.view addSubview:self.content];
    // Do any additional setup after loading the view.
}

- (BOOL) useTablViewToShow
{
    return NO;
}

- (void) createNameView
{
    UIView *headerview = [[[UIView alloc] initWithFrame:CGRectMake(0, -197, 320, 52)] autorelease];
    headerview.backgroundColor = kClearColor;
    UILabel *titL = [[[UILabel alloc] initWithFrame:CGRectMake(0, 8, 320, 36)] autorelease];
    titL.text = [NSString stringWithFormat:@"  %@",self.productItem.productName];
    titL.textColor = kBlackColor;
    titL.backgroundColor = [UIColor whiteColor];
    titL.font = [UIFont boldSystemFontOfSize:15];
    [headerview addSubview:titL];
    self.productLabel = titL;
    [_content.scrollView  addSubview:headerview];
    self.topView = headerview;
}

- (RTLabel *) belongLabel
{
    if (!_belongLabel) {
        _belongLabel = [[RTLabel alloc] initWithFrame:CGRectMake(160, 8, 150, 30)];
        _belongLabel.text = [NSString stringWithFormat:@"Belongs to:<font size=14 color=black>%@ </font>", @""];
        _belongLabel.textColor = kOrangeColor;
        _belongLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
        _belongLabel.backgroundColor = [UIColor whiteColor];
    }
    return _belongLabel;
}

- (RTLabel *) telLabel
{
    if (!_telLabel) {
        _telLabel = [[RTLabel alloc] initWithFrame:CGRectMake(160, 38, 150, 30)];
        _telLabel.text = [NSString stringWithFormat:@"Tel:<font size=14 color=black>%@</font>", @""];
        _telLabel.textColor = kOrangeColor;
        _telLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
        _telLabel.backgroundColor = [UIColor clearColor];
    }
    return _telLabel;
}

- (RTLabel *) emailLabel
{
    if (!_emailLabel) {
        _emailLabel = [[RTLabel alloc] initWithFrame:CGRectMake(160, 68, 150, 18)];
        _emailLabel.text = [NSString stringWithFormat:@"E-mail:<font size=14 color=black>%@</font>", @""];
        _emailLabel.textColor = kOrangeColor;
        _emailLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
        _emailLabel.backgroundColor = [UIColor clearColor];
    }
    return _emailLabel;
}


- (void) createVideoView
{
    UIView *headerview = [[[UIView alloc] initWithFrame:CGRectMake(0, -143, 320, 93)] autorelease];
    headerview.backgroundColor = kWhiteColor;
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 144, 77)] autorelease];
    imageView.layer.cornerRadius = 3.0f;
    [imageView.layer setMasksToBounds:YES];
    imageView.image = [UIImage imageNamed:@"icon"];
    self.videoImageView = imageView;
    [headerview addSubview:imageView];

    [headerview addSubview:[self belongLabel]];
    [headerview addSubview:[self telLabel]];
    [headerview addSubview:[self emailLabel]];
//    
    [_content.scrollView  addSubview:headerview];
    self.bottomView = headerview;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(160, -40, 160, 30);
    button.backgroundColor = kLightGrayColor;
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button setTitle:@"Feautres" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(featureAction:) forControlEvents:UIControlEventTouchUpInside];
    self.featureButton = button;
    [_content.scrollView addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, -40, 160, 30);
    button.backgroundColor = kLightGrayColor;
    [button setTitle:@"Description" forState:UIControlStateNormal];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(descriptionAction:) forControlEvents:UIControlEventTouchUpInside];
    self.descButton = button;
    [_content.scrollView addSubview:button];
}

- (IBAction)descriptionAction:(id)sender
{
    if ([self.response.productDesc length] == 0) {
        return;
    }
    [self.content loadHTMLString:self.response.productDesc baseURL:nil];
    [self.descButton setBackgroundImage:[UIImage imageWithColor:kOrangeColor size:CGSizeMake(19, 19)] forState:UIControlStateNormal];
    [self.featureButton setBackgroundImage:[UIImage imageWithColor:kLightGrayColor size:CGSizeMake(19, 19)] forState:UIControlStateNormal];
}

- (IBAction)featureAction:(id)sender
{
    if ([self.response.feature length] == 0) {
        return;
    }
    [self.content loadHTMLString:self.response.feature baseURL:nil];
    [self.featureButton setBackgroundImage:[UIImage imageWithColor:kOrangeColor size:CGSizeMake(19, 19)] forState:UIControlStateNormal];
    [self.descButton setBackgroundImage:[UIImage imageWithColor:kLightGrayColor size:CGSizeMake(19, 19)] forState:UIControlStateNormal];
}


-(UIWebView *)content
{
    if (!_content) {
        _content = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, kContentBoundsHeight-44)];
        _content.scrollView.backgroundColor = kClearColor;
        _content.backgroundColor = kClearColor;
        [_content.scrollView setContentInset:UIEdgeInsetsMake(365,0,0,0)];
        [_content.scrollView addSubview:self.cycleView];
        [self createNameView];
        [self createVideoView];
    }
    return _content;
}


#pragma mark - XLCycleScrollViewDatasource

- (XLCycleScrollView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, -365.0,320, 165.0f)];
        _cycleView.backgroundColor = kWhiteColor;
        _cycleView.delegate = self;
        _cycleView.dataSource = self;
        [_cycleView reloadData];
    }
    return _cycleView;
}

- (NSInteger)numberOfPages
{
    return [[self.response imagesArray] count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320, 167)];
    imageView.image = [UIImage imageNamed:@"icon"];
    if (index >= 0 && index < [[self.response imagesArray] count]) {
        
        NSString * pictureItem = [[self.response imagesArray] objectAtIndex:index];
        [imageView setImageWithURL:[NSURL URLWithString:pictureItem]
                  placeholderImage:[UIImage imageNamed:kImageDefault]
                           success:^(UIImage *image){
                               UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(320, 165)];
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


- (void)sendRequestToGetCompanyServer
{
    __block typeof(self) blockSelf = self;
//    blockSelf.telLabel.text = [NSString stringWithFormat:@"Tel : <font size=14 color=black>%@ </font>", @"fdfdf"];

    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        blockSelf.aboutResponse = [[[AboutUsResponse alloc] initWithJsonString:content] autorelease];
        blockSelf.telLabel.text = [NSString stringWithFormat:@"Tel : <font size=14 color=black>%@ </font>", [blockSelf.aboutResponse companyTelephone]];
//        blockSelf.telLabel.text = [NSString stringWithFormat:@"Tel : <font size=14 color=black>%@ </font>", @"fdfdf"];

        blockSelf.emailLabel.text = [NSString stringWithFormat:@"E-mail : <font size=14 color=black>%@ </font>", [blockSelf.aboutResponse email]];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
//        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };

    CompanyInfoRequest *request = [[[CompanyInfoRequest alloc] init] autorelease];
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}


- (void) sendRequestToServer
{
    __block typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[[ProductDetailResponse alloc] initWithJsonString:content] autorelease];
        [blockSelf.cycleView reloadData];
        blockSelf.belongLabel.text = [NSString stringWithFormat:@"Belongs to: <font size=14 color=black>%@ </font>",blockSelf.response.productTypeName];
        [blockSelf descriptionAction:blockSelf.descButton];
    };

    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };

    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_request) {
        self.request = [[[ViewProductRequest alloc] init] autorelease];
    }
    self.request.productId = self.productItem.productId;
    self.request.username  = [self currentUserId];
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

@end