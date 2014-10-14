//
//  UserCenterViewController.m
//  sfdl
//
//  Created by micker on 14-9-15.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showType] showRight];
    [self setTitleContent:NSLocalizedString(@"USER CENTER",@"USER CENTER")];
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (CGRect)tableViewFrame
{
    return kContentWithTabBarFrame;
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
            cell.contentView.backgroundColor = kWhiteColor;
            [cell.contentView addSubview:cell.topLabel];
        }
        cell.topLabel.text = NSLocalizedString(titleIndexArray[indexPath.row],titleIndexArray[indexPath.row]);
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
