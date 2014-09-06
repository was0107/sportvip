//
//  RootViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "RootViewControllerEx.h"
#import "BaseTitleViewController.h"

@interface RootViewControllerEx ()

@end

@implementation RootViewControllerEx

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
    
    [arrayVC addObject:[self createItem:@"HomeViewControllerEx" title:@"Home"]];
    [arrayVC addObject:[self createItem:@"InquiryViewControllerEx" title:@"Inquiry"]];
    [arrayVC addObject:[self createItem:@"InquiryViewControllerEx" title:@"Menu"]];
    
//    self.tabEdgeColor = [UIColor getColor:@"bdbdbd"];
    self.tabEdgeColor = [UIColor whiteColor];
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor blackColor];
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
        return NO;
    }
    return YES;
}

@end
