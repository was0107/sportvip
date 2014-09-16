//
//  BaseTitleViewController.m
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTitleViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+extend.h"
#import "UIView+extend.h"
#import "UIImage+tintedImage.h"


@interface BaseTitleViewController()
@property (nonatomic, retain) UIView  *leftView;

@end


@implementation BaseTitleViewController
@synthesize titleView        = _titleView;
@synthesize leftButton       = _leftButton;
@synthesize rightButton      = _rightButton;
@synthesize customTitleLable = _customTitleLable;


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view addSubview:self.titleView];
//    if (!IS_IOS_7_OR_GREATER)
//        {
//            UIImage *image = [[UIImage imageNamed:@"bg_top"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
//            [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//            self.navigationController.navigationBar.tintColor = kButtonNormalColor;
//            self.navigationItem.titleView = self.customTitleLable;
//        }
//    else
//        {
//            UIImage *image = [[UIImage imageNamed:@"bg_top"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
//            [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//            self.navigationController.navigationBar.tintColor = kButtonNormalColor;
//        }
    if ([self.navigationController.viewControllers count] > 1 )
    {
      [[self showLeft] enableBackGesture];
    }
    self.navigationController.navigationBar.tintColor = kWhiteColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor getColor:@"f4f4f4"] size:CGSizeMake(10, 10)] forBarMetrics:UIBarMetricsDefault];

//     self.navigationItem.titleView = self.customTitleLable;
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_leftButton);
    TT_RELEASE_SAFELY(_rightButton);
    TT_RELEASE_SAFELY(_titleView);
    TT_RELEASE_SAFELY(_customTitleLable);
    [super reduceMemory];
}

- (void) enableRightButton:(BOOL) flag
{
    [self.rightButton setEnabled:flag];
    [self.navigationItem.rightBarButtonItem setEnabled:flag];
}

//- (id) showLeft
//{
////    UIBarButtonItem *left = [[[UIBarButtonItem alloc] initWithCustomView:self.leftButton] autorelease];
////    self.navigationItem.leftBarButtonItem  = left;
//    return self;
//}

- (UIView *) titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [_titleView addSubview:[self customTitleLable]];
    }
    return _titleView;
}

//-(id)showLeftView
//{
//    UIBarButtonItem *left = [[[UIBarButtonItem alloc] initWithCustomView:self.leftButtonView] autorelease];
//    self.navigationItem.leftBarButtonItem  = left;
//    return self;
//}

- (id) showLeft
{
    
    UIBarButtonItem *right = [[[UIBarButtonItem alloc] initWithCustomView:self.leftView] autorelease];
    [self.navigationItem mySetLeftBarButtonItem:right];
    return self;
}


- (UIView *) leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        
        UIImageView *back = [[[UIImageView alloc] initWithFrame:CGRectMake(2, 7, 30, 30)] autorelease];
        back.image = [UIImage imageNamed:@"icon_back"];

        
        UIImageView *bgView = [[[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 60, 44)] autorelease];
//        bgView.image = [UIImage imageNamed:@"icon_default"];
        UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewAction:)] autorelease];
        
        [_leftView addGestureRecognizer:gesture];
        if ([self.navigationController.viewControllers count] > 1 )
        {
//            bgView.image = [UIImage imageNamed:@"back_home"];
            bgView.frame = CGRectMake(20, 2, 40, 40);
            [_leftView addSubview:back];
        }
        else
            [_leftView setShiftHorizon:-20.0f];
        [_leftView addSubview:bgView];
    }
    return _leftView;
}

- (void) leftViewAction:(UIGestureRecognizer *)recognizer
{
    [self leftButtonAction:nil];
}


- (id) showRight
{
    UIBarButtonItem *right = [[[UIBarButtonItem alloc] initWithCustomView:self.rightButton] autorelease];
    [self.navigationItem setRightBarButtonItem:right];
    return self;
}

- (id) hideRight
{
    self.navigationItem.rightBarButtonItem = nil;
    return self;
}

- (UIButton *) leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _leftButton.frame = CGRectMake(5, 7, 49, 33);
        _leftButton.titleLabel.font = HTFONTSIZE(kFontSize13);
        [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
        if (!IS_IOS_7_OR_GREATER) {
            [_leftButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        } else {
            [_leftButton setTitleColor:kWhiteColor forState:UIControlStateHighlighted];
            [_leftButton setTitleColor:kWhiteColor forState:UIControlStateSelected];
            [_leftButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [_leftButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        }
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *) rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _rightButton.frame = CGRectMake(5, 12, 49, 33);;
        [_rightButton setNormalImage:nil selectedImage:nil];
        _rightButton.titleLabel.font = HTFONTSIZE(kFontSize13);
        if (!IS_IOS_7_OR_GREATER) {
            [_rightButton setTitleColor:kOrangeColor forState:UIControlStateNormal];
            [_rightButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        } else {
            [_rightButton setTitleColor:kOrangeColor forState:UIControlStateNormal];
            [_rightButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        }
        [_rightButton.titleLabel setFont:HTFONTSIZE(16.0)];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if ([self.navigationController.viewControllers count] > 1 )
        [super setTitle:@"返回"];
    else
        [super setTitle:title];
    
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = HTFONTSIZE(20);
        //        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        titleView.textColor = [UIColor orangeColor]; // Change to desired color
        
        self.navigationItem.titleView = titleView;
        self.customTitleLable = titleView;
        [titleView release];
    }
    titleView.text = [title uppercaseString];
    [titleView sizeToFit];
}


- (void) setTitleContent:(NSString *) title
{
    self.title = title;
    self.customTitleLable.text = title;
    self.trackViewId = title;
}

- (IBAction)leftButtonAction:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)leftButtonViewAction:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightButtonAction:(id)sender
{
    
}

- (void) leftSwipGesture:(UIGestureRecognizer *) gesture
{
    [self leftButtonAction:nil];
}

- (NSString *)tabTitle
{
	return self.title;
}

- (UIView *) createTextField:(NSString *) title placeHolder:(NSString *)place tag:(NSInteger)tag column:(NSInteger)column height:(CGFloat)height delegate:(id)delegate
{
    
    UIView *background = [[[UIView alloc] initWithFrame:CGRectMake(0, 5 + (0  + height)* column , 290, height-10)] autorelease];
    UITextField * textField = [[[UITextField alloc] initWithFrame:CGRectMake(70, 0 , 215, height-10)] autorelease];
    textField.tag = tag;
    textField.placeholder = place;
    textField.delegate = delegate;
    textField.font = HTFONTSIZE(kFontSize14);
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.returnKeyType = UIReturnKeyNext;
    
    UILabel *leftView = [[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60,  20)] autorelease];
    leftView.backgroundColor = kClearColor;
    leftView.font = HTFONTSIZE(kFontSize14);
    leftView.textAlignment = NSTextAlignmentRight;
    leftView.text = title;
    
    [background addSubview:leftView];
    [background addSubview:textField];
    return background;
}


@end



@implementation ShareTitleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (id) showRight
{
    UIBarButtonItem *right = [[[UIBarButtonItem alloc] initWithCustomView:self.rightView] autorelease];
    [self.navigationItem mySetRightBarButtonItem:right];
    return self;
}



- (UIView *) rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 132, 44)];
        
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button0 setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"social"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
//        [CreateObject addTargetEfection:button0];
//        [CreateObject addTargetEfection:button1];
//        [CreateObject addTargetEfection:button2];
        
        button0.frame = CGRectMake(0, 0, 44, 44);
        button1.frame = CGRectMake(44, 0, 44, 44);
        button2.frame = CGRectMake(88, 0, 44, 44);
        
        int spaceWidth = 3;
        button0.imageEdgeInsets = UIEdgeInsetsMake(spaceWidth,spaceWidth,spaceWidth,spaceWidth);
        button1.imageEdgeInsets = UIEdgeInsetsMake(spaceWidth,spaceWidth,spaceWidth,spaceWidth);
        button2.imageEdgeInsets = UIEdgeInsetsMake(spaceWidth,spaceWidth,spaceWidth,spaceWidth);
        
        [_rightView addSubview:button0];
        [_rightView addSubview:button1];
        [_rightView addSubview:button2];
        
        [button0 addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button1 addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightView;
}


- (void) searchButtonAction:(id) sender
{
    Class class = NSClassFromString(@"ProductSearchExViewController");
    UIViewController *controller = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) shareButtonAction:(id) sender
{
    [self simpleShareAllButtonClickHandler:sender];
}

- (void) rightButtonAction:(id)sender
{
    NSArray *menuItems = nil;
    if ([[self currentUserId] length] == 0) {
        menuItems = @[
                      [KxMenuItem menuItem:@"Sign in"
                                     image:[UIImage imageNamed:@"home1"]
                                    target:self
                                    action:@selector(pushMenuItem0:)],
                      
                      [KxMenuItem menuItem:@"Setting"
                                     image:[UIImage imageNamed:@"home2"]
                                    target:self
                                    action:@selector(pushMenuItem1:)],
                      
                      [KxMenuItem menuItem:@"Languages"
                                     image:[UIImage imageNamed:@"home3"]
                                    target:self
                                    action:@selector(pushMenuItem2:)],
                      
                      //                      [KxMenuItem menuItem:@"Exit"
                      //                                     image:[UIImage imageNamed:@"home4"]
                      //                                    target:self
                      //                                    action:@selector(pushMenuItem3:)],
                      ];
        
    } else {
        menuItems = @[
                      [KxMenuItem menuItem:@"Sign out"
                                     image:[UIImage imageNamed:@"home1"]
                                    target:self
                                    action:@selector(pushMenuItem4:)],
                      
                      [KxMenuItem menuItem:@"My order"
                                     image:[UIImage imageNamed:@"home2"]
                                    target:self
                                    action:@selector(pushMenuItem5:)],
                      
                      [KxMenuItem menuItem:@"Setting"
                                     image:[UIImage imageNamed:@"home2"]
                                    target:self
                                    action:@selector(pushMenuItem1:)],
                      
                      [KxMenuItem menuItem:@"Languages"
                                     image:[UIImage imageNamed:@"home3"]
                                    target:self
                                    action:@selector(pushMenuItem2:)],
                      
                      //          [KxMenuItem menuItem:@"Exit"
                      //                         image:[UIImage imageNamed:@"home4"]
                      //                        target:self
                      //                        action:@selector(pushMenuItem3:)],
                      ];
        
    }
    
    [KxMenu setTintColor:kWhiteColor];
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(280, -40, 40, 40) menuItems:menuItems];
}

- (void) pushMenuItem0:(id)sender
{
    Class class = NSClassFromString(@"LoginViewController");
    UIViewController *vc1 = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:vc1 animated:YES];
}
- (void) pushMenuItem1:(id)sender
{
    Class class = NSClassFromString(@"SSettingViewController");
    UIViewController *vc1 = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (void) pushMenuItem2:(id)sender
{
    Class class = NSClassFromString(@"LanguageViewController");
    UIViewController *vc1 = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (void) pushMenuItem3:(id)sender
{
}

- (void) pushMenuItem4:(id)sender
{
    [UserDefaultsManager saveUserId:@""];
    [SVProgressHUD showSuccessWithStatus:@"Sign out success"];
}

- (void) pushMenuItem5:(id)sender
{
    Class class = NSClassFromString(@"MyOrderListViewController");
    UIViewController *vc1 = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:vc1 animated:YES];
}



// share function

- (void)simpleShareAllButtonClickHandler:(id)sender
{
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:IMAGE_NAME ofType:IMAGE_EXT];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:CONTENT
                                       defaultContent:CONTENT
                                                image:nil//[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    
    
    //结束定制信息
    ////////////////////////
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:[AppDelegate sharedAppDelegate].viewDelegate];
    
    //在授权页面中添加关注官方微博
    //    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
    //                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
    //                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
    //                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
    //                                    nil]];
    
    id<ISSShareOptions> shareOptions = [ShareSDK simpleShareOptionsWithTitle:@"内容分享"
                                                           shareViewDelegate:[AppDelegate sharedAppDelegate].viewDelegate];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog( @"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}



@end
