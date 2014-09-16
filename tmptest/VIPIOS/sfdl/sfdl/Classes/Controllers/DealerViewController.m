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
@property (nonatomic, copy)  NSString            *name;




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
    self.typeItem =nil;
    self.regionItem = nil;
    [self.tableView setup];
    [self sendRequestToGetProductTypeServer];
    [self sendRequestToGetRegionServer];
    // Do any additional setup after loading the view.
}

- (int) tableViewType
{
    return eTypeNone;
}

- (void) configTableView
{
    __block DealerViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [self footerView];//[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *titlesArray[] = {@"Name/Address",@"Product Type",@"Region"};
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(15, 10, 110, 24);
            cell.subLabel.frame = CGRectMake(125, 10, 175, 24);
            cell.textField.frame = CGRectMake(125, 4, 175, 36);
            cell.subLabel.backgroundColor = kWhiteColor;
            cell.subLabel.textAlignment = NSTextAlignmentRight;
            cell.textField.layer.borderColor = [kBlueColor CGColor];
            cell.textField.layer.borderWidth = 1.0f;
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font =  cell.subLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.textField];
            cell.textField.delegate = self;
            
        }
        cell.topLabel.text = titlesArray[indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                cell.subLabel.text = (!self.typeItem) ? @"请选择" : self.typeItem.productTypeName;
                break;
            case 2:
                cell.subLabel.text = (!self.regionItem) ? @"请选择" : self.regionItem.name;
                break;
                
            default:
                break;
        }
        
        if (0 == indexPath.row) {
            [cell.subLabel removeFromSuperview];
            [cell.contentView addSubview:cell.textField];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            [cell.textField removeFromSuperview];
            [cell.contentView addSubview:cell.subLabel];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)3;
    };
    
        
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        if (0 == indexPath.row) {
            return ;
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (1 == indexPath.row) {
            [_poplistview setTitle:@"Product Type"];
            
        }
        else if (2 == indexPath.row) {
            [_poplistview setTitle:@"Region"];
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
    [button setTitle:@"Submit" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showTeachers:) forControlEvents:UIControlEventTouchUpInside];
    [CreateObject addTargetEfection:button];
    button.frame = CGRectMake(20, 10, 280, 44);
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
    if (1 == _currentIndex) {
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
    return (1 == _currentIndex) ? [[self.prodcutTypeResponse result] count] : [[self.regionResponse result] count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView didSelectIndexPath:(NSIndexPath *)indexPath
{
    DEBUGLOG(@"%s : %d", __func__, indexPath.row);
    [popoverListView.listView deselectRowAtIndexPath:indexPath animated:YES];
    if ((1 == _currentIndex) ) {
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
