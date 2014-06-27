//
//  SearchViewController.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (nonatomic, retain) UIView   *titleView;
@property (nonatomic, retain) UIButton *mapButton;
@property (nonatomic, retain) UITextField  *searchTextView;
@end

@implementation SearchViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_titleView);
    TT_RELEASE_SAFELY(_mapButton);
    TT_RELEASE_SAFELY(_searchTextView);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    self.titleView.backgroundColor = kClearColor;
    [self configTitleView];
    self.navigationItem.titleView = self.titleView;
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"课程名",@"学校名",@"老师名", nil];
    self.titleArray = array;
    self.currentIndex = 0;
}

- (void) configTitleView
{
    self.mapButton                      = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mapButton.frame                = CGRectMake(188, 7, 54, 30);
    self.mapButton.backgroundColor      = kClearColor;
    [self.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.mapButton setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];

    
    UIView *bottomView                  = [[[UIView alloc] initWithFrame:CGRectMake(0, 7, 190, 30)] autorelease];
    bottomView.backgroundColor          = kClearColor;
    bottomView.layer.cornerRadius       = 4.0f;
    bottomView.layer.borderWidth        = 0.5f;
    bottomView.layer.borderColor        = [kLightGrayColor CGColor];
    
    UIImageView *searchIcon             = [[[UIImageView  alloc] initWithFrame:CGRectMake(5, 5, 20, 20)] autorelease];
    searchIcon.image                    = [UIImage imageNamed:@"icon_search"];
    [bottomView addSubview:searchIcon];
    
    self.searchTextView                 = [[[UITextField alloc] initWithFrame:CGRectMake(34, 0, 145, 30)] autorelease];
    self.searchTextView.font            = HTFONTSIZE(kFontSize14);
    self.searchTextView.backgroundColor = kClearColor;
    self.searchTextView.textColor       = kLightGrayColor;
    self.searchTextView.returnKeyType   = UIReturnKeySearch;
    self.searchTextView.placeholder     = @"搜索课程";
    [bottomView addSubview:self.searchTextView];
    [self.titleView addSubview:self.mapButton];
    [self.titleView addSubview:bottomView];
}

- (IBAction)mapButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) didSelected:(NSUInteger ) index
{

}

- (void) configTableView
{
    __weak SearchViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"SEARCH_TABLEVIEW_CELL_IDENTIFIER0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return (UITableViewCell *)cell;
    };

    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return 11;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    self.tableView.refreshBlock = ^(id content) {
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    [self.view addSubview:self.tableView];
    
    [self dealWithData];
    
    //    [self.tableView doSendRequest:YES];
}

- (void) dealWithData
{
    //    self.tableView.didReachTheEnd = [_response lastPage];
    //    if ([self.response isEmpty]) {
    //        [self.tableView showEmptyView:YES];
    //    }
    //    else {
    //        [self.tableView showEmptyView:NO];
    //    }
    [self.tableView reloadData];
}


- (void) sendRequestToServer
{
    [self dealWithData];
}


@end
