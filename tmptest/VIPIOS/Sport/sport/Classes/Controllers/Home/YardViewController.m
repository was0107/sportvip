//
//  YardViewController.m
//  sport
//
//  Created by allen.wang on 6/9/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "YardViewController.h"
#import "XLCycleScrollView.h"
#import "UIImageLabelEx.h"
#import "CustomImageTitleButton.h"
#import "CreateObject.h"
#import "ClassDetailViewController.h"

@interface YardViewController()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView *cycleView;

@end
@implementation YardViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"上海龙翔体育馆";
}

- (XLCycleScrollView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
        _cycleView.delegate = self;
        _cycleView.dataSource = self;
        [_cycleView reloadData];
    }
    return _cycleView;
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 0, 320.0, kContentBoundsHeight-0);
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
    [CreateObject addTargetEfection:button];
    button.frame = CGRectMake(20, 10, 280, 44);
    [view addSubview:button];
    return view;
}

- (void) configTableView
{
    __block YardViewController *blockSelf = self;
    self.tableView.tableHeaderView = self.cycleView;
    self.tableView.tableFooterView = [self footerView];
    NSArray *titleArray = [NSArray arrayWithObjects:@"上海闵行区什么路(飞来路对面)276号",@"支持运动项目",@"热门课程",\
                           @"驻点教练",@"上海体育馆通称万人体育馆,在徐汇区中南二路漕溪北路。1975年建成。占地10.6万平方米。建筑面积四点平方米。正门内大道两旁", nil];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
            if (0 == indexPath.section) {
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER0";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                }
                return (UITableViewCell *)cell;
            }
            else  if (1 == indexPath.section) {
                
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER1";
                BaseSportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseSportTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
//                    cell.backgroundColor = kClearColor;
//                    cell.contentView.backgroundColor = kClearColor;
                }
                [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                for (int i = 0 ; i < 8; i++) {
                    UIImageLabelEx *labelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(10 + 44 *i, 4, 44, 20)] autorelease];
                    labelEx.backgroundColor = kClearColor;
                    labelEx.textColor = kDarkTextColor;
                    labelEx.highlightedTextColor = kBlackColor;
                    labelEx.font = HTFONTSIZE(kFontSize13);
                    labelEx.textAlignment = UITextAlignmentCenter;
                    labelEx.text = @"篮球球";
                    [cell.contentView addSubview:labelEx];
                    [labelEx setImage:@"icon" origitation:2];
                }
                return (UITableViewCell *)cell;
            }
            else if (2 == indexPath.section) {
             
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER2";
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    cell.topLabel.textColor = kBlackColor;
//                    cell.backgroundColor = kClearColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.topLabel.frame = CGRectMake(10, 10, 200, 24);
                    cell.subLabel.frame = CGRectMake(210, 10, 100, 24);
                    cell.subLabel.textAlignment = UITextAlignmentRight;
                    [cell.contentView addSubview:cell.topLabel];
                    [cell.contentView addSubview:cell.subLabel];
                }
//                [cell setCellsCount:3 at:indexPath];
                cell.topLabel.text = @"篮球基础班";
                cell.subLabel.text = @"王学新";
                
                return (UITableViewCell *)cell;

            }
            else  if (3 == indexPath.section) {
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER3";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                }
                NSArray *titleIndexArray = @[@"Solution",@"Genuine Parts",@"Download",@"Download"];
                NSArray *imageIndexArray = @[@"home9",@"home10",@"home11",@"home12"];
                int flag =  (iPhone5) ? 120 : 110;
                int tag = 1000;
                for (int i = 0 ; i < 4; i++) {
                    CustomImageTitleButton *button = [[[CustomImageTitleButton alloc] initWithFrame:CGRectMake(4 + 79 * i, 4, 75, 90)] autorelease];
                    button.topButton.tag =  tag+i;
                    button.bottomTitleLabel.font = HTFONTSIZE(kFontSize10);
                    [button.bottomTitleLabel setShiftVertical:-4];
                    [button.topButton addTarget:blockSelf action:@selector(didTaped:) forControlEvents:UIControlEventTouchUpInside];
                    [button setText:titleIndexArray[i] image:@"icon"];
                    [cell.contentView addSubview:button];
                }

                
                return (UITableViewCell *)cell;


            }
            else {
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER4";
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    [cell.contentView addSubview:cell.topLabel];
                    [cell.contentView addSubview:cell.subLabel];
                }
                cell.topLabel.text = @"篮球基础班";
                cell.subLabel.text = @"王学新";
                return (UITableViewCell *)cell;
            }
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == indexPath.section) {
            return 0.0f;
        }
        else  if (1 == indexPath.section) {
            return 50.0f;
        }
        else if (2 == indexPath.section) {
            return 44.0f;
        }
        else  if (3 == indexPath.section) {
            return 98.0f;
        }
        else  if (4 == indexPath.section) {
            return 44.0f;
        }
        return  44.0f;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        if (0 == section) {
            return 0;
        }
        else  if (1 == section) {
            return 1;
        }
        else if (2 == section) {
            return 3;
        }
        else  if (3 == section) {
            return 1;
        }

        return 0;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 20000)];
        return size.height + 20;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return 5;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 20000)];
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 20)] autorelease];
        view.backgroundColor = kWhiteColor;
        UIImageLabelEx *imageLabelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(10, 6, 300, size.height+8)] autorelease];
        imageLabelEx.numberOfLines = 0;
        imageLabelEx.font = HTFONTSIZE(kFontSize16);
        [view addSubview:imageLabelEx];
        imageLabelEx.text = string;//@"上海闵行区什么路";
        [imageLabelEx setImage:@"icon" origitation:0];
        [imageLabelEx shiftPositionY:1];
        if (0 == section) {
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(0, view.bounds.size.height-0.5f, 320, 0.5f)] autorelease];
            lineView.backgroundColor = kLightGrayColor;
            [view addSubview:lineView];
        }
        return (UIView *)view;
    };
    
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (2 == indexPath.section)
        {
            ClassDetailViewController *controller = [[[ClassDetailViewController alloc] init] autorelease];
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
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

- (IBAction)didTaped:(id)sender
{
    
}


#pragma mark - XLCycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return 3;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    imageView.image = [UIImage imageNamed:@"icon"];
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    DEBUGLOG(@"selected index:%d", index);
}

@end
