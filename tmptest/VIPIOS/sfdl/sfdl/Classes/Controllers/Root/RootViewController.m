//
//  RootViewController.m
//  sport
//
//  Created by allen.wang on 5/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "RootViewController.h"
#import "CustomSearchBar.h"
#import "CustomImageTitleButton.h"
#import "SearchViewController.h"
#import "KxMenu.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "CreateObject.H"
#import "UINavigationItem+Space.h"

@interface RootViewController ()
@property (nonatomic, retain) UIImageView   *topImageView;
@property (nonatomic, retain) CustomSearchBar *searchView;
@property (nonatomic, retain) UIView          *rightView;
@end

@implementation RootViewController
{
    
}

- (void )dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id) showRight
{
    UIBarButtonItem *right = [[[UIBarButtonItem alloc] initWithCustomView:self.rightView] autorelease];
//    self.navigationItem.rightBarButtonItem = right;
    
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

        [button0 setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        [CreateObject addTargetEfection:button0];
        [CreateObject addTargetEfection:button1];
        [CreateObject addTargetEfection:button2];

        button0.frame = CGRectMake(0, 0, 44, 44);
        button1.frame = CGRectMake(44, 0, 44, 44);
        button2.frame = CGRectMake(88, 0, 44, 44);
        
        [_rightView addSubview:button0];
        [_rightView addSubview:button1];
        [_rightView addSubview:button2];
        
        [button2 addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showRight];
//    [[[self showRight] rightButton] setTitle:@"注册" forState:UIControlStateNormal];
    [self configControllers];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.topImageView];
    self.title = @"MPMC";
}

- (void) rightButtonAction:(id)sender
{
    NSArray *menuItems =
    @[
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
      
      [KxMenuItem menuItem:@"Exit"
                     image:[UIImage imageNamed:@"home4"]
                    target:self
                    action:@selector(pushMenuItem3:)],
      ];
    
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



- (id) configControllers
{
    
    NSArray *titleIndexArray = @[@"Solution",@"Genuine Parts",@"Download",@"Exhibition",@"About Us",@"Products",@"News",@"Contact Us"];
    
    NSArray *imageIndexArray = @[@"home9",@"home10",@"home11",@"home12",@"home5",@"home6",@"home7",@"home8"];
    int flag =  (iPhone5) ? 120 : 110;
    int tag = 1000;
    for (int j = 2 ; j > 0; j--) {
        for (int i = 0 ; i < 4; i++) {
            tag =4 * (j - 1) + i;
        CustomImageTitleButton *button = [[[CustomImageTitleButton alloc] initWithFrame:CGRectMake(4 + 79 * i, kContentBoundsHeight - flag * j, 75, 100)] autorelease];
        button.topButton.tag =  1000+tag;
        [button.topButton addTarget:self action:@selector(didTaped:) forControlEvents:UIControlEventTouchUpInside];
        [button setText:titleIndexArray[tag] image:imageIndexArray[tag]];
        [self.view addSubview:button];
        }
    }
       return self;
}

- (IBAction)didTaped:(id)sender
{
    UIButton *button = (UIButton *) sender;
    NSArray *controllersArray = @[@"ProductSearchViewController",@"LeaveMessageViewController",@"LoginViewController",@"NewsViewController", \
                                  @"AboutUsViewController",@"ProductCategoryViewController",@"NewsViewController",@"ContactUsViewController"];
    Class class = NSClassFromString(controllersArray[button.tag - 1000]);
    UIViewController *vc1 = [[[class alloc] init] autorelease];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (id) createItem:(NSString *) controller title:(NSString *) title
{

    return self;
}

- (CustomSearchBar *) searchView
{
    if (!_searchView) {
        __block RootViewController *blockSelf = self;
        _searchView = [[CustomSearchBar alloc] initWithFrame:CGRectMake(0, 0.0,320,52.0)];
        _searchView.backgroundColor = kGridTableViewColor;
        _searchView.completeBlok = ^(NSString *result) {
            if (result.length > 0) {
                SearchViewController *controller = [[[SearchViewController alloc] init] autorelease];
                controller.secondTitleLabel.text = result;
                [blockSelf.navigationController hidesBottomBarWhenPushed];
                [blockSelf.navigationController pushViewController:controller animated:YES];
            }
        };
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

@end
