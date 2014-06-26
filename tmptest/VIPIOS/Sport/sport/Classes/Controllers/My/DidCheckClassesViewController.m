//
//  DidCheckClassesViewController.m
//  sport
//
//  Created by allen.wang on 6/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "DidCheckClassesViewController.h"
#import "ClassTableViewCell.h"
#import "TeacherTableViewCell.h"
#import "TeacherViewController.h"

@interface DidCheckClassesViewController ()

@end

@implementation DidCheckClassesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) tableViewType
{
    return eTypeNone;
}


- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight);
}

- (void) configTableView
{
    __block DidCheckClassesViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
       
        static NSString *identifier1 = @"HOME_TABLEVIEW_CELL_IDENTIFIER1";
        TeacherTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell1){
            cell1 = [[TeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        [cell1 configWithType:0];
        return (UITableViewCell *)cell1;

    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  (CGFloat)100.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)0;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return (CGFloat)0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TeacherViewController *controller = [[[TeacherViewController alloc] init] autorelease];
        [controller setHidesBottomBarWhenPushed:YES];
        [blockSelf.navigationController pushViewController:controller animated:YES];

    };
    
    self.tableView.refreshBlock = ^(id content) {
        [blockSelf sendRequestToServer];
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
