//
//  ClassDetailViewController.m
//  sport
//
//  Created by allen.wang on 6/13/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "TeacherTableViewCell.h"
#import "UIImageLabelEx.h"
#import "CustomImageTitleButton.h"
#import "CreateObject.h"

@interface ClassDetailViewController ()

@end

@implementation ClassDetailViewController

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
    self.title = @"课程详情";
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

- (UIView *) footerView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
    view.backgroundColor = kClearColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"联系教练" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showTeachers:) forControlEvents:UIControlEventTouchUpInside];
    [CreateObject addTargetEfection:button];
    button.frame = CGRectMake(20, 10, 280, 44);
    [view addSubview:button];
    return view;
}

- (IBAction)showTeachers:(id)sender
{
    [self.poplistview show];
}




- (void) configTableView
{
    __block ClassDetailViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];
    NSArray *titleArray1 = [NSArray arrayWithObjects:@"12-17岁青少年",\
                           @"操作式教学课程特色，通过丰富、好玩的教具、搭配故事的情景，吸引孩子喜欢网球，培养孩子的兴趣爱好，同时通过网球训练，培养孩子的交际能力，身体素质和自信心，为孩子的未来打下坚实的基础",nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"网球基础班",\
                           @"上课地点：上海闵行区飞来峰体育馆，凤起路230号（大铁棍子医院斜对面）",\
                           @"教练：王学新教练详情",\
                           @"上课时间：每周六 14：00-17：00",\
                           @"适合年龄",\
                           @"课程特色",nil];
    
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (4 == indexPath.section) {
            static NSString *identifier1 = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER01";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (!cell){
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = kClearColor;
                cell.topLabel.frame = CGRectMake(10, 2, 300, 20);
                cell.topLabel.font = HTFONTSIZE(kFontSize14);
                cell.topLabel.numberOfLines = 0;
                [cell.contentView addSubview:cell.topLabel];
            }
            NSString *title = [titleArray1 objectAtIndex:indexPath.row];
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(300, 2000)];
            [cell.topLabel setFrameHeight:size.height+10];
            cell.topLabel.text = [titleArray1 objectAtIndex:indexPath.row];
            
            return (UITableViewCell *)cell;
        } else if (5 == indexPath.section) {
            static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER25";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                cell.topLabel.textColor = kBlackColor;
//                cell.backgroundColor = kClearColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.topLabel.frame = CGRectMake(10, 10, 300, 120);
                cell.topLabel.layer.borderColor = [kTipsTitleColor CGColor];
                cell.topLabel.layer.borderWidth = 1.0f;
                cell.topLabel.layer.cornerRadius = 3.0f;
                [cell.contentView addSubview:cell.topLabel];
            }
            cell.topLabel.text = @"网球基础班";
            return (UITableViewCell *)cell;
        }
        
        static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER15";
        BaseSportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[BaseSportTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
            cell.topLabelEx.textColor = kBlackColor;
//            cell.backgroundColor = kClearColor;
            cell.topLabelEx.numberOfLines = 0;
            [cell.contentView addSubview:cell.topLabelEx];
            
            cell.topLabelEx.font = HTFONTSIZE(kFontSize18);
            cell.subRightEx.font = HTFONTSIZE(kFontSize18);
            cell.subRightEx.textColor = [UIColor getColor:KCustomGreenColor];
            cell.subRightEx.textAlignment = UITextAlignmentRight;
            [cell.contentView addSubview:cell.subRightEx];
        }

        cell.selectionStyle = (2 == indexPath.section) ? UITableViewCellSelectionStyleGray :  UITableViewCellSelectionStyleNone;

        cell.topLabelEx.frame = CGRectMake(10, 8, 300, 24);
        NSString *title = [titleArray objectAtIndex:indexPath.section];
        cell.topLabelEx.text = title;
        if (0 == indexPath.section) {
            cell.topLabelEx.font = HTFONTSIZE(kFontSize16);
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 2000)];
            [[cell.topLabelEx setFrameHeight:size.height + 4] setFrameWidth:size.width + 35];
            [cell.topLabelEx setImages:[NSArray arrayWithObjects:@"icon",@"icon",nil] origitation:1];
            cell.subRightEx.text = @"￥2290";
            CGFloat width = [cell.subRightEx.text sizeWithFont:HTFONTSIZE(kFontSize17)].width ;
            [cell.subRightEx setFrame:CGRectMake(310 - (width + 22),8, (width + 22), 24)];
            [cell.subRightEx setImages:[NSArray arrayWithObjects:@"icon",nil] origitation:0];

        } else {
            cell.topLabelEx.font = HTFONTSIZE(kFontSize16);
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 2000)];
            [cell.topLabelEx setFrameHeight:size.height+6];
            [cell.topLabelEx setImage:@"icon" origitation:0];
            [cell.subRightEx setFrame:CGRectZero];
        }
        return (UITableViewCell *)cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (4 == indexPath.section) {
            NSString *title = [titleArray1 objectAtIndex:indexPath.row];
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(300, 2000)];
            return size.height + 16;
        }
        else  if (5 == indexPath.section) {
            return 140.0f;
        }
        NSString *string = [titleArray objectAtIndex:indexPath.section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 20000)];
        return size.height + 20;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        if (4 == section) {
            return 2;
        }
        return 1;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(300, 20000)];
        return size.height + 20;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return 6;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        if (section < 4) {
            return 0.0f;
        }
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 20000)];
        return size.height + 20;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        
        if (section < 4) {
            UIView *nilView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)] autorelease];
            return nilView;
        }
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 20000)];
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 20)] autorelease];
        view.backgroundColor = kWhiteColor;
        UIImageLabelEx *imageLabelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(10, 6, 300, size.height+8)] autorelease];
        imageLabelEx.numberOfLines = 0;
        imageLabelEx.font = HTFONTSIZE(kFontSize16);
        [view addSubview:imageLabelEx];
        imageLabelEx.text = string;//@"上海闵行区什么路";
        if (0 == section) {
            imageLabelEx.font = HTFONTSIZE(kFontSize16);
            CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16)];
            [imageLabelEx setFrameWidth:size.width + 35];
            [imageLabelEx setImages:[NSArray arrayWithObjects:@"icon",@"icon",nil] origitation:1];
        } else {
            [imageLabelEx setImage:@"icon" origitation:0];
        }
        [imageLabelEx shiftPositionY:1];
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
