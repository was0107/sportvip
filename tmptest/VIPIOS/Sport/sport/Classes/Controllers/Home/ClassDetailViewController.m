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
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "PaggingRequest.h"
#import "PaggingResponse.h"
#import "TeacherViewController.h"
#import "SingleMapViewController.h"

@interface ClassDetailViewController ()
@property (nonatomic, retain) ClassDetailResponse *response;
@property (nonatomic, retain) NSMutableArray *titleArray1,*titleArray2;
@end

@implementation ClassDetailViewController

- (void) dealloc
{
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_titleArray1);
    TT_RELEASE_SAFELY(_titleArray2);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"课程详情";
    self.trackViewId = @"课程详情页面";
    [self.tableView removeFromSuperview];
    [self sendRequestToServer];
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
    self.telArray = self.response.phones;
    if ([[DataManager sharedInstance].serviceTel length] > 0) {
        [self.telArray addObject:[TelItem hotItem:[DataManager sharedInstance].serviceTel]];
    }
    [self.poplistview.listView reloadData];
    [self.poplistview show];
}

- (void) configTableView
{
    __block ClassDetailViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];
    NSArray *imageArray = [NSArray arrayWithObjects:@"map",@"cell_map",@"cell_teacher",@"cell_time",@"age",@"special",nil];
    
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (4 == indexPath.section) {
            static NSString *identifier1 = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER01";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (!cell){
                cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = kClearColor;
                cell.topLabel.frame = CGRectMake(30, 2, 285, 20);
                cell.topLabel.font = HTFONTSIZE(kFontSize16);
                cell.topLabel.numberOfLines = 0;
                [cell.contentView addSubview:cell.topLabel];
            }
            NSString *title = [_titleArray1 objectAtIndex:indexPath.row];
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(285, 2000)];
            [cell.topLabel setFrameHeight:size.height+10];
            cell.topLabel.text = [_titleArray1 objectAtIndex:indexPath.row];
            
            return (UITableViewCell *)cell;
        } else if (5 == indexPath.section) {
            static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER25";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                cell.topLabel.textColor = kBlackColor;
//                cell.backgroundColor = kClearColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.topLabel.frame = CGRectMake(30, 4, 280, 120);
//                cell.topLabel.layer.borderColor = [kTipsTitleColor CGColor];
//                cell.topLabel.layer.borderWidth = 1.0f;
                cell.topLabel.numberOfLines = 0;
//                cell.topLabel.layer.cornerRadius = 3.0f;
                [cell.contentView addSubview:cell.topLabel];
            }
            NSString *title = blockSelf.response.advantage;
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 2000)];
            [cell.topLabel setFrameHeight:size.height];
            cell.topLabel.text = title;
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
            
            cell.topLabelEx.font = HTFONTSIZE(kFontSize16);
            cell.subRightEx.font = HTFONTSIZE(kFontSize16);
            cell.subRightEx.textColor = [UIColor getColor:KCustomGreenColor];
            cell.subRightEx.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:cell.subRightEx];
        }

        cell.selectionStyle = (2 == indexPath.section || 1 == indexPath.section) ? UITableViewCellSelectionStyleGray :  UITableViewCellSelectionStyleNone;
        cell.accessoryType = (2 == indexPath.section || 1 == indexPath.section) ? UITableViewCellAccessoryDisclosureIndicator :  UITableViewCellAccessoryNone;

        cell.topLabelEx.frame = CGRectMake(10, 8, 300, 24);
        NSString *title = [_titleArray2 objectAtIndex:indexPath.section];
        cell.topLabelEx.text = title;
        if (0 == indexPath.section) {
            cell.topLabelEx.font = HTFONTSIZE(kFontSize16);
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 2000)];
            [[cell.topLabelEx setFrameHeight:size.height + 4] setFrameWidth:size.width + 45];
//            cell.topLabelEx.imageSize = CGSizeMake(18, 20);
            [cell.topLabelEx setImages:[NSArray arrayWithObjects:@"hot",@"xin",nil] origitation:1];
            cell.subRightEx.text = blockSelf.response.price;
            CGFloat width = [cell.subRightEx.text sizeWithFont:HTFONTSIZE(kFontSize16)].width ;
            [cell.subRightEx setFrame:CGRectMake(310 - (width + 22),8, (width + 22), 24)];
//            [cell.subRightEx setImages:[NSArray arrayWithObjects:@"icon",nil] origitation:0];

        } else {
            cell.topLabelEx.font = HTFONTSIZE(kFontSize16);
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 2000)];
            [cell.topLabelEx setFrameHeight:size.height+6];
            [cell.topLabelEx setImage:imageArray[indexPath.section] origitation:0];
            [cell.subRightEx setFrame:CGRectZero];
        }
        return (UITableViewCell *)cell;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (4 == indexPath.section) {
            NSString *title = [_titleArray1 objectAtIndex:indexPath.row];
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(285, 2000)];
            return size.height + 10;
        }
        else  if (5 == indexPath.section) {
            NSString *title = blockSelf.response.advantage;
            CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(285, 2000)];
            return size.height +10;
        }
        NSString *string = [_titleArray2 objectAtIndex:indexPath.section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        return size.height + ((size.height < 24 ) ? 20 : 20);
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        if (4 == section) {
            return 2;
        }
        return 1;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        NSString *string = [_titleArray2 objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        return size.height + 20;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (1 == indexPath.section) {
            SingleMapViewController *controller = [[[SingleMapViewController alloc] init] autorelease];
            CLLocationCoordinate2D center;
            center.longitude = blockSelf.response.longtitude;
            center.latitude = blockSelf.response.lantitude;
            controller.center = center;
            controller.gymnasiumName = blockSelf.response.gymnasiumName;
            controller.address = blockSelf.response.address;
            [controller showPosition];
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
       else if (2 == indexPath.section) {
            TeacherViewController *controller = [[[TeacherViewController alloc] init] autorelease];
            CoacheItem *coachItem = [[[CoacheItem alloc] init] autorelease];
            coachItem.itemId = blockSelf.response.coachId;
            coachItem.name = blockSelf.response.coachName;
            controller.item = coachItem;
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return 6;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        if (section < 4) {
            return 0.0f;
        }
        NSString *string = [_titleArray2 objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        return size.height + 20;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        
        if (section < 4) {
            UIView *nilView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)] autorelease];
            return nilView;
        }
        NSArray *imageArray = [NSArray arrayWithObjects:@"map",@"cell_map",@"cell_teacher",@"cell_time",@"age",@"special",nil];

        NSString *string = [_titleArray2 objectAtIndex:section];
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
            [imageLabelEx setFrameWidth:size.width + 50];
            [imageLabelEx setImages:[NSArray arrayWithObjects:@"hot",@"xin",nil] origitation:1];
        } else {
            [imageLabelEx setImage:imageArray[section] origitation:0];
        }
        [imageLabelEx shiftPositionY:1];
        return (UIView *)view;
    };
}

- (void) dealWithData
{
    self.titleArray1 = [NSMutableArray arrayWithObjects:self.response.age,self.response.description,nil];
    self.titleArray2 = [NSMutableArray arrayWithObjects:self.response.name,\
                        [NSString stringWithFormat:@"上课地点:\r\n%@",self.response.address],\
                        [NSString stringWithFormat:@"教练:%@",self.response.coachName],
                        [NSString stringWithFormat:@"上课时间:%@",self.response.schoolTime],
                        @"适合人群",\
                        @"课程特色",nil];

    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    [self addClassesToServer];
}

- (void) sendRequestToServer
{
    __block ClassDetailViewController *blockSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succeed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        blockSelf.response = [[[ClassDetailResponse alloc] initWithJsonString:content] autorelease];
        [blockSelf dealWithData];
    };
    
    idBlock failedBlock = ^(id content) {
        DEBUGLOG(@"failed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    ClassDetailRequest *request = [[[ClassDetailRequest alloc] init] autorelease];
    request.courseId = self.courseId;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}


- (void) addClassesToServer
{
    if ([self currentUserId].length == 0) {
        return;
    }
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succeed content %@", content);
    };
    
    idBlock failedBlock = ^(id content) {
        DEBUGLOG(@"failed content %@", content);
    };
    AddClassCoachRequest *addRequest = [[[AddClassCoachRequest alloc] init] autorelease];
    addRequest.userId = [self currentUserId];
    addRequest.courseId = self.courseId;
    [WASBaseServiceFace serviceWithMethod:[addRequest URLString] body:[addRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:failedBlock];
}
@end
