//
//  SSettingViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "SSettingViewController.h"

@interface SSettingViewController ()

@end

@implementation SSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.secondTitleLabel.text = @"Setting";
    [self setTitleContent:@"SETTING"];

    // Do any additional setup after loading the view.
}

- (void) reduceMemory
{
    [super reduceMemory];
}

- (void) configTableView
{
    __unsafe_unretained SSettingViewController *blockSelf = self;
    NSArray *titleIndexArray = @[@"About us",@"Contact us"];
    NSArray *controllersArray = @[@"AboutUsViewController",@"ContactUsViewController"];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(15, 10, 290, 24);
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
        }
        cell.topLabel.text = titleIndexArray[indexPath.row];
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[titleIndexArray count];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        Class class = NSClassFromString(controllersArray[indexPath.row]);
        UIViewController *controller = [[[class alloc] init] autorelease];
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
        
    };
      [self.view addSubview:self.tableView];
}

@end
