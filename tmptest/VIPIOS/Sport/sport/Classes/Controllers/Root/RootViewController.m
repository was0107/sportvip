//
//  RootViewController.m
//  sport
//
//  Created by allen.wang on 5/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
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
    [super dealloc];
}

- (id) configControllers
{
    NSMutableArray *arrayVC = [NSMutableArray array];
    
    [arrayVC addObject:[self createItem:@"HomeViewController" title:@"b5m"]];
    [arrayVC addObject:[self createItem:@"MyViewController" title:@"个人中心"]];
    [arrayVC addObject:[self createItem:@"SettingViewController" title:@"设置"]];
    
    self.tabEdgeColor = [UIColor getColor:@"bdbdbd"];
    self.textColor = [UIColor getColor:@"9e9e9e"];
    self.selectedTextColor = [UIColor getColor:KCustomGreenColor];
    [self setViewControllers:arrayVC];
    self.delegate = self;
    return self;
}

- (id) createItem:(NSString *) controller title:(NSString *) title
{
    Class class = NSClassFromString(controller);
    UIViewController *vc1 = [[[class alloc] init] autorelease];
    vc1.title = title;
    UINavigationController *nav1 = [[[UINavigationController alloc] initWithRootViewController:vc1] autorelease];
    nav1.navigationBar.tintColor = [UIColor getColor:KCustomGreenColor];
    nav1.navigationBar.backgroundColor = [UIColor getColor:@"F3F2F2"];
    return nav1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = kFullFrame;
}


- (BOOL) canChangeToContoller:(UIViewController *)controller
{
    return YES;
}

@end
