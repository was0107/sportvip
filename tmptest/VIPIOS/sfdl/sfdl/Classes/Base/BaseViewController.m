//
//  BaseViewController.m
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+extend.h"
#import "UserDefaultsManager.h"


@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor getColor:@"F3F2F2"];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
//    [NSNotificationCenter addObserver:self selector:@selector(currentCityChanged) forNotification:KCURRENTCITYSTRING object:nil];】
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if(IS_IOS_7_OR_GREATER && [self enableExtendLayout])
    {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
}


- (BOOL) enableExtendLayout
{
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
//    [self reduceMemory];
}

- (NSString *) trackViewId
{
    if (_trackViewId && _trackViewId.length > 0) {
        return _trackViewId;
    }
    return self.title;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [self.view endEditing:YES];
    [[DataTracker sharedInstance] endTrackPage:self.trackViewId];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view endEditing:NO];
    [[DataTracker sharedInstance] beginTrackPage:self.trackViewId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DEBUGLOG(@"******didReceiveMemoryWarning******");
//    [self reduceMemory];
}

- (void) dealloc
{
    [self reduceMemory];
    [super dealloc];
}

- (void) reduceMemory
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_trackViewId);
}

- (void) leftSwipGesture:(UIGestureRecognizer *) gesture
{
    
}

- (void) enableBackGesture
{
    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
    }
    UISwipeGestureRecognizer *swipGesture = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipGesture:)] autorelease];
    swipGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGesture];
}

- (id) setButtonImage:(UIButton *) button normal:(NSString *) Image higlited:(NSString *)selectImage
{
    UIImage *normalImage = [UIImage imageNamed:Image];
    UIImage *pressedImage = [UIImage imageNamed:selectImage];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:pressedImage forState:UIControlStateSelected];
    [button setImage:pressedImage forState:UIControlStateHighlighted];
    [button setImage:pressedImage forState:(UIControlStateHighlighted|UIControlStateSelected)];
    return self;
}

- (id) setButtonBackground:(UIButton *) button normal:(NSString *) bgImage higlited:(NSString *)bgSelectImage
{
    UIImage *normalImage = [[UIImage imageNamed:bgImage]stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    UIImage *higlitedImage = [[UIImage imageNamed:bgSelectImage]stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:higlitedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:higlitedImage forState:UIControlStateSelected];
    [button setBackgroundImage:higlitedImage forState:(UIControlStateHighlighted|UIControlStateSelected)];
    return self;
}

- (NSString *) currentCity
{
//    return [DefaultsManager city];
    return @"";
}

- (NSString *) currentUserId;
{
    return [UserDefaultsManager userId];
}

- (BOOL) didUserLogined
{
    return ([self currentUserId].length == 0 ) ? NO : YES;
}

- (void) currentCityChanged
{
    
}

- (NSString *)trimWhitespaceAndNewlineCharacter:(NSString *)rawString
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (int) checkYear:(int) year month:(int) month
{
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 2:
        {
            return (0 == year%400 || (0 == year % 4 && 0 != year % 100)) ? 29 : 28;
        }
            break;
        default:
            return 30;
            break;
    }
    return 30;
}


@end
