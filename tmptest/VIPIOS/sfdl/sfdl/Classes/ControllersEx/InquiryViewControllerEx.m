//
//  InquiryViewControllerEx.m
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "InquiryViewControllerEx.h"
#import "NewsTableViewCellEx.h"

@interface InquiryViewControllerEx ()

@end

@implementation InquiryViewControllerEx


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"INQUIRY"];
    // Do any additional setup after loading the view.
}

- (void) configTableView
{
    __unsafe_unretained typeof(self) blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    NSArray *titleIndexArray = @[@"Change the password", @"Inquiry", @"Browsing history"];
    NSArray *controllerIndexArray = @[@"ChangePasswordViewController",@"InquiryViewControllerEx",@"BrowsingHistoryViewController"];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
        NewsTableViewCellEx *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[NewsTableViewCellEx alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            [cell configWithType:0];
        }
        
        [cell showLeft:(indexPath.row %2 != 0)];
        [cell setContent:nil];
        return cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  50.0f;
    };
    
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
