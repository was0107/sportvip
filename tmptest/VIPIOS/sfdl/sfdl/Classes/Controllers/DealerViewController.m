//
//  DealerViewController.m
//  sfdl
//
//  Created by allen.wang on 6/30/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "DealerViewController.h"
#import "CreateObject.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "AgentListViewController.h"

@interface DealerViewController ()<UIPopoverListViewDataSource, UIPopoverListViewDelegate,UITextFieldDelegate>
@property (nonatomic, retain) ProductTypeRequest *prodcutTypeRequest;
@property (nonatomic, retain) ProductTypeReponse *prodcutTypeResponse;

@property (nonatomic, retain) RegionListRequest  *regionRequest;
@property (nonatomic, retain) RegionResponse     *regionResponse;

@property (nonatomic, assign) ProductTypeItem    *typeItem;
@property (nonatomic, assign) RegionItem         *regionItem;
@property (nonatomic, copy)  NSString            *name, *address;




//@property (nonatomic, retain) ProductPropertySearchConditions   *request;
//@property (nonatomic, retain) ProductPropertySearchResponse     *response;
//@property (nonatomic, retain) NSMutableArray *propertyId,*propertyListId,*propertyListValues;

@end

@implementation DealerViewController
{
    NSUInteger _currentIndex;
    NSMutableDictionary *_contentDictionary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _contentDictionary = [[NSMutableDictionary alloc] init];
    self.secondTitleLabel.text = @"Dealer";
    [self setTitleContent:@"DEALER"];

    self.name = @"";
    self.address = @"";
    self.typeItem =nil;
    self.regionItem = nil;
    [self.tableView setup];
    [self sendRequestToGetProductTypeServer];
    [self sendRequestToGetRegionServer];
    // Do any additional setup after loading the view.
}

- (void) createHeaderView
{
    UIView *headerView = [[[UIView  alloc] initWithFrame:CGRectMake(0, 0, 320, 110)] autorelease];
    headerView.backgroundColor = kClearColor;
    
    UIView *topView = [[[UIView  alloc] initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
    topView.backgroundColor = kWhiteColor;
    
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 300, 40)] autorelease];
    label.numberOfLines = 2;
    label.textColor = kBlackColor;
    label.backgroundColor = kClearColor;
    label.font = HTFONTSIZE(kFontSize14);
    label.text = @"Need help finding a Cat dealer near you? To user the Cat dealer locator below, simply enter your address and ...";
    
    [topView addSubview:label];
    [headerView addSubview:topView];
    
    topView = [[[UIView  alloc] initWithFrame:CGRectMake(-1, 60, 322, 40)] autorelease];
    topView.backgroundColor = kWhiteColor;
    topView.layer.borderWidth = 0.5f;
    topView.layer.borderColor = [[UIColor colorWithWhite:0.4f alpha:0.2f] CGColor];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 2, 300, 34)] autorelease];
    label.numberOfLines = 2;
    label.backgroundColor = kClearColor;
    label.font = HTFONTSIZE(kFontSize14);
    label.textColor = kOrangeColor;
    label.text = @"Dark Gray pins Represent Home Dealer for Your Area";
    
    [topView addSubview:label];
    [headerView addSubview:topView];
    self.tableView.tableHeaderView = headerView;
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __block DealerViewController *blockSelf = self;
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    [self createHeaderView];
    self.tableView.tableFooterView = [self footerView];//[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.separatorColor = kClearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *titlesArray[3][2] = {{@"Address, City,Stage,or Postal Code/Country"},
            {@"For this type of Equipment",@"Show this type of location"},
            {@"Dealer Name"}};
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            

            cell.topLabel.frame = CGRectMake(10, 3, 300, 25);
            cell.textField.frame = CGRectMake(10, 28, 300, 30);
            cell.subLabel.frame = CGRectMake(10, 28, 300, 30);
            cell.subLabel.textAlignment = NSTextAlignmentRight;
            cell.subLabel.layer.borderColor = [kLightGrayColor CGColor];
            cell.subLabel.layer.borderWidth = 1.0f;
            cell.textField.layer.borderColor = [kLightGrayColor CGColor];
            cell.textField.layer.borderWidth = 1.0f;
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font =  cell.subLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.textField];
            cell.textField.delegate = self;
            
        }
        cell.topLabel.text = titlesArray[indexPath.section][indexPath.row];
        if (0 == indexPath.section) {
            [cell.subLabel removeFromSuperview];
            [cell.contentView addSubview:cell.textField];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (1 == indexPath.section ){
            [cell.textField removeFromSuperview];
            [cell.contentView addSubview:cell.subLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
            if (0 == indexPath.row) {
                cell.subLabel.text = (!self.typeItem) ? @"请选择  " : self.typeItem.productTypeName;
                cell.subLabel.textAlignment = (!self.typeItem) ? NSTextAlignmentRight : NSTextAlignmentLeft;
            } else {
                cell.subLabel.text = (!self.regionItem) ? @"请选择  " : self.regionItem.name;
                cell.subLabel.textAlignment = (!self.regionItem) ? NSTextAlignmentRight : NSTextAlignmentLeft;
            }
        } else {
            [cell.subLabel removeFromSuperview];
            [cell.contentView addSubview:cell.textField];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)(1 != section) ? 1 : 2;
    };
    
    self.tableView.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        return  64.0f;
    };
    
    self.tableView.sectionNumberBlock = ^( UITableView *tableView) {
        return (NSInteger)3;
    };
        
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return (0 < section) ? 22.0f : 0.0f;
    };
    
    self.tableView.sectionHeaderBlock = ^( UITableView *tableView, NSInteger section)
    {
        UIView *footerView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)]autorelease];
        footerView.backgroundColor = kWhiteColor;
        UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(10,0,300,22)] autorelease];
        label1.text = (eSectionIndex02 == section) ? @"OR" : @"MORE SEARCH OPTIONS";
        label1.font = HTFONTSIZE(kFontSize15);
        label1.textColor =  (eSectionIndex02 == section) ? kBlackColor : kOrangeColor;
        [footerView addSubview:label1];
        return footerView;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        if (1 != indexPath.section) {
            return ;
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (0 == indexPath.row) {
            [blockSelf.poplistview setTitle:@"Product Type"];
        }else{
            [blockSelf.poplistview setTitle:@"Region"];
        }
        _currentIndex = indexPath.row;
        [blockSelf.poplistview.listView reloadData];
        [blockSelf.poplistview show];
    };
    
    [self.view addSubview:self.tableView];
}


- (UIView *) footerView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
    view.backgroundColor = kClearColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"FIND LOCATIONS" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showTeachers:) forControlEvents:UIControlEventTouchUpInside];
    [CreateObject addTargetEfection:button];
    button.frame = CGRectMake(10, 10, 160, 40);
    [view addSubview:button];
    return view;
}

- (IBAction)showTeachers:(id)sender
{
    [self.tableView setEditing:NO];
    [self sendRequestToServer];
}

- (void) sendRequestToGetProductTypeServer
{
    __block DealerViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.prodcutTypeResponse = [[ProductTypeReponse alloc] initWithJsonString:content];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_prodcutTypeRequest) {
        self.prodcutTypeRequest = [[[ProductTypeRequest  alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.prodcutTypeRequest URLString] body:[self.prodcutTypeRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];

}

- (void) sendRequestToGetRegionServer
{
    __block DealerViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.regionResponse = [[RegionResponse alloc] initWithJsonString:content];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_regionRequest) {
        self.regionRequest = [[[RegionListRequest alloc] init] autorelease];
    }
    
    [WASBaseServiceFace serviceWithMethod:[self.regionRequest URLString] body:[self.regionRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];

}

- (void) sendRequestToServer
{
    AgentListViewController *controller = [[[AgentListViewController alloc] init] autorelease];
    controller.name = self.name;
    controller.regionItem = self.regionItem;
    controller.typeItem = self.typeItem;
    [self.navigationController hidesBottomBarWhenPushed];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.name = textField.text;
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
        }
    }
    return _poplistview;
}


- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HOME_TABLEVIEW_CELL_IDENTIFIER0";
    BaseNewTableViewCell *cell = [popoverListView.listView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[BaseNewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.topLabel.frame = CGRectMake(15, 10, 280, 30);
        cell.subLabel.frame = CGRectMake(150, 10, 140, 30);
        cell.topLabel.font = cell.subLabel.font = HTFONTSIZE(kFontSize18);
        [cell.contentView addSubview:cell.topLabel];
    }
    if (0 == _currentIndex) {
        ProductTypeItem *productTiem = [self.prodcutTypeResponse at:indexPath.row];
        cell.topLabel.text = productTiem.productTypeName;
    } else {
        RegionItem  *regionItem = [self.regionResponse  at:indexPath.row];
        cell.topLabel.text = regionItem.name;
    }
    return (UITableViewCell *)cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return (0 == _currentIndex) ? [[self.prodcutTypeResponse result] count] : [[self.regionResponse result] count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView didSelectIndexPath:(NSIndexPath *)indexPath
{
    DEBUGLOG(@"%s : %d", __func__, indexPath.row);
    [popoverListView.listView deselectRowAtIndexPath:indexPath animated:YES];
    if ((0 == _currentIndex) ) {
        self.typeItem = [self.prodcutTypeResponse at:indexPath.row];
        [_contentDictionary setObject:self.typeItem.productTypeName forKey:kIntToString(_currentIndex)];

    } else {
        self.regionItem = [self.regionResponse at:indexPath.row];
        [_contentDictionary setObject:self.regionItem.name forKey:kIntToString(_currentIndex)];
    }
    [self.tableView reloadData];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
@end
