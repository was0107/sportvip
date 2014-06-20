//
//  HomeViewController.m
//  sport
//
//  Created by allen.wang on 5/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "HomeViewController.h"
#import "ClassTableViewCell.h"
#import "TeacherTableViewCell.h"
#import "SearchViewController.h"
#import "CustomSelectControl.h"
#import "DataManager.h"
#import "SurroundViewController.h"
#import "ZJSwitch.h"
#import "YardViewController.h"
#import "TeacherViewController.h"
#import "PaggingRequest.h"
#import "PaggingResponse.h"
#import "STLocationInstance.h"

@interface HomeViewController ()
@property (nonatomic, retain) UIButton *typeButton;
@property (nonatomic, retain) UIButton *cityButton;
@property (nonatomic, retain) UIButton *mapButton;
@property (nonatomic, retain) UIView   *titleView;
@property (nonatomic, retain) UIView   *searchView;
@property (nonatomic, retain) UITextField  *searchTextView;
@property (nonatomic,retain) CustomSelectControl *selectControl;

@property (nonatomic, retain) UIButton *button1, *button2, *button3;
@property (nonatomic, retain) UIView   *sectionView;
@property (nonatomic, retain) ZJSwitch *zjWwitch;
@property (nonatomic, retain) GymnasiumsRequest *request;
@property (nonatomic, retain) GymnasiumsResponse *response;

@property (nonatomic, retain) CoachesRequest *coachesRequest;
@property (nonatomic, retain) CoachsResponse *coachesResponse;

@end

@implementation HomeViewController
{
    __block int  _type;
    __block int _currentType,_distanceIndex,_cateIndex,_sortIndex;

}

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
    _type = 0;
    self.title = @"首页";
    self.titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    self.titleView.backgroundColor = kClearColor;
    [self configTitleView];
    [self configSectionView];
    self.navigationItem.titleView = self.titleView;
}

- (void) configTitleView
{
//    self.typeButton                     = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.typeButton.frame               = CGRectMake(0, 0, 44, 44);
//    self.typeButton.backgroundColor     = kClearColor;
//    [self.typeButton addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.typeButton setNormalImage:@"icon_index_class_n" selectedImage:@"icon_index_class_f"];
//    [self.titleView addSubview:self.typeButton];


    self.cityButton                     = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cityButton.frame               = CGRectMake(0, 0, 44, 44);
    self.cityButton.backgroundColor     = kClearColor;
    [self.cityButton addTarget:self action:@selector(cityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cityButton setTitle:@"上海" forState:UIControlStateNormal];
    [self.cityButton setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];

    [self.titleView addSubview:self.cityButton];


    self.mapButton                      = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mapButton.frame                = CGRectMake(182, 4, 34, 34);
    self.mapButton.backgroundColor      = kClearColor;
    [self.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapButton setNormalImage:@"icontop_location_n" selectedImage:@"icontop_location_n"];
    [self.titleView addSubview:self.mapButton];


    UIView *bottomView                  = [[[UIView alloc] initWithFrame:CGRectMake(92, 7, 165, 30)] autorelease];
    bottomView.backgroundColor          = kClearColor;
    bottomView.layer.cornerRadius       = 4.0f;
    bottomView.layer.borderWidth        = 0.5f;
    bottomView.layer.borderColor        = [kLightGrayColor CGColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [bottomView addGestureRecognizer:singleTap];

    UIImageView *searchIcon             = [[[UIImageView  alloc] initWithFrame:CGRectMake(5, 5, 20, 20)] autorelease];
    searchIcon.image                    = [UIImage imageNamed:@"icon_search"];
//    [bottomView addSubview:searchIcon];

//    self.searchTextView                 = [[[UITextField alloc] initWithFrame:CGRectMake(34, 0, 125, 30)] autorelease];
//    self.searchTextView.font            = HTFONTSIZE(kFontSize14);
//    self.searchTextView.backgroundColor = kClearColor;
//    self.searchTextView.textColor       = kLightGrayColor;
//    self.searchTextView.placeholder     = @"搜索课程";
//    self.searchTextView.enabled         = NO;
//    [bottomView addSubview:self.searchTextView];

    self.zjWwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(230, 4, 75, 34)];
    self.zjWwitch.backgroundColor = [UIColor clearColor];
    self.zjWwitch.tintColor = [UIColor orangeColor];
    self.zjWwitch.onText = @"教练";
    self.zjWwitch.offText = @"场地";
    self.zjWwitch.textFont = [UIFont systemFontOfSize:17];
    
    [self.zjWwitch addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventValueChanged];
    [self.titleView addSubview:self.zjWwitch];

    
//    [self.titleView addSubview:bottomView];
}

- (void) configSectionView
{
    self.sectionView                    = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    self.sectionView.backgroundColor   = kClearColor;
    
    self.button1                     = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame               = CGRectMake(0, 0, 108, 40);
    self.button1.backgroundColor     = kClearColor;
    [self.button1 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionView addSubview:self.button1];
    
    
    self.button2                     = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame               = CGRectMake(110, 0, 108, 40);
    self.button2.backgroundColor     = kClearColor;
    [self.button2 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionView addSubview:self.button2];
    
    
    self.button3                     = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame               = CGRectMake(220, 0, 108, 40);
    self.button3.backgroundColor     = kClearColor;
    [self.button3 addTarget:self action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
   
    
    [self.button1 setTitle:@"项目" forState:UIControlStateNormal];
    [self.button2 setTitle:@"年龄" forState:UIControlStateNormal];
    [self.button3 setTitle:@"距离" forState:UIControlStateNormal];
    [self.button1.titleLabel setFont:HTFONTSIZE(kFontSize16)];
    [self.button2.titleLabel setFont:HTFONTSIZE(kFontSize16)];
    [self.button3.titleLabel setFont:HTFONTSIZE(kFontSize16)];

    [self.button1 setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor getColor:KCustomGreenColor] forState:UIControlStateNormal];

    [self.sectionView addSubview:self.button3];
    
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [kBlueColor CGColor];
    layer.frame = CGRectMake(0, 43.8f, 320, 0.2f);
    [self.sectionView.layer addSublayer:layer];
    
    [self.view addSubview:self.sectionView];
}

- (IBAction)sectionButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button == self.button1) {
        _currentType = 0;
        self.selectControl.contentArray = [DataManager sharedInstance].sortArray;
        self.selectControl.currentIndex = _distanceIndex;
        self.selectControl.tipLabel.text = @"注：项目是按照字母进行排序";
    }
    else if (button == self.button2) {
        _currentType = 1;
        self.selectControl.contentArray = [DataManager sharedInstance].categoryAndsubArray;//cateArray;
        self.selectControl.currentIndex = _cateIndex;
        self.selectControl.tipLabel.text = @"注：请选择合适的年龄段";
    }
    else {
        _currentType = 2;
        self.selectControl.contentArray = [DataManager sharedInstance].distanceArray;//;
        self.selectControl.currentIndex = _sortIndex;
        self.selectControl.tipLabel.text = @"";
    }
    [self.selectControl showContent:YES];
}

- (IBAction)typeButtonAction:(id)sender
{
    _type = (0 == _type) ? 1 : 0;
    if (0 == _type) {
        [self.typeButton setNormalImage:@"icon_index_class_n" selectedImage:@"icon_index_class_f"];
    } else {
        [self.typeButton setNormalImage:@"icon_index_school_n" selectedImage:@"icon_index_school_f"];
    }
    [self.request firstPage];
    [self.coachesRequest firstPage];
    [self sendRequestToServer];
}

- (IBAction)cityButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UDK_SHOW_CITY object:nil];
}

- (IBAction)mapButtonAction:(id)sender
{
    SurroundViewController *controller = [[[SurroundViewController alloc] init] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) handleTap:(UITapGestureRecognizer *)recognizer
{
    SearchViewController *controller = [[[SearchViewController alloc] init] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (NSString *)tabImageName
{
    return @"icon_tabbar_hzxs_f";
}

- (NSString *)tabSelectedImageName
{
    return @"icon_tabbar_hzxs_n";
}

- (CGRect)tableViewFrame
{
    return CGRectMake(0, 40, 320.0, kContentBoundsHeight-84);
}

- (void) configTableView
{
    __block HomeViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        if (0 == _type) {
            static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
            ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell){
                cell = [[[ClassTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
            }
            [cell configWithType:1];
            GymnasiumItem *item = [blockSelf.response at:indexPath.row];
            [cell configWithData:item];
            return (UITableViewCell *)cell;
        }
        else {
            static NSString *identifier1 = @"HOME_TABLEVIEW_CELL_IDENTIFIER1";
            TeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (!cell){
                cell = [[[TeacherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1] autorelease];
            }
            [cell configWithType:0];
            CoacheItem *item = [blockSelf.coachesResponse at:indexPath.row];
            [cell configWithData:item];
            return (UITableViewCell *)cell;
        }
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  (CGFloat)((0 == _type) ? 113.0f : 100.0f);
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)(0 == _type) ? [blockSelf.response count] : [blockSelf.coachesResponse count];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return (CGFloat)0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (0 == _type) {
            YardViewController *controller = [[[YardViewController alloc] init] autorelease];
            GymnasiumItem *item = [blockSelf.response at:indexPath.row];
            controller.item = item;
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        } else {
            
            TeacherViewController *controller = [[[TeacherViewController alloc] init] autorelease];
            CoacheItem *item = [blockSelf.response at:indexPath.row];
            controller.item = item;
            [controller setHidesBottomBarWhenPushed:YES];
            [blockSelf.navigationController pushViewController:controller animated:YES];
        }
    };
    
    self.tableView.refreshBlock = ^(id content) {
        (0 == _type) ? [blockSelf.request firstPage] : [blockSelf.coachesRequest firstPage];
        [blockSelf sendRequestToServer];
    };
    
    self.tableView.loadMoreBlock = ^(id content) {
        [blockSelf sendRequestToServer];
    };

    [self.view addSubview:self.tableView];
    
//    [self sendRequestToServer];
    
//    [self dealWithData];
    [self.tableView doSendRequest:YES];
}

- (void) dealWithData
{
    self.tableView.didReachTheEnd = [_response lastPage];
    if ([self.response isEmpty]) {
        [self.tableView showEmptyView:YES];
    }
    else {
        [self.tableView showEmptyView:NO];
    }
    [self.tableView reloadData];
}

- (GymnasiumsRequest *) request
{
    if (!_request) {
        _request = [[GymnasiumsRequest alloc] init];
    }
    return _request;
}

- (CoachesRequest *) coachesRequest
{
    if (!_coachesRequest) {
        _coachesRequest = [[CoachesRequest alloc] init];
    }
    return _coachesRequest;
}


- (void) startLocation
{
    __block HomeViewController *blockSelf = self;
    [STLocationInstance sharedInstance].placeBlock = ^(id place) {
        CLPlacemark *placemark = (CLPlacemark *) place;
        blockSelf.request.longitude = placemark.location.coordinate.longitude;
        blockSelf.request.latitude = placemark.location.coordinate.latitude;
        [SVProgressHUD showSuccessWithStatus:@"定位成功"];
        [blockSelf sendRequestToServer];
    };
}


- (void) sendRequestToServer
{
    if (![STLocationInstance sharedInstance].checkinLocation) {
        [SVProgressHUD showWithOnlyStatus:@"正在定位..." duration:30];
        [self startLocation];
        return;
    }
    __block HomeViewController *blockSelf = self;
    
     if (0 == _type) {
         idBlock succBlock = ^(id content){
             DEBUGLOG(@"succeed content %@", content);
             [blockSelf.tableView tableViewDidFinishedLoading];
             if ([_request isFristPage]) {
                 blockSelf.response = [[[GymnasiumsResponse alloc] initWithJsonString:content] autorelease];
             } else {
                 [blockSelf.response appendPaggingFromJsonString:content];
             }
             [_request nextPage];
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
         [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
     }
     else {
         idBlock succBlock = ^(id content){
             DEBUGLOG(@"succeed content %@", content);
             [blockSelf.tableView tableViewDidFinishedLoading];
             if ([_coachesRequest isFristPage]) {
                 blockSelf.coachesResponse = [[[CoachsResponse alloc] initWithJsonString:content] autorelease];
             } else {
                 [blockSelf.coachesResponse appendPaggingFromJsonString:content];
             }
             [_coachesRequest nextPage];
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
         [WASBaseServiceFace serviceWithMethod:[self.coachesRequest URLString] body:[self.coachesRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
     }
}


- (CustomSelectControl *) selectControl
{
    if (!_selectControl) {
        __weak HomeViewController *blockSelf = self;
        _selectControl = [[CustomSelectControl alloc] initWithController:self];
        _selectControl.belowView = self.sectionView;
        _selectControl.cellBlock = ^(UIPickerView *pickerView, NSInteger row, NSInteger component) {
            CategoryItem *item = [_selectControl.contentArray objectAtIndex:row];
            return item.categoryName;
        };

        _selectControl.componetBlock = ^(id content) {
            return (NSInteger)1;
        };
        _selectControl.widthBlock = ^(id content, NSInteger positon) {
            return (CGFloat)100.0f;
        };
        _selectControl.componetRowsBlock = ^(id content, NSInteger positon) {
            return (NSInteger)[_selectControl.contentArray count];
        };
        _selectControl.block = ^(id content) {
//            [blockSelf setButtonTitle:content];
        };
    }
    return _selectControl;
}


@end
