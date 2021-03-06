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
#import "PaggingRequest.h"
#import "PaggingResponse.h"
#import "TeacherViewController.h"
#import "SingleMapViewController.h"

@interface YardViewController()<XLCycleScrollViewDelegate, XLCycleScrollViewDatasource>
@property (nonatomic, retain) XLCycleScrollView *cycleView;
@property (nonatomic, retain) GymnasiumDetailResponse *response;
@property (nonatomic, retain) GymnasiumDetailRequest *request;
@property (nonatomic, retain) NSMutableArray *titleArray;

@end
@implementation YardViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_cycleView);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_titleArray);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackViewId = @"场馆详情页面";
    self.title = self.item.name;
    [self.tableView removeFromSuperview];
    [self sendRequestToServer];
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
    [button addTarget:self action:@selector(showTeachers:) forControlEvents:UIControlEventTouchUpInside];
    [CreateObject addTargetEfection:button];
    button.frame = CGRectMake(20, 10, 280, 44);
    [view addSubview:button];
    return view;
}

- (IBAction)showTeachers:(id)sender
{
    self.telArray = [NSMutableArray arrayWithArray:self.response.phones];
    if ([[DataManager sharedInstance].serviceTels count] > 0) {
        [self.telArray addObjectsFromArray:[DataManager sharedInstance].serviceTels];
    }
    [self.poplistview.listView reloadData];
    [self.poplistview show];
}


- (void) configTableView
{
    __block YardViewController *blockSelf = self;
    self.tableView.tableHeaderView = self.cycleView;
    self.tableView.tableFooterView = [self footerView];
    
   
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
            if (0 == indexPath.section) {
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER0";
                BaseSportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseSportTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    cell.topLabelEx.textColor = kBlackColor;
                    cell.topLabelEx.numberOfLines = 0;
                    [cell.contentView addSubview:cell.topLabelEx];
                    cell.topLabelEx.font = HTFONTSIZE(kFontSize16);
                }
                
                cell.selectionStyle = (0 == indexPath.section) ? UITableViewCellSelectionStyleGray :  UITableViewCellSelectionStyleNone;
                cell.accessoryType = (0 == indexPath.section) ? UITableViewCellAccessoryDisclosureIndicator :  UITableViewCellAccessoryNone;
                cell.topLabelEx.frame = CGRectMake(8, 8, 300, 24);
                NSString *title = [_titleArray objectAtIndex:indexPath.row];
                CGSize size = [title sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(300, 2000)];
                [[cell.topLabelEx setFrameHeight:size.height + 4] setFrameWidth:size.width + 45];
                cell.topLabelEx.text = title;
                [cell.topLabelEx setImage:@"map" origitation:0];
                return (UITableViewCell *)cell;
            }
            else  if (1 == indexPath.section) {
                
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER1";
                BaseSportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseSportTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
//                    cell.backgroundColor = kClearColor;
//                    cell.contentView.backgroundColor = kClearColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                int total =  MIN([blockSelf.response.events count], 6 * (indexPath.row + 1));
                [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                for (int i = 6 * (indexPath.row) ; i < total; i++) {
                    EventTagItem *tagItem = [blockSelf.response.events objectAtIndex:i];
                    UIImageLabelEx *labelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(15 + 50 * (i % 6), 4, 49, 20)] autorelease];
                    labelEx.backgroundColor = kClearColor;
                    labelEx.textColor = kDarkTextColor;
                    labelEx.highlightedTextColor = kBlackColor;
                    labelEx.font = HTFONTSIZE(kFontSize13);
                    labelEx.textAlignment = UITextAlignmentCenter;
                    labelEx.text = tagItem.name;
                    [cell.contentView addSubview:labelEx];
                    [labelEx setImage:tagItem.icon origitation:2];
                    if (labelEx.text.length > 2) {
                        [labelEx shiftPositionX:2];
                    } else {
                        [labelEx shiftPositionX:2];
                    }
                }
                return (UITableViewCell *)cell;
            }
            else if (2 == indexPath.section) {
             
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER2";
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    cell.topLabel.textColor = kBlackColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.topLabel.frame = CGRectMake(10, 10, 180, 24);
                    cell.subLabel.frame = CGRectMake(190, 10, 100, 24);
                    cell.subLabel.textAlignment = NSTextAlignmentRight;
                    [cell.contentView addSubview:cell.topLabel];
                    [cell.contentView addSubview:cell.subLabel];
                }
                CourseItem *courseItem = [[blockSelf.response courses] objectAtIndex:indexPath.row];
                cell.topLabel.text = courseItem.name;
                cell.subLabel.text = courseItem.coachName;
                
                return (UITableViewCell *)cell;

            }
            else  if (3 == indexPath.section) {
                static NSString *identifier = @"YARD_TABLEVIEW_CELL_IDENTIFIER3";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
//                NSArray *titleIndexArray = @[@"Solution",@"Genuine Parts",@"Download",@"Download"];
//                NSArray *imageIndexArray = @[@"home9",@"home10",@"home11",@"home12"];
//                int flag =  (iPhone5) ? 120 : 110;
                int tag = 1000;
                int total =  MIN([blockSelf.response.coaches count], 4 * (indexPath.row+1));
                [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                for (int i = 4 * (indexPath.row) ; i < total; i++) {
                    CoacheItem *item = [[blockSelf.response coaches] objectAtIndex:i];
                    CustomRoundImageTitle *button = [[[CustomRoundImageTitle alloc] initWithFrame:CGRectMake(4 + 79 * (i%4), 4, 75, 90)] autorelease];
                    button.tag =  tag+i;
                    button.bottomTitleLabel.font = HTFONTSIZE(kFontSize10);
                    [button.bottomTitleLabel setShiftVertical:-4];
                    [button addTarget:blockSelf action:@selector(didTaped:) forControlEvents:UIControlEventTouchUpInside];
                    [button setText:item.name image:item.avatar];
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
                return (UITableViewCell *)cell;
            }
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == indexPath.section) {
            NSString *string = [_titleArray objectAtIndex:indexPath.section];
            CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
            return size.height + 20;
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
            return 1;
        }
        else  if (1 == section) {
            return (NSInteger)([[blockSelf.response events] count] + 5)/ 6 ;
        }
        else if (2 == section) {
            return (NSInteger)[[blockSelf.response courses] count];
        }
        else  if (3 == section) {
            return (NSInteger)([[blockSelf.response coaches] count] + 3)/4;
        }

        return 0;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        if (section == 0) {
            return 0.0f;
        }
        NSString *string = [_titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        return size.height + 20;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return 5;
    };
    
    NSArray *imageArray = [NSArray arrayWithObjects:@"map",@"sport",@"course",@"coach",@"desc",nil];
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        if (0 == section) {
            return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,0)] autorelease];
        }
        NSString *string = [_titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 20)] autorelease];
        view.backgroundColor = kWhiteColor;
        UIImageLabelEx *imageLabelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(10, 6, 300, size.height+8)] autorelease];
        imageLabelEx.numberOfLines = 0;
        imageLabelEx.font = HTFONTSIZE(kFontSize16);
        [view addSubview:imageLabelEx];
        imageLabelEx.text = string;//@"上海闵行区什么路";
        [imageLabelEx setImage:[imageArray objectAtIndex:section] origitation:0];
        [[imageLabelEx shiftPositionY:1] shiftPositionX:-1];
        if (section == 4) {
            imageLabelEx.textColor = kTableViewColor;
        }
        return (UIView *)view;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (0 == indexPath.section) {
            if (blockSelf.response) {
                CLLocationCoordinate2D center;
                SingleMapViewController *controller = [[[SingleMapViewController alloc] init] autorelease];
                center.longitude = blockSelf.response.longtitude;
                center.latitude = blockSelf.response.lantitude;
                controller.center = center;
                controller.gymnasiumName = blockSelf.response.name;
                controller.address = blockSelf.response.address;
                [controller showPosition];
                [controller setHidesBottomBarWhenPushed:YES];
                [blockSelf.navigationController pushViewController:controller animated:YES];
            }
        }
        else if (2 == indexPath.section)
        {
            ClassDetailViewController *controller = [[[ClassDetailViewController alloc] init] autorelease];
            CourseItem *item = [[blockSelf.response courses] objectAtIndex:indexPath.row];
            controller.courseId = item.courseId;
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
    };
    
    self.tableView.refreshBlock = ^(id content) {
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    
}

- (void) goToMap:(UIGestureRecognizer *)recognizer
{
   }

- (void) dealWithData
{
    if (!self.response.address) {
        self.response.address = @"";
    }
    if ([self.response.pictures count] == 0) {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];;
    } else {
        self.tableView.tableHeaderView = self.cycleView;
        [self.cycleView reloadData];
    }
    self.titleArray = [NSMutableArray arrayWithObjects:self.response.address,@"支持运动项目",@"热门课程",@"驻点教练",self.response.descriptionString, nil];;
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
}


- (void) sendRequestToServer
{
    __block YardViewController *blockSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succeed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        blockSelf.response = [[[GymnasiumDetailResponse alloc] initWithJsonString:content] autorelease];
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
    if (!_request) {
        _request = [[GymnasiumDetailRequest alloc] init];
        _request.itemId = self.item.itemId;
    }
    [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

- (IBAction)didTaped:(id)sender
{
    CustomRoundImageTitle *button = (CustomRoundImageTitle *) sender;
    CoacheItem *item = [[self.response coaches] objectAtIndex:(button.tag - 1000)];
    TeacherViewController *controller = [[[TeacherViewController alloc] init] autorelease];
    controller.item = item;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - XLCycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return [self.response.pictures count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    
    NSString *picture = [self.response.pictures objectAtIndex:index];
    [imageView setImageWithURL:[NSURL URLWithString:picture]
                       placeholderImage:[UIImage imageNamed:kImageDefault]
                                success:^(UIImage *image){
                                    UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(320, 160)];
                                    imageView.image = image1;
                                }
                                failure:^(NSError *error){
                                   imageView.image = [UIImage imageNamed:kImageDefault];
                                }];
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    DEBUGLOG(@"selected index:%d", index);
}

@end
