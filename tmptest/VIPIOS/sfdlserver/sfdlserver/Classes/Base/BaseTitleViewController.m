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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kButtonNormalColor size:CGSizeMake(10, 10)] forBarMetrics:UIBarMetricsDefault];

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
        bgView.image = [UIImage imageNamed:@"icon_default"];
        
        UITapGestureRecognizer *gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftViewAction:)] autorelease];
        
        [_leftView addGestureRecognizer:gesture];
        if ([self.navigationController.viewControllers count] > 1 )
            [_leftView addSubview:back];
        else
            [_leftView setShiftHorizon:-15.0f];
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
            [_rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [_rightButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        } else {
            [_rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
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
        titleView.font = HTFONTSIZE(18);
        titleView.textColor = kWhiteColor; // Change to desired color
        self.navigationItem.titleView = titleView;
        self.customTitleLable = titleView;
        [titleView release];
    }
    titleView.text = title;
    [titleView sizeToFit];

}

- (void) setTitleContent:(NSString *) title
{
    self.title = title;
//    self.customTitleLable.text = title;
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
