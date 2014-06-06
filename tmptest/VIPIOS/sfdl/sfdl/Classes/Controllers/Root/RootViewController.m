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

@interface RootViewController ()
@property (nonatomic, retain) UIImageView   *topImageView;
@property (nonatomic, retain) CustomSearchBar *searchView;
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
    [self.view addSubview:self.topImageView];
    self.title = @"MPMC";
}

- (id) configControllers
{
    int flag =  (iPhone5) ? 120 : 110;
    for (int j = 2 ; j > 0; j--) {
        for (int i = 0 ; i < 4; i++) {

        CustomImageTitleButton *button = [[[CustomImageTitleButton alloc] initWithFrame:CGRectMake(4 + 79 * i, kContentBoundsHeight - flag * j, 75, 100)] autorelease];
        [self.view addSubview:button];
        }
    }
       return self;
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
            SearchViewController *controller = [[[SearchViewController alloc] init] autorelease];
            controller.secondTitleLabel.text = result;
            [blockSelf.navigationController hidesBottomBarWhenPushed];
            [blockSelf.navigationController pushViewController:controller animated:YES];
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
