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
#import <objc/runtime.h>
#import <objc/message.h>
#import "CreateObject.h"
#import "UINavigationItem+Space.h"
#import "XLCycleScrollView.h"
#import "UIImageLabelEx.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "BaseWebViewController.h"
#import "ProductSearchExViewController.h"
#import "AppDelegate.h"

@interface RootViewController ()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView *cycleView;
@property (nonatomic, retain) UIImageView   *topImageView;
@property (nonatomic, retain) CustomSearchBar *searchView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configControllers];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.cycleView];

    [self sendRequestToServer];
    [self sendRequestToGetMenu];
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
                                  @"",@"",@"",@"DealerViewController",
                                  ];
    int position = titleButton.tag - 1000;
    if (self.menuResponse) {
        MenuItem  *menuItem = [self.menuResponse at:position];
        if (menuItem) {
            if ([menuItem isNULL]) {
                BaseWebViewController *webController = [[[BaseWebViewController alloc] init] autorelease];
                webController.title = menuItem.menu_name;
                webController.requestURL = menuItem.menu_url;
                [self.navigationController pushViewController:webController animated:YES];
                return;
            }
        }
    }
    if ([controllersArray[position] length] == 0) {
        return;
    }
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
            if (!menuItem) {
                break;
            }
            [button setText:menuItem.menu_name image:menuItem.icon];
        }
    }

}

- (void) sendRequestToGetMenu
{
    __block typeof(self) blockSelf = self;
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
