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
#import "XLCycleScrollView.h"
#import "UIImageLabelEx.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "BaseWebViewController.h"

@interface RootViewController ()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView *cycleView;
@property (nonatomic, retain) UIImageView   *topImageView;
@property (nonatomic, retain) CustomSearchBar *searchView;
@property (nonatomic, retain) UIView          *rightView;

@property (nonatomic, retain) PictureResponse    *pictureResponse;
@property (nonatomic, retain) PictureListRequest *pictureRequest;


@property (nonatomic, retain) MenuResponse       *menuResponse;
@property (nonatomic, retain) MenuListRequest    *menuRequest;
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
    [[self showRight] showLeft];
//    [[[self showRight] rightButton] setTitle:@"注册" forState:UIControlStateNormal];
    [self configControllers];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.cycleView];

    [self sendRequestToServer];
    [self sendRequestToGetMenu];
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
    NSArray *titleIndexArray = @[@"About Us",@"Products",@"News",@"Contact Us",@"Solution",@"Genuine Parts",@"Download",@"Agent"];
    NSArray *imageIndexArray = @[@"home5",@"home6",@"home7",@"home8",@"home9",@"home10",@"home11",@"home12"];
    int flag =  (iPhone5) ? 120 : 110;
    int tag = 1000;
    for (int j = 0 ; j < 2 ; j++) {
        for (int i = 0 ; i < 4; i++) {
            tag =4 * j + i;
            CustomImageTitleButton *button = [[[CustomImageTitleButton alloc] initWithFrame:CGRectMake(4 + 79 * i, kContentBoundsHeight - flag * (2-j), 75, 100)] autorelease];
            button.tag =  1000+tag;
            
//            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)] autorelease];
//            label.text = kIntToString(tag);
//            [button addSubview:label];
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
    CustomImageTitleButton *titleButton = (CustomImageTitleButton *)button.superview;
    NSArray *controllersArray = @[@"AboutUsViewController",@"ProductCategoryViewController",@"NewsViewController",@"ContactUsViewController",\
                                  @"ProductSearchViewController",@"LeaveMessageViewController",@"LoginViewController",@"AgentListViewController",
                                  ];
    int position = titleButton.tag - 1000;
//    if (self.menuResponse) {
//        MenuItem  *menuItem = [self.menuResponse at:position];
//        if (menuItem) {
//            if ([menuItem isNULL]) {
//                BaseWebViewController *webController = [[[BaseWebViewController alloc] init] autorelease];
//                webController.title = menuItem.menu_name;
//                webController.requestURL = menuItem.menu_url;
//                [self.navigationController pushViewController:webController animated:YES];
//                return;
//            }
//        }
//    }
    Class class = NSClassFromString(controllersArray[position]);
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


- (void) sendRequestToServer
{
    __block RootViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        if ([_pictureRequest isFristPage]) {
            blockSelf.pictureResponse = [[PictureResponse alloc] initWithJsonString:content];
        } else {
            [blockSelf.pictureResponse appendPaggingFromJsonString:content];
        }
        [_pictureRequest nextPage];
        [_cycleView reloadData];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_pictureRequest) {
        self.pictureRequest = [[[PictureListRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.pictureRequest URLString] body:[self.pictureRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}



#pragma mark - XLCycleScrollViewDatasource

- (XLCycleScrollView *)cycleView
{
    if (!_cycleView) {
        
        int flag =  (iPhone5) ? 120 : 110;
        int flag1 =  (iPhone5) ? 0 : 44;
        _cycleView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 60.0,320, kContentBoundsHeight- kContentBoundsHeight + 2 * flag - 60.0f - flag1)];
        _cycleView.delegate = self;
        _cycleView.dataSource = self;
        [_cycleView reloadData];
    }
    return _cycleView;
}

- (NSInteger)numberOfPages
{
    return [self.pictureResponse count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    int flag =  (iPhone5) ? 120 : 110;
    int flag1 =  (iPhone5) ? 0 : 44;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0,320, kContentBoundsHeight- kContentBoundsHeight + 2 * flag - 60.0f - flag1)];
    imageView.image = [UIImage imageNamed:@"icon"];
    PictureItem *pictureItem = [self.pictureResponse at:index];
    [imageView setImageWithURL:[NSURL URLWithString:pictureItem.mediaUrl]
                       placeholderImage:[UIImage imageNamed:kImageDefault]
                                success:^(UIImage *image){
                                    UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(320, 120)];
                                    imageView.image = image1;
                                    
                                }
                                failure:^(NSError *error){
                                    imageView.image = [UIImage imageNamed:kImageDefault];
                                }];

    
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    DEBUGLOG(@"selected index:%ld", (long)index);
}

- (void) configWithMenu
{
    int tag = 1000;
    for (int j = 0 ; j < 2; j++) {
        for (int i = 0 ; i < 4; i++) {
            tag =4 * j + i;
            CustomImageTitleButton *button = (CustomImageTitleButton *)[self.view viewWithTag:1000+tag];
            MenuItem *menuItem = [self.menuResponse at:tag ];
            [button setText:menuItem.menu_name image:menuItem.icon];
        }
    }

}

- (void) sendRequestToGetMenu
{
    __weak RootViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.menuResponse = [[[MenuResponse alloc] initWithJsonString:content] autorelease];
        [self configWithMenu];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_menuRequest) {
        self.menuRequest = [[[MenuListRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.menuRequest URLString] body:[self.menuRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];

}



@end
