//
//  MyViewController.m
//  sport
//
//  Created by allen.wang on 5/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "LoginViewController.h"
#import "ModifyPWDViewController.h"
#import "OrdersViewController.h"
#import "RegisterViewController.h"
#import "CheckClassViewController.h"
#import "DidCheckClassesViewController.h"
#import "DidContactClassesViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)tabImageName
{
    return @"icon_tabbar_user_f";
}

- (NSString *)tabSelectedImageName
{
    return @"icon_tabbar_user_n";
}

- (CGRect)tableViewFrame
{
    return kContentWithTabBarFrame;
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __unsafe_unretained MyViewController *blockSelf = self;
    self.tableView.tableHeaderView = TABLE_VIEW_HEADERVIEW(20.1f);
    NSArray *titleIndexArray = @[@"个人信息",@"查看过的课程",@"联系过的课程",@"修改帐户密码"];
    NSArray *imageIndexArray = @[@"icon_user_info",@"icon_user_order",@"icon_user_paid",@"icon_login_password"];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"SETTING_TABLEVIEW_CELL_IDENTIFIER";
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (0 == indexPath.section) {
            cell.topLabel.text = [titleIndexArray objectAtIndex:0];
            cell.leftImageView.image = [UIImage imageNamed:[imageIndexArray objectAtIndex:0]];
        } else if (1 == indexPath.section) {
            cell.topLabel.text = [titleIndexArray objectAtIndex:indexPath.row + 1];
            cell.leftImageView.image = [UIImage imageNamed:[imageIndexArray objectAtIndex:indexPath.row + 1]];

        } else  {
            cell.topLabel.text = [titleIndexArray objectAtIndex:3];
            cell.leftImageView.image = [UIImage imageNamed:[imageIndexArray objectAtIndex:3]];
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (eSectionIndex01 == section) ? 2 : 1;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView) {
        return (NSInteger)3;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.sectionFooterHeightBlock = ^(UITableView *tableView, NSInteger section)
    {
        return 20.0f;
    };
    
    self.tableView.sectionFooterBlock = ^( UITableView *tableView, NSInteger section)
    {
        UIView *footerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)]autorelease];
        return footerView;
    };
    
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (0 == indexPath.section) {
            LoginViewController *controller = [[[LoginViewController alloc] init] autorelease];
            [controller setHidesBottomBarWhenPushed:YES];
            [controller setTitleContent:[titleIndexArray objectAtIndex:0]];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        } else if (1 == indexPath.section) {
            if (0 == indexPath.row) {
                DidCheckClassesViewController *controller = [[[DidCheckClassesViewController alloc] init] autorelease];
                [controller setTitleContent:[titleIndexArray objectAtIndex:indexPath.row + 1]];
                [controller setHidesBottomBarWhenPushed:YES];
                [blockSelf.navigationController pushViewController:controller animated:YES];
            } else {
                DidContactClassesViewController *controller = [[[DidContactClassesViewController alloc] init] autorelease];
                [controller setTitleContent:[titleIndexArray objectAtIndex:indexPath.row + 1]];
                [controller setHidesBottomBarWhenPushed:YES];
                [blockSelf.navigationController pushViewController:controller animated:YES];
            }
            
//            OrdersViewController *controller = [[[OrdersViewController alloc] init] autorelease];
//            CheckClassViewController *controller = [[[CheckClassViewController alloc] init] autorelease];
//            controller.isFinished = (1 == indexPath.row);
//            [controller setTitleContent:[titleIndexArray objectAtIndex:indexPath.row + 1]];
//            [controller setHidesBottomBarWhenPushed:YES];
//            [blockSelf.navigationController pushViewController:controller animated:YES];
            
        } else  {
            ModifyPWDViewController *controller = [[[ModifyPWDViewController alloc] init] autorelease];
            [controller setHidesBottomBarWhenPushed:YES];
            [controller setTitleContent:[titleIndexArray objectAtIndex:3]];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
    };
    
    [self.view addSubview: self.tableView];
    
}
@end
