//
//  ProductDetailViewControllerEx.m
//  sfdl
//
//  Created by micker on 14-9-22.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "ProductDetailViewControllerEx.h"
#import "XLCycleScrollView.h"
#import "RTLabel.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "BaseWebViewController.h"

@interface ProductDetailViewControllerEx ()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView     *cycleView;
@property (nonatomic, retain) ProductDetailResponse *response;
@property (nonatomic, retain) ViewProductRequest    *request;
@property (nonatomic, retain) AboutUsResponse       *aboutResponse;
@property (nonatomic, retain) UIWebView             *content;
@property (nonatomic, retain) UILabel               *productLabel;
@property (nonatomic, retain) UILabel               *belongLabel,*telLabel,*emailLabel;
@property (nonatomic, retain) UIImageView           *videoImageView;
@property (nonatomic, retain) UIButton              *descButton, *featureButton;
@property (nonatomic, retain) UIView                *topView, *bottomView;

@end

@implementation ProductDetailViewControllerEx


- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_cycleView);
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_topView);
    TT_RELEASE_SAFELY(_featureButton);
    TT_RELEASE_SAFELY(_descButton);
    TT_RELEASE_SAFELY(_videoImageView);
    TT_RELEASE_SAFELY(_emailLabel);
    TT_RELEASE_SAFELY(_telLabel);
    TT_RELEASE_SAFELY(_belongLabel);
    TT_RELEASE_SAFELY(_productLabel);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_aboutResponse);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showShare] showRight];
    [self setTitleContent:NSLocalizedString(@"PRODUCT",@"PRODUCT")];
    [self.scrollView removeFromSuperview];
    [self.content loadHTMLString:@"<html></html>" baseURL:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRequestToGetCompanyServer) name:@"sendRequestToGetCompanyServer" object:nil];
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

- (UILabel *) belongLabel
{
    if (!_belongLabel) {
        _belongLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 8, 90, 30)];
//        _belongLabel.text = [NSString stringWithFormat:@"Belongs to:<font size=14 color=black>%@ </font>", @""];
        _belongLabel.textColor = kBlackColor;
        _belongLabel.font = HTFONTSIZE(kFontSize12);
        _belongLabel.numberOfLines = 2;
        _belongLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
        _belongLabel.backgroundColor = [UIColor whiteColor];
    }
    return _belongLabel;
}

- (UILabel *) telLabel
{
    if (!_telLabel) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 38, 90, 30)];
//        _telLabel.text = [NSString stringWithFormat:@"Telf jdoj fodj fdof jfdjj %@ ", @""];
        _telLabel.textColor = kBlackColor;
        _telLabel.font = HTFONTSIZE(kFontSize12);
        _telLabel.numberOfLines = 2;
        _telLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
        _telLabel.backgroundColor = [UIColor clearColor];
        UIGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(telGesture:)] autorelease];
        [_telLabel addGestureRecognizer:gesture];
    }
    return _telLabel;
}

- (UILabel *) emailLabel
{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 68, 90, 18)];
//        _emailLabel.text = [NSString stringWithFormat:@"E-mail:font size=14 color=black%@</font>", @""];
        _emailLabel.textColor = kBlackColor;
        _emailLabel.font = HTFONTSIZE(kFontSize12);
        _emailLabel.lineBreakMode = RTTextLineBreakModeCharWrapping;
        _emailLabel.backgroundColor = [UIColor clearColor];
        UIGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailGesture:)] autorelease];
        [_emailLabel addGestureRecognizer:gesture];
    }
    return _emailLabel;
}

- (void) telGesture:(UIGestureRecognizer *)recognizer
{
    if ([[self.aboutResponse companyTelephone] length] > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [self.aboutResponse companyTelephone]]]];
    }
}

- (void) emailGesture:(UIGestureRecognizer *)recognizer
{
    if ([[self.aboutResponse email] length] > 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@", [self.aboutResponse email]]]];
    }
}

- (void) videoGesture:(UIGestureRecognizer *) recognizer
{
    if (self.response && [self.response.videoUrl length] > 0) {
        BaseWebViewController *webController = [[[BaseWebViewController alloc] init] autorelease];
        webController.title = NSLocalizedString(@"VIDEO",@"VIDEO");
        webController.requestURL = self.response.videoUrl;
        [self.navigationController hidesBottomBarWhenPushed];
        [self.navigationController pushViewController:webController animated:YES];
    }
}

- (void) createVideoView
{
    UIView *headerview = [[[UIView alloc] initWithFrame:CGRectMake(0, -143, 320, 93)] autorelease];
    headerview.backgroundColor = kWhiteColor;
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 135, 72)] autorelease];
    imageView.layer.cornerRadius = 3.0f;
    [imageView.layer setMasksToBounds:YES];
    imageView.image = [UIImage imageNamed:@"icon"];
    self.videoImageView = imageView;
    UIGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoGesture:)] autorelease];
    [imageView addGestureRecognizer:gesture];
    [headerview addSubview:imageView];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(152, 8, 66, 20)] autorelease];
    label.backgroundColor = kClearColor;
    label.font = HTFONTSIZE(kFontSize12);
    label.textColor = kOrangeColor;
    label.text = @"Belongs to:";
    [headerview addSubview:label];
    
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(152, 38, 66, 20)] autorelease];
    label.backgroundColor = kClearColor;
    label.font = HTFONTSIZE(kFontSize12);
    label.textColor = kOrangeColor;
    label.text = @"Telphone:";
    [headerview addSubview:label];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(152, 68, 66, 14)] autorelease];
    label.backgroundColor = kClearColor;
    label.font = HTFONTSIZE(kFontSize12);
    label.textColor = kOrangeColor;
    label.text = @"E-mail:";
    [headerview addSubview:label];

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
    [button setTitle:NSLocalizedString(@"Feautres",@"Feautres") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(featureAction:) forControlEvents:UIControlEventTouchUpInside];
    self.featureButton = button;
    [_content.scrollView addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, -40, 160, 30);
    button.backgroundColor = kLightGrayColor;
    [button setTitle:NSLocalizedString(@"Description",@"Description") forState:UIControlStateNormal];
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
    [self.content loadHTMLString:self.response.others baseURL:nil];
    [self.featureButton setBackgroundImage:[UIImage imageWithColor:kOrangeColor size:CGSizeMake(19, 19)] forState:UIControlStateNormal];
    [self.descButton setBackgroundImage:[UIImage imageWithColor:kLightGrayColor size:CGSizeMake(19, 19)] forState:UIControlStateNormal];
}


-(UIWebView *)content
{
    if (!_content) {
        _content = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, kContentBoundsHeight-44)];
        _content.scrollView.backgroundColor = kClearColor;
        _content.backgroundColor = kClearColor;
        _content.opaque = NO;
        UIView *view = [_content.subviews objectAtIndex:0];
        view.backgroundColor = kClearColor;
        [_content.scrollView setContentInset:UIEdgeInsetsMake(365,0,0,0)];
        [_content.scrollView addSubview:self.cycleView];
        [self createNameView];
        [self createVideoView];
    }
    return _content;
}




- (id<ISSContent>) shareContent
{
    if (!self.productItem) {
        return [super shareContent];
    }
    return [ShareSDK content:self.productItem.productName
              defaultContent:self.productItem.debugDescription
                       image:nil//[ShareSDK imageWithPath:imagePath]
                       title:self.productItem.productName
                         url:SHARE_URL
                 description:self.productItem.debugDescription
                   mediaType:SSPublishContentMediaTypeNews];
}


#pragma mark - XLCycleScrollViewDatasource

- (XLCycleScrollView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, -365.0,320, 165.0f)];
        _cycleView.backgroundColor = kWhiteColor;
        _cycleView.delegate = self;
        _cycleView.dataSource = self;
        _cycleView.pageControl.currentPageIndicatorTintColor = kOrangeColor;
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
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (index >= 0 && index < [[self.response imagesArray] count]) {
        
        NSString * pictureItem = [[self.response imagesArray] objectAtIndex:index];
        [imageView setImageWithURL:[NSURL URLWithString:pictureItem]
                  placeholderImage:[UIImage imageNamed:kImageDefault]
                           success:^(UIImage *image){
                               imageView.image = image;
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


- (void) dealWithVideo
{
    [self.videoImageView setImageWithURL:[NSURL URLWithString:self.response.videoImg]
              placeholderImage:[UIImage imageNamed:kImageDefault]
                       success:^(UIImage *image){
                           UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(144, 77)];
                           _videoImageView.image = image1;
                       }
                       failure:^(NSError *error){
                           _videoImageView.image = [UIImage imageNamed:kImageDefault];
                       }];

}

- (void)sendRequestToGetCompanyServer
{
    typeof(self) blockSelf = self;
    if ([[[AppDelegate sharedAppDelegate] rootController] aboutResponse]) {
        blockSelf.aboutResponse = [[[AppDelegate sharedAppDelegate] rootController] aboutResponse];
//        blockSelf.telLabel.text = [blockSelf.aboutResponse companyTelephone];
        //[NSString stringWithFormat:@"%@: <font size=14 color=black>%@ </font>",NSLocalizedString(@"Tel","Tel"), [blockSelf.aboutResponse companyTelephone]];
        blockSelf.emailLabel.text = [blockSelf.aboutResponse email];
        //[NSString stringWithFormat:@"%@: <font size=14 color=black>%@ </font>",NSLocalizedString(@"E-mail","E-mail"), [blockSelf.aboutResponse email]];
        return;
    }
    [[[AppDelegate sharedAppDelegate] rootController] sendRequestToGetCompanyServer];
}


- (void) sendRequestToServer
{
    __unsafe_unretained typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[[ProductDetailResponse alloc] initWithJsonString:content] autorelease];
        [blockSelf.cycleView reloadData];
        blockSelf.belongLabel.text = blockSelf.response.productTypeName;
        //[NSString stringWithFormat:@"%@: <font size=14 color=black>%@ </font>",NSLocalizedString(@"Belongs to","Belongs to"),blockSelf.response.productTypeName];
        [blockSelf descriptionAction:blockSelf.descButton];
        [blockSelf dealWithVideo];
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
