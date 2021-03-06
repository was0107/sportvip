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
#import <MapKit/MapKit.h>
#import "ClassDetailViewController.h"
#import "PaggingRequest.h"
#import "UIView+extend.h"
#import "PaggingResponse.h"
#import "MapLocation.h"

@interface TeacherViewController()<MKMapViewDelegate>
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) CoacheDetailResponse *response;
@property (nonatomic, retain) CoachDetailRequest *request;
@property (nonatomic, retain) NSMutableArray *titleArray;

@end

@implementation TeacherViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_mapView);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_titleArray);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.item.name;
    self.trackViewId = @"教练详情页面";
    [self.tableView removeFromSuperview];
    [self sendRequestToServer];
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

- (MKMapView *) mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(10, 10, 300, 120)];
        _mapView.layer.borderColor = [kGrayColor CGColor];
        _mapView.layer.cornerRadius = 3.0f;
        _mapView.layer.borderWidth = 0.4f;
        _mapView.delegate = self;
    }
    return _mapView;
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
    __block TeacherViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];
    NSArray *titleArray = [NSArray arrayWithObjects:@"",@"个人简介",@"教练精选课程",@"教学点", nil];

    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == indexPath.section) {
            static NSString *identifier1 = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER0";
            TeacherTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (!cell1){
                cell1 = [[TeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell1 configTeacherDetailHeader];
            
            cell1.topLabelEx.text = blockSelf.response.name;
            CGSize size = [blockSelf.response.name sizeWithFont:cell1.topLabelEx.font constrainedToSize:CGSizeMake(190, 24)];
            if (size.width + 45 < 190) {
                [cell1.topLabelEx setFrameSize:CGSizeMake(size.width + 45, 24)];
            }
            [cell1.topLabelEx setImages:[NSArray arrayWithObjects:@"hot",@"xin",nil] origitation:1];
            
            cell1.topRigithEx.text = blockSelf.response.introduction;
            [cell1.leftImageView setImageWithURL:[NSURL URLWithString:blockSelf.response.avatar]
                               placeholderImage:[UIImage imageNamed:kImageDefault]
                                        success:^(UIImage *image){
                                            UIImage * image1 = [image imageScaledToSizeEx:CGSizeMake(100, 90)];
                                            cell1.leftImageView.image = image1;
                                            
                                        }
                                        failure:^(NSError *error){
                                            cell1.leftImageView.image = [UIImage imageNamed:kImageDefault];
                                        }];
            
            
            return (UITableViewCell *)cell1;
        }
        else if (1 == indexPath.section) {
            
            if (0 == indexPath.row) {
                static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER10";
                BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell){
                    cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                    cell.topLabel.textColor = kBlackColor;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.topLabel.frame = CGRectMake(10, 5, 300, 34);
                    cell.topLabel.numberOfLines = 0;
                    [cell.contentView addSubview:cell.topLabel];
                }
                
                CGSize size = [blockSelf.response.resume sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(280, 20000)];
                CGFloat height = MAX(size.height, 24);
                [cell.topLabel setFrameHeight:height+10];
                cell.topLabel.text = blockSelf.response.resume;
                return (UITableViewCell *)cell;
            }
            
            static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER11";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                cell.topLabel.textColor = kBlackColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.topLabel.frame = CGRectMake(10, 10, 80, 24);
                cell.subLabel.frame = CGRectMake(100, 10, 210, 24);
                cell.subLabel.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:cell.topLabel];
                [cell.contentView addSubview:cell.subLabel];
            }
            HornorItem *hornorItem = [[blockSelf.response hornors] objectAtIndex:indexPath.row-1];
            cell.topLabel.text = hornorItem.year;
            cell.subLabel.text = hornorItem.honor;
            return (UITableViewCell *)cell;

        }
        else if (2 == indexPath.section) {
            
            static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER12";
            BaseNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.topLabel.frame = CGRectMake(10, 10, 100, 24);
                cell.rightLabel.frame = CGRectMake(110, 10, 110, 24);
                cell.subRightLabel.frame = CGRectMake(220, 10, 70, 24);
                cell.topLabel.textColor = kBlackColor;
                cell.rightLabel.textAlignment = NSTextAlignmentRight;
                cell.subRightLabel.textAlignment = NSTextAlignmentRight;
                cell.subRightLabel.textColor = [UIColor getColor:KCustomGreenColor];
                cell.subRightLabel.font = HTFONTSIZE(kFontSize18);
                [cell.contentView addSubview:cell.topLabel];
                [cell.contentView addSubview:cell.rightLabel];
                [cell.contentView addSubview:cell.subRightLabel];
            }
            CourseItem *courseItem = [[[blockSelf response] courses] objectAtIndex:indexPath.row];
            cell.topLabel.text = courseItem.name;
            cell.rightLabel.text = courseItem.schoolTime;
            cell.subRightLabel.text = courseItem.priceString;
            return (UITableViewCell *)cell;
        }
        static NSString *identifier = @"TEACHER_TABLEVIEW_CELL_IDENTIFIER13";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:blockSelf.mapView];
        }
        return (UITableViewCell *)cell;
    };

    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == indexPath.section) {
            return 110.0f;
        }
        else  if (1 == indexPath.section) {
            if (0 == indexPath.row) {
                CGSize size = [blockSelf.response.resume sizeWithFont:HTFONTSIZE(kFontSize14) constrainedToSize:CGSizeMake(280, 20000)];
                CGFloat height = MAX(size.height, 24);
                return height+20;
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
            return (NSInteger)(1 + [[blockSelf.response hornors] count]);
        }
        else if (2 == section) {
            return (NSInteger)(0 + [[blockSelf.response courses] count]);
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
        if (2 == indexPath.section)
        {
            ClassDetailViewController *controller = [[[ClassDetailViewController alloc] init] autorelease];
            CourseItem *item = [[blockSelf.response courses] objectAtIndex:indexPath.row];
            controller.courseId = item.courseId;
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView){
        return 4;
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        if (0 == section) {
            return 0.0f;
        }
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        return size.height + 20;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section){
        
        NSArray *imageArray = [NSArray arrayWithObjects:@"map",@"sport",@"course",@"coach",@"desc",nil];
        NSString *string = [titleArray objectAtIndex:section];
        CGSize size = [string sizeWithFont:HTFONTSIZE(kFontSize16) constrainedToSize:CGSizeMake(280, 20000)];
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 5)] autorelease];
        view.backgroundColor = kWhiteColor;
        UIImageLabelEx *imageLabelEx = [[[UIImageLabelEx alloc] initWithFrame:CGRectMake(10, 6, 300, size.height+8)] autorelease];
        imageLabelEx.numberOfLines = 0;
        imageLabelEx.font = HTFONTSIZE(kFontSize16);
        [view addSubview:imageLabelEx];
        imageLabelEx.text = string;//@"上海闵行区什么路";
        [imageLabelEx setImage:[imageArray objectAtIndex:section] origitation:0];
        [imageLabelEx shiftPositionY:1];
        return (UIView *)view;
    };

    self.tableView.refreshBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };
}

- (void) dealWithMapData
{
    int minLength = MIN([_response.locations count], [_response.gymnasiumNames count]);
    if (minLength == 0) {
        return;
    }
    [_mapView removeAnnotations:[_mapView annotations]];
    double minLat = 90,minLng = 180,maxLat = -90,maxLng = -180;
    for (int i = 0 ; i < minLength ; i++)
    {
        
        CLLocation *item = [_response.locations objectAtIndex:i];
        MapLocation *location = [[[MapLocation alloc] init] autorelease];
        location.coordinate = item.coordinate;
        location.theTitle =[_response.gymnasiumNames objectAtIndex:i];
        
        [self.mapView addAnnotation:location];
        if (location.coordinate.latitude > maxLat) {
            maxLat = location.coordinate.latitude;
        }
        if (location.coordinate.longitude>maxLng) {
            maxLng = location.coordinate.longitude;
        }
        if (location.coordinate.latitude<minLat) {
            minLat = location.coordinate.latitude;
        }
        if (location.coordinate.longitude<minLng) {
            minLng = location.coordinate.longitude;
        }
    }
    
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake((minLat+maxLat)/2, (minLng+maxLng)/2), MKCoordinateSpanMake((maxLat-minLat)+0.01, (maxLng-minLng)+0.01)) animated:YES];
}

- (void) dealWithData
{
    [self dealWithMapData];
    [self.mapView setExclusiveTouch:YES];
    [self.tableView reloadData];
    [self.view addSubview:self.tableView];}


- (void) sendRequestToServer
{
    __block TeacherViewController *blockSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succeed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
        blockSelf.response = [[[CoacheDetailResponse alloc] initWithJsonString:content] autorelease];
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
        _request = [[CoachDetailRequest alloc] init];
        _request.itemId = self.item.itemId;
    }
    [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

#pragma mark ==
#pragma mark == MKAnnotationView

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if(annotationView == nil) {
        annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"] autorelease];
        annotationView.canShowCallout = YES;
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
        annotationView.highlighted = YES;
        [annotationView setSelected:YES animated:YES];
    }
    
    return annotationView;
}

@end
