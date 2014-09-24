//
//  RootViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "RootViewControllerEx.h"
#import "BaseTitleViewController.h"
#import "UserDefaultsManager.h"
#import "UIMenuBar.h"
#import "InquiryFormViewController.h"
#import "ProductDetailViewControllerEx.h"

@interface RootViewControllerEx ()<UIMenuBarDelegate>
@property (nonatomic, retain) UIMenuBar *menuBar;
@property (nonatomic, retain) BaseTitleViewController *menuController;
@end

@implementation RootViewControllerEx


@synthesize menuBar   = _menuBar;
@synthesize currentFrom = _currentFrom;

- (id)initWithTabBarHeight:(NSUInteger)height
{
    self = [super initWithTabBarHeight:height];
    [self setMinimumHeightToDisplayTitle:20.0];
    self.tabStrokeColor = kOrangeColor;
    [self sendRequestToGetCompanyServer];
    return [self configControllers];
}

- (void )dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_menuBar);
    TT_RELEASE_SAFELY(_menuController);
    [super dealloc];
}

- (id) configControllers
{
    NSMutableArray *arrayVC = [NSMutableArray array];
    
    [arrayVC addObject:[self createItem:@"HomeViewControllerEx" title:@"Home"]];
    [arrayVC addObject:[self createItem:@"InquiryFormViewController" title:@"Inquiry"]];
    
//    self.menuController = (UINavigationController *)[self createItem:@"MenuViewControllerEx" title:@"Menu"];
    [arrayVC addObject:[self createItem:@"MenuViewControllerEx" title:@"Menu"]];
    
    self.tabEdgeColor = [UIColor getColor:@"bdbdbd"];
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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL) canChangeToContoller:(UIViewController *)controller
{
    if ([[controller.title uppercaseString] isEqualToString:@"MENU"]) {
        [self popMenuAction:nil];
        return NO;
    }
    
    UINavigationController *navigationController = [self.viewControllers objectAtIndex:0];
    if ([[navigationController.viewControllers lastObject] isKindOfClass:[ProductDetailViewControllerEx class]] &&
        [[controller.title uppercaseString] isEqualToString:@"INQUIRY FORM"] ) {
        ProductDetailViewControllerEx *productListController = (ProductDetailViewControllerEx *)[navigationController.viewControllers lastObject];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INQUIRYFORM" object:productListController.productItem];
    }
    [self dissmissMenubar];
    return YES;
}

- (void)sendRequestToGetCompanyServer
{
    __unsafe_unretained typeof(self) blockSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        blockSelf.aboutResponse = [[[AboutUsResponse alloc] initWithJsonString:content] autorelease];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendRequestToGetCompanyServer" object:nil];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    CompanyInfoRequest *infoRequest = [[[CompanyInfoRequest alloc] init] autorelease];
    [WASBaseServiceFace serviceWithMethod:[infoRequest URLString] body:[infoRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}



- (NSMutableArray *) getMenuArrays
{
    UIMenuBarItem *menuItem1 = [[[UIMenuBarItem alloc] initWithTitle:@"About us" target:self image:[UIImage imageNamed:@"about"] action:@selector(clickAction1:) controller:@""] autorelease];
    UIMenuBarItem *menuItem2 = [[[UIMenuBarItem alloc] initWithTitle:@"News" target:self image:[UIImage imageNamed:@"news"] action:@selector(clickAction2:) controller:@""] autorelease];
    UIMenuBarItem *menuItem3 = [[[UIMenuBarItem alloc] initWithTitle:@"User Center" target:self image:[UIImage imageNamed:@"users"] action:@selector(clickAction3:) controller:@""] autorelease];
    UIMenuBarItem *menuItem4 = [[[UIMenuBarItem alloc] initWithTitle:@"Find Your Dealer" target:self image:[UIImage imageNamed:@"search_jxs"] action:@selector(clickAction4:) controller:@""] autorelease];
    UIMenuBarItem *menuItem5 = [[[UIMenuBarItem alloc] initWithTitle:@"Contact Us" target:self image:[UIImage imageNamed:@"contact"] action:@selector(clickAction5:) controller:@""] autorelease];
    UIMenuBarItem *menuItem6 = [[[UIMenuBarItem alloc] initWithTitle:([UserDefaultsManager userName].length == 0 ) ? @"Login":@"Logout" target:self image:[UIImage imageNamed:@"quite"] action:@selector(clickAction6:) controller:@""] autorelease];
    
   return [NSMutableArray arrayWithObjects:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6,nil];
}

- (UIMenuBar *) menuBar
{
    if (!_menuBar) {
        _menuBar = [[UIMenuBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 140.0f) items:[NSMutableArray array]];
        _menuBar.backgroundColor = [UIColor getColor:@"f4f4f4"];
        _menuBar.alpha = 0.8f;
        _menuBar.delegate = self;
    }
    
    return _menuBar ;
}

- (void)popMenuAction:(id)sender
{
    if (!self.menuBar.isShowing) {
        [self.menuBar setItems:[self getMenuArrays]];
        [self.menuBar show];
        return;
    }
    [self dissmissMenubar];
}

- (void)dissmissMenubar
{
    if (self.menuBar.isShowing) {
        [self.menuBar dismiss];
    }
}

- (void) goToViewController:(NSString *) controller
{
    Class class = NSClassFromString(controller);
    if (class) {
        BaseTitleViewController *controller = [[[class alloc] init] autorelease];
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)clickAction1:(id)sender
{
    [self goToViewController:@"AboutUsViewController"];
    [self dissmissMenubar];
}

- (void)clickAction2:(id)sender
{
    [self goToViewController:@"NewsViewController"];
    [self dissmissMenubar];
}

- (void)clickAction3:(id)sender
{
    if ([UserDefaultsManager userName].length == 0 ) {
        [self goToViewController:@"LoginViewController"];
    } else {
        [self goToViewController:@"UserCenterViewController"];
    }
    [self dissmissMenubar];
}

- (void)clickAction4:(id)sender
{
    [self goToViewController:@"DealerViewController"];
    [self dissmissMenubar];
}

- (void)clickAction5:(id)sender
{
    [self goToViewController:@"ContactUsViewController"];
    [self dissmissMenubar];
}

- (void)clickAction6:(id)sender
{
    if ([UserDefaultsManager userName].length == 0 ) {
        [self goToViewController:@"LoginViewController"];
    } else {
        [UserDefaultsManager saveUserName:@""];
    }
    [self dissmissMenubar];
}





@end
