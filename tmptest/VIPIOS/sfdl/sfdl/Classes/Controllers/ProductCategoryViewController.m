//
//  ProductCategoryViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductCategoryViewController.h"
#import "ProductListViewController.h"

@interface ProductCategoryViewController ()

@end

@implementation ProductCategoryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"Product List";

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) reduceMemory
{
    [super reduceMemory];
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (void) configTableView
{
    __block ProductCategoryViewController *blockSelf = self;
    NSArray *titleIndexArray = @[@"Open Type Generator Sets",@"Slient Type Generator Sets",@"Trailer Type Generator Sets",@"Mobile Light Tower", \
                                 @"High-volt Generator Sets",@"Alternator",@"Options"];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(15, 10, 290, 24);
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font = HTFONTSIZE(kFontSize15);
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
        ProductListViewController *controller = [[[ProductListViewController alloc] init] autorelease];
        controller.secondTitleLabel.text = titleIndexArray[indexPath.row];
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];

    };
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    //    [self.tableView doSendRequest:YES];
}


@end
