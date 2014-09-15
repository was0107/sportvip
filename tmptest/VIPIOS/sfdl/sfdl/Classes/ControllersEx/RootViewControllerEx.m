//
//  RootViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "RootViewControllerEx.h"
#import "BaseTitleViewController.h"

#import "UIMenuBar.h"


@interface RootViewControllerEx ()<UIMenuBarDelegate>
@property (nonatomic, retain) UIMenuBar *menuBar;
@end

@implementation RootViewControllerEx


@synthesize menuBar   = _menuBar;
@synthesize currentFrom = _currentFrom;

- (id)initWithTabBarHeight:(NSUInteger)height
{
    self = [super initWithTabBarHeight:height];
    [self setMinimumHeightToDisplayTitle:20.0];
    return [self configControllers];
}

- (void )dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_menuBar);
    [super dealloc];
}

- (id) configControllers
{
    NSMutableArray *arrayVC = [NSMutableArray array];
    
    [arrayVC addObject:[self createItem:@"HomeViewControllerEx" title:@"Home"]];
    [arrayVC addObject:[self createItem:@"InquiryViewControllerEx" title:@"Inquiry"]];
    [arrayVC addObject:[self createItem:@"MenuViewControllerEx" title:@"Menu"]];
    
//    self.tabEdgeColor = [UIColor getColor:@"bdbdbd"];
    self.tabEdgeColor = [UIColor whiteColor];
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor whiteColor];
    [self setViewControllers:arrayVC];
    self.delegate = self;
    return self;
}

- (id) createItem:(NSString *) controller title:(NSString *) title
{
    Class class = NSClassFromString(controller);
    BaseTitleViewController *vc1 = [[[class alloc] init] autorelease];
    vc1.title = title;
    UINavigationController *nav1 = [[[UINavigationController alloc] initWithRootViewController:vc1] autorelease];
    nav1.navigationBar.tintColor = [UIColor orangeColor];
    nav1.navigationBar.backgroundColor = [UIColor getColor:@"f4f4f4"];
    return nav1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    self.view.frame = CGRectMake(0, 0, 320, 568);
    //    self.view.frame = kFullFrame;
}


- (BOOL) canChangeToContoller:(UIViewController *)controller
{
    if ([[controller.title uppercaseString] isEqualToString:@"MENU"]) {
        [self popMenuAction:nil];
        return NO;
    }
    [self clickAction:nil];
    return YES;
}

- (UIMenuBar *) menuBar
{
    if (!_menuBar) {
        UIMenuBarItem *menuItem1 = [[UIMenuBarItem alloc] initWithTitle:@"About us" target:self image:[UIImage imageNamed:@"about"] action:@selector(clickAction:)];
        UIMenuBarItem *menuItem2 = [[UIMenuBarItem alloc] initWithTitle:@"News" target:self image:[UIImage imageNamed:@"news"] action:@selector(clickAction:)];
        UIMenuBarItem *menuItem3 = [[UIMenuBarItem alloc] initWithTitle:@"User Center" target:self image:[UIImage imageNamed:@"users"] action:@selector(clickAction:)];
        UIMenuBarItem *menuItem4 = [[UIMenuBarItem alloc] initWithTitle:@"Find Your Dealer" target:self image:[UIImage imageNamed:@"search_jxs"] action:@selector(clickAction:)];
        UIMenuBarItem *menuItem5 = [[UIMenuBarItem alloc] initWithTitle:@"Contact Us" target:self image:[UIImage imageNamed:@"contact"] action:@selector(clickAction:)];
        UIMenuBarItem *menuItem6 = [[UIMenuBarItem alloc] initWithTitle:@"Logout" target:self image:[UIImage imageNamed:@"quite"] action:@selector(clickAction:)];
        
        NSMutableArray *items =
        [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6,nil];
        
        _menuBar = [[UIMenuBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140.0f) items:items];
        _menuBar.backgroundColor = [UIColor getColor:@"f4f4f4"];
        _menuBar.alpha = 0.8f;
        //menuBar.layer.borderWidth = 1.f;
        //menuBar.layer.borderColor = [[UIColor orangeColor] CGColor];
        //menuBar.tintColor = [UIColor orangeColor];
        _menuBar.delegate = self;
    }
    
    return _menuBar ;
}

- (void)popMenuAction:(id)sender
{
    if (!self.menuBar.isShowing) {
        [self.menuBar show];
        return;
    }
    [self clickAction:nil];
}

- (void)clickAction:(id)sender
{
    if (self.menuBar.isShowing) {
        [self.menuBar dismiss];
    }
}

@end
