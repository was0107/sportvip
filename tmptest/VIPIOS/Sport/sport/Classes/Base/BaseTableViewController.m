//
//  BaseTableViewController.m
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController()<UIPopoverListViewDataSource, UIPopoverListViewDelegate>

@end

@implementation BaseTableViewController
@synthesize tableView = _tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IOS_7_OR_GREATER) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self configEmptyTipsView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    [self configTableView];
    [self.view addSubview:self.tableView];
    if (IS_IOS_7_OR_GREATER){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }


}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_poplistview);
    [super reduceMemory];
}

- (int) tableViewType
{
    return eTypeRefreshHeader | eTypeFooter;
}

- (CGRect) tableViewFrame
{
    return kContentFrame;
}

- (int) tableviewStyle
{
    if (IS_IOS_7_OR_GREATER)
	{
	return  UITableViewStyleGrouped;
	}
    else
	{
	return UITableViewStylePlain;
	}
}

- (BaseTableView *) tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:[self tableViewFrame] style:[self tableviewStyle] type:[self tableViewType] delegate:nil];
        _tableView.rowHeight = 44.0f;
        _tableView.parentView = self.view;
        _tableView.backgroundColor = kClearColor;
        _tableView.backgroundView = nil;
        _tableView.tableFooterView = nil;
        _tableView.tableHeaderView = nil;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (void) configTableView
{
    DEBUGLOG(@"configTableView");
    //    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
    //        };
    //
    //    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
    //    };
    //
    //    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
    //    };
    //
    //    self.tableView.cellEditBlock = ^(UITableView *tableView, NSIndexPath *indexPath)
    //    {
    //    };
    //
    //    self.tableView.cellEditActionBlock = ^(UITableView *tableView, NSInteger editingStyle, NSIndexPath *indexPath){
    //
    //    };
    //
    //    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
    //
    //    };
    //
    //    self.tableView.refreshBlock = ^(id content) {
    //    };
    //
    //    self.tableView.loadMoreBlock = ^(id content) {
    //
    //    };
}

-(void) configEmptyTipsView
{

}

-(void)refreshTableView
{
    self.tableView.refreshBlock(nil);
}


#pragma mark - UIPopoverListViewDataSource


- (UIPopoverListView *) poplistview
{
    if (!_poplistview) {
        {
            CGFloat xWidth = self.view.bounds.size.width - 20.0f;
            CGFloat yHeight = 272.0f;
            CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
            _poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
            _poplistview.delegate = self;
            _poplistview.datasource = self;
            _poplistview.listView.scrollEnabled = TRUE;
            [_poplistview setTitle:@"联系教练"];
            [_poplistview.listView setTableFooterView:[self footerTipView]];
        }
    }
    return _poplistview;
}
- (UIView *) footerTipView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)] autorelease];
    view.backgroundColor = kClearColor;
    UILabel *tipLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 280, 40)] autorelease];
    tipLabel.text = @"*注：如果您联系不上教练，可以拨打我们的客服电话，我们会帮您安排。";
    tipLabel.font = HTFONTSIZE(kFontSize15);
    tipLabel.backgroundColor = kClearColor;
    tipLabel.textColor = kGrayColor;
    tipLabel.numberOfLines = 0;
    [view addSubview:tipLabel];
    return view;
}

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
    BaseNewTableViewCell *cell = [popoverListView.listView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.topLabel.frame = CGRectMake(60, 10, 100, 30);
        cell.subLabel.frame = CGRectMake(150, 10, 140, 30);
        cell.subLabel.textAlignment = UITextAlignmentRight;
        cell.topLabel.font = cell.subLabel.font = HTFONTSIZE(kFontSize18);
        cell.leftImageView.frame = CGRectMake(8, 3, 44, 44);
        cell.leftImageView.layer.borderColor = [kWhiteColor CGColor];
        cell.leftImageView.layer.cornerRadius = 22.0f;
        cell.leftImageView.layer.borderWidth = 2.0f;
        [cell.contentView addSubview:cell.topLabel];
        [cell.contentView addSubview:cell.subLabel];
        [cell.contentView addSubview:cell.leftImageView];
    }
    TelItem *telItem = [self.telArray objectAtIndex:indexPath.row];
    cell.topLabel.text = telItem.name;
    cell.subLabel.text = telItem.tel;
    if ([telItem.avatar hasPrefix:@"http"]) {
        [cell.leftImageView setImageWithURL:[NSURL URLWithString:telItem.avatar]
                           placeholderImage:[UIImage imageNamed:kImageDefault]
                                    success:^(UIImage *image){
                                        UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 80)];
                                        cell.leftImageView.image = image1;
                                    }
                                    failure:^(NSError *error){
                                        cell.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                    }];
    } else {
        cell.leftImageView.image = [UIImage imageNamed:telItem.avatar];
    }

    return (UITableViewCell *)cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [self.telArray count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13600000000"]];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
@end
