//
//  TeacherViewController.m
//  sport
//
//  Created by allen.wang on 6/9/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "TeacherViewController.h"
#import "TeacherTableViewCell.h"
#import "UIImageLabelEx.h"
#import "CustomImageTitleButton.h"
#import "CreateObject.h"

@implementation TeacherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose
}

- (int) tableViewType
{
    return eTypeNone;
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight);
}

- (UIView *) footerView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)] autorelease];
    view.backgroundColor = kClearColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"联系教练" forState:UIControlStateNormal];
    [CreateObject addTargetEfection:button];
    button.frame = CGRectMake(20, 5.5, 280, 44);
    [view addSubview:button];
    return view;
}


- (void) configTableView
{
    __block TeacherViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];
    NSArray *titleArray = [NSArray arrayWithObjects:@"",@"个人简介",@"精练精选课程",@"教学点", nil];

    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == indexPath.section) {
            static NSString *identifier1 = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER0";
            TeacherTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (!cell1){
                cell1 = [[TeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                cell1.backgroundColor = kClearColor;
            }
            [cell1 configTeacherDetailHeader];
            return (UITableViewCell *)cell1;
        }
        else if (1 == indexPath.section) {
            
            if (0 == indexPath.row) {
                static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER10";
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    cell.topLabel.textColor = kBlackColor;
                    cell.backgroundColor = kClearColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.topLabel.frame = CGRectMake(10, 5, 300, 44);
                    cell.subLabel.textAlignment = UITextAlignmentRight;
                    cell.topLabel.numberOfLines = 0;
                    [cell.contentView addSubview:cell.topLabel];
                }
                cell.topLabel.text = @"从事青少年网球教育数十载，学生多次获得国内外网球比赛冠亚军";
                return (UITableViewCell *)cell;
            }
            
            static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER11";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                cell.topLabel.textColor = kBlackColor;
                cell.backgroundColor = kClearColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.topLabel.frame = CGRectMake(10, 10, 80, 24);
                cell.subLabel.frame = CGRectMake(100, 10, 210, 24);
                cell.subLabel.textAlignment = UITextAlignmentRight;
                [cell.contentView addSubview:cell.topLabel];
                [cell.contentView addSubview:cell.subLabel];
            }
            [cell setCellsCount:3 at:indexPath];
            cell.topLabel.text = @"2013";
            cell.subLabel.text = @"荣获优秀教师的称号";
            return (UITableViewCell *)cell;

        }
        else if (2 == indexPath.section) {
            
            static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER11";
            BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                cell.topLabel.textColor = kBlackColor;
                cell.backgroundColor = kClearColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.topLabel.frame = CGRectMake(10, 10, 90, 24);
                cell.rightLabel.frame = CGRectMake(100, 10, 150, 24);
                cell.subRightLabel.frame = CGRectMake(250, 10, 60, 24);
                cell.topLabel.textColor = kTableViewColor;
                cell.rightLabel.textAlignment = UITextAlignmentRight;
                cell.subRightLabel.textAlignment = UITextAlignmentRight;
                [cell.contentView addSubview:cell.topLabel];
                [cell.contentView addSubview:cell.rightLabel];
                [cell.contentView addSubview:cell.subRightLabel];
                cell.subRightLabel.font = cell.topLabel.font;
            }
            cell.topLabel.text = @"网球基础班";
            cell.rightLabel.text = @"周六14：00-17：00";
            cell.subRightLabel.text = @"￥168";
            return (UITableViewCell *)cell;
        }
        static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        return (UITableViewCell *)cell;
    };

    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == indexPath.section) {
            return 110.0f;
        }
        else  if (1 == indexPath.section) {
            if (0 == indexPath.row) {
                return 60.0f;
            }
            return 44.0f;
        }
        else if (2 == indexPath.section) {
            return 44.0f;
        }
        else if (3 == indexPath.section) {
            return 140.0f;
        }
        return  44.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        if (0 == section) {
            return 1;
        }
        else  if (1 == section) {
            return 4;
        }
        else if (2 == section) {
            return 4;
        }
        else  if (3 == section) {
            return 1;
        }
        return 0;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return 4;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        if (0 == section) {
            return 0.0f;
        }
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(300, 20000)];
        return size.height + 10;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(300, 20000)];
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 5)] autorelease];
        
        UIImageLabelEx *imageLabelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(10, 1, 300, size.height+8)] autorelease];
        imageLabelEx.numberOfLines = 0;
        imageLabelEx.font = HTFONTSIZE(kFontSize14);
        [view addSubview:imageLabelEx];
        imageLabelEx.text = string;//@"上海闵行区什么路";
        [imageLabelEx setImage:@"icon" origitation:0];
        return (UIView *)view;
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
