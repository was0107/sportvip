//
//  PopInputView.m
//  sfdl
//
//  Created by micker on 14-9-23.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "PopInputView.h"
#import "CreateObject.h"
#import "ProductListViewController.h"
#define kSemiModalAnimationDuration 0.3f

@interface PopInputView()<UITextFieldDelegate>
@property (nonatomic, retain) UIButton *searchButton;
@property (nonatomic, retain) UITextField *textField;

@end

@implementation PopInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        self.frame = CGRectMake(0, 0, size.width, size.height);
        [self createInternalView];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_searchButton);
    TT_RELEASE_SAFELY(_textField);
    [super dealloc];
}

- (void) createInternalView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(5, 40, 310, 135)] autorelease];
    view.backgroundColor = kWhiteColor;
    view.clipsToBounds = YES;
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(5, 6, 310, 35)] autorelease];
    self.textField.backgroundColor = kClearColor;
    self.textField.placeholder = @"Product";
    self.textField.textColor = kDarkGrayColor;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    UIView *left = [[[UIView alloc] initWithFrame:CGRectMake(0, 10, 310, 35)] autorelease];
    left.backgroundColor = [UIColor colorWithWhite:0.667f alpha:0.2f];
    [left addSubview:self.textField];
    [view addSubview:left];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake(205, 10, 100, 35);
    self.searchButton.backgroundColor = kClearColor;
    [self.searchButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [CreateObject addTargetEfection:self.searchButton];
    [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.searchButton];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(5, 55, 64, 20)] autorelease];
    label.text = @"Keywords:";
    label.textColor = kOrangeColor;
    label.font = HTFONTSIZE(kFontSize13);
    [view addSubview:label];

    label = [[[UILabel alloc] initWithFrame:CGRectMake(73, 46, 230, 90)] autorelease];
    label.text = @"With all the, advantages of ,soundproof sets, Suitable for outdoor works, Towing devices is , set aside on the wheel chassis to, keep alance Equipped with, warning lamp";
    label.textColor = kLightGrayColor;
    label.numberOfLines = 4;
    label.font = HTFONTSIZE(kFontSize12);
    
    [view addSubview:label];
    
    [self addSubview:view];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)searchButtonAction:(id)sender
{
    NSString *textString = self.textField.text ;
    [self dismiss];
    if ([textString length] > 0) {
        ProductListViewController *listViewController = [[[ProductListViewController alloc] init] autorelease];
        listViewController.sectionTitle = textString;
        listViewController.searchText = textString;
        [self.controller.navigationController hidesBottomBarWhenPushed];
        [self.controller.navigationController pushViewController:listViewController animated:YES];
    }
}


- (void)show
{
    [self _presentModelView];
    self.isShowing = YES;
}

- (void)dismiss
{
    [self _dismissModalView];
    self.isShowing = NO;
}


- (void)_presentModelView
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    NSLog(@"%@", keywindow);
    if (![keywindow.subviews containsObject:self]) {
        // Calulate all frames
        CGRect vf = keywindow.frame;
        // Add semi overlay
        UIView * overlay = [[UIView alloc] initWithFrame:vf];
        overlay.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        
        UIView* ss = [[UIView alloc] initWithFrame:keywindow.bounds];
        ss.backgroundColor = [UIColor colorWithWhite:0.1f alpha:0.5f];
        [overlay addSubview:ss];
        [keywindow addSubview:overlay];
        
        UIControl * dismissButton = [[UIControl alloc] initWithFrame:CGRectZero];
        [dismissButton addTarget:self action:@selector(_dismissModalView) forControlEvents:UIControlEventTouchUpInside];
        dismissButton.backgroundColor = [UIColor clearColor];
        dismissButton.frame = CGRectMake(0, 0, 320, 900);
        [overlay addSubview:dismissButton];
        
        // Present view animated
        self.frame = CGRectMake(0, 60, vf.size.width, 120);
        [keywindow addSubview:self];
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.8;
        
        [self.textField becomeFirstResponder];
    }
}

- (void)_dismissModalView
{
    [self.textField resignFirstResponder];
    UIWindow * keywindow = [[UIApplication sharedApplication] keyWindow];
    if (keywindow.subviews.count <2) {
        return;
    }
    UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
    UIView * overlay = [keywindow.subviews objectAtIndex:keywindow.subviews.count-2];
    modal.frame = CGRectMake(0, keywindow.frame.size.height, modal.frame.size.width, modal.frame.size.height);
    [overlay removeFromSuperview];
    [modal removeFromSuperview];
    
    // Begin overlay animation
    UIImageView * ss = (UIImageView*)[overlay.subviews objectAtIndex:0];
    ss.alpha = 1;
}



@end
