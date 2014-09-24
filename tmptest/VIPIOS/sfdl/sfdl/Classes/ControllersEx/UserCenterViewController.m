//
//  UserCenterViewController.m
//  sfdl
//
//  Created by boguang on 14-9-15.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

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
    [self setTitleContent:@"USER CENTER"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (void) configTableView
{
    __unsafe_unretained typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    NSArray *titleIndexArray = @[@"Inquiry", @"Browsing history",@"Change the password", ];
    NSArray *controllerIndexArray = @[@"InquiryViewControllerEx",@"BrowsingHistoryViewController",@"ChangePasswordViewController"];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
        BaseSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseSingleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            [cell.contentView addSubview:cell.topLabel];
        }
        cell.topLabel.text = titleIndexArray[indexPath.row];
        return cell;
    };
    
//    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
//        return  80.0f;
//    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[controllerIndexArray count];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *controller = controllerIndexArray[indexPath.row];
        Class class = NSClassFromString(controller);
        BaseTitleViewController *vc1 = [[[class alloc] init] autorelease];
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:vc1 animated:YES];
    };
    
    
    [self.view addSubview:self.tableView];
}



@end
