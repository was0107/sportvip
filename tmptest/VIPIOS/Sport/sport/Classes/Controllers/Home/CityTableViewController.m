//
//  CityTableViewController.m
//  Discount
//
//  Created by allen.wang on 6/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "CityTableViewController.h"
#import "BaseTableViewCell.h"
#import "STLocationInstance.h"
//#import "DataManager.h"

@interface CityTableViewController ()
//@property (nonatomic, retain) ListCityResponse *response;
@property (nonatomic, retain) UILabel *currentCity;

@end

@implementation CityTableViewController
//@synthesize response = _response;
@synthesize currentCity = _currentCity;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"选择城市"];
    if ([[self.navigationController viewControllers] count] == 1) {
        [self showRight];
        [self.rightButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    [NSNumber numberWith];
    [self.view addSubview:self.currentCity];
    [self sendRequestToServer];
    [self startLocation];
    
}

- (UILabel *) currentCity
{
    if (!_currentCity) {
        _currentCity = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 220,24)];
        _currentCity.backgroundColor = kClearColor;
        _currentCity.textColor = kDarkTextColor;
        _currentCity.text = @"当前定位城市：--";
        _currentCity.font = HTFONTBIGSIZE(kFontSize16);
    }
    return _currentCity;
}

- (void) leftButtonAction:(id)sender
{
    if ([[self.navigationController viewControllers] count] > 1) {
        [super leftButtonAction:sender];
    } else {
        [self.navigationController dismissModalViewControllerAnimated:YES];
        
    }
}


- (IBAction)rightButtonAction:(id)sender
{
    if ([[self.navigationController viewControllers] count] > 1) {
        [super leftButtonAction:sender];
    } else {
        [self.navigationController dismissModalViewControllerAnimated:YES];
    }
}

- (int) tableViewType
{
    return eTypeNone;
}

- (CGRect) tableViewFrame
{
    CGRect rect = kContentNoBtmFrame;
    rect.origin.y += 44.0f;
    rect.size.height -= 44.0f;
    return rect;
}

- (void) startLocation
{
    [STLocationInstance sharedInstance].cityBlock = ^(id content) {
        if (content) {
            _currentCity.text = [NSString stringWithFormat:@"当前定位城市：%@", content];
        } else {
            _currentCity.text = [NSString stringWithFormat:@"当前定位城市：%@", @"定位失败"];
        }
    };
    [[STLocationInstance sharedInstance] setupLocationManger];
}

- (void)sendRequestToServer
{
//    __block CityTableViewController *safeSelf = self;
//    idBlock successBlock = ^(id content){
//        [safeSelf.tableView tableViewDidFinishedLoading];
//        safeSelf.response = [[[ListCityResponse alloc] initWithJsonString:content] autorelease];
//        DEBUGLOG(@"success content %@", _response.result);
//        [safeSelf.tableView reloadData];
//    };
//    
//    idBlock failedBlock = ^(id content){
//        DEBUGLOG(@"failed content %@", content);
//        [safeSelf.tableView tableViewDidFinishedLoading];
//    };
//    
//    ListCityRequest *request = [[[ListCityRequest alloc] init] autorelease];
//    [WASBaseServiceFace serviceWithMethod:[request methodString] body:[request toURLString] onSuc:successBlock onFailed:failedBlock onError:failedBlock];
    
}

- (void) configTableView
{
//    __block CityTableViewController *safeSelf = self;
//
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
//        static NSString *identifier = @"MORE_CELL_IDENTIFIER";
//        BaseSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!cell){
//            cell = [[[BaseSingleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
//            cell.contentView.clipsToBounds = YES;
//        }
//        ListCityItem *item = [_response.result objectAtIndex:indexPath.row];
//        cell.accessoryType = ([[DefaultsManager city] isEqualToString:item.cityName]) ? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
//        cell.contentView.backgroundColor = (indexPath.row %2 == 0) ? [UIColor getColor:@"f1f1f1"]: [UIColor getColor:@"e8e8e8"];
//        cell.topLabel.text = item.cityName;
//        return cell;
//    };
//    
//    self.tableView.cellNumberBlock = ^(UITableView *tableView, NSInteger section){
//        return (NSInteger)[_response.result count];
//    };
//    
//    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        ListCityItem *item = [_response.result objectAtIndex:indexPath.row];
//        [DefaultsManager saveCity:item.cityName];
//        [tableView reloadData];
//        [safeSelf leftButtonAction:nil];
//    };
}



- (void) dealloc
{
//    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_currentCity);
    [super dealloc];
}
@end
