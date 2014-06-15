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
#import "UIImage+tintedImage.h"

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

- (id) showLeft
{
//    UIBarButtonItem *left = [[[UIBarButtonItem alloc] initWithCustomView:self.leftButton] autorelease];
//    self.navigationItem.leftBarButtonItem  = left;
    return self;
}

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
            [_rightButton setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];
            [_rightButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        } else {
            [_rightButton setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];
            [_rightButton setBackgroundImage:@"nav_button_normal" selectedImage:@"nav_button_selected" clickImage:@"nav_button_selected"];
        }
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UILabel *)customTitleLable
{
    if (!_customTitleLable) {
        _customTitleLable  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        _customTitleLable.font = HTFONTSIZE(20);
        _customTitleLable.textColor = kBlackColor;
        _customTitleLable.backgroundColor = kClearColor;
        _customTitleLable.textAlignment = NSTextAlignmentCenter;
        _customTitleLable.text = @"mpmc";
    }
    return _customTitleLable;
}

- (void)setTitle:(NSString *)title
{
    if ([self.navigationController.viewControllers count] > 1 )
    {
        [super setTitle:@"返回"];
    } else {
        [super setTitle:title];
    }
////    self.customTitleLable.text = title;
//    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
//    if (!titleView) {
//        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
//        titleView.backgroundColor = [UIColor clearColor];
//        titleView.font = HTFONTSIZE(20);
////        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//        
//        titleView.textColor = kBlackColor; // Change to desired color
//        
//        self.navigationItem.titleView = titleView;
//        self.customTitleLable = titleView;
//        [titleView release];
//    }
//    titleView.text = title;
//    [titleView sizeToFit];
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
    leftView.textAlignment = UITextAlignmentRight;
    leftView.text = title;
    
    [background addSubview:leftView];
    [background addSubview:textField];
    return background;
}


@end
