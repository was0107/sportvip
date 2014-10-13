//
//  ProductSearchExViewController.m
//  sfdl
//
//  Created by allen.wang on 6/24/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductSearchExViewController.h"
#import "ProductListViewController.h"
#import "ProductRequest.h"
#import "CreateObject.h"

@interface ProductSearchExViewController ()<UIPopoverListViewDataSource, UIPopoverListViewDelegate>

@property (nonatomic, retain) ProductPropertySearchConditions   *request;
@property (nonatomic, retain) ProductPropertySearchResponse     *response;
@property (nonatomic, retain) SearchProductRequest              *productRequest;
@property (nonatomic, retain) ProductResponse                   *productResponse;
@property (nonatomic, retain) NSMutableArray *propertyId,*propertyListId,*propertyListValues;

@end

@implementation ProductSearchExViewController
{
    NSUInteger _currentIndex;
    NSMutableDictionary *_contentDictionary;
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_productRequest);
    TT_RELEASE_SAFELY(_productResponse);
    TT_RELEASE_SAFELY(_propertyId);
    TT_RELEASE_SAFELY(_propertyListId);
    TT_RELEASE_SAFELY(_propertyListValues);
    TT_RELEASE_SAFELY(_contentDictionary);
    TT_RELEASE_SAFELY(_poplistview);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.secondTitleLabel.text = @"Product Search";
    [self setTitleContent:NSLocalizedString(@"PRODUCT SEARCH",@"PRODUCT SEARCH")];

    _contentDictionary = [[NSMutableDictionary alloc] init];
    [self sendRequestToGetCondictionServer];
    self.propertyId = [NSMutableArray array];
    self.propertyListId = [NSMutableArray array];
    self.propertyListValues = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (int) tableViewType
{
    return  eTypeNone;
}

- (void) configTableView
{
    __unsafe_unretained ProductSearchExViewController *blockSelf = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.1f)];
    self.tableView.cellCreateBlock = ^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *identifier = @"ProductCategoryViewController_IDENTIFIER0";
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            
            cell.topLabel.frame = CGRectMake(15, 10, 85, 24);
            cell.subLabel.frame = CGRectMake(100, 10, 200, 24);
            cell.subLabel.backgroundColor = kWhiteColor;
            cell.subLabel.textAlignment = NSTextAlignmentRight;
            cell.topLabel.textColor = kBlackColor;
            cell.topLabel.font =  cell.subLabel.font = HTFONTSIZE(kFontSize14);
            [cell.contentView addSubview:cell.topLabel];
            [cell.contentView addSubview:cell.subLabel];
        }
        ProperItem *item = [blockSelf.response at:indexPath.row ];
        cell.topLabel.text = item.propertyName;
        if ([[_contentDictionary allKeys] containsObject:kIntToString(indexPath.row)]) {
            ProperListItem *propsItem = [_contentDictionary objectForKey:kIntToString(indexPath.row)];
            cell.subLabel.text = propsItem.propertyListValue;
        } else {
            cell.subLabel.text = NSLocalizedString(@"Choose",@"Choose");
        }
        return cell;
    };
    
    self.tableView.cellNumberBlock = ^( UITableView *tableView, NSInteger section) {
        return (NSInteger)[blockSelf.response arrayCount];
    };
    
    self.tableView.sectionHeaderHeightBlock = ^( UITableView *tableView, NSInteger section){
        return 0.0f;
    };
    
    self.tableView.cellSelectedBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ProperItem *item = [blockSelf.response at:indexPath.row ];
        [_poplistview setTitle:item.propertyName];
        _currentIndex = indexPath.row;
        [blockSelf.poplistview.listView reloadData];
        [blockSelf.poplistview show];
    };
 
    [self.view addSubview:self.tableView];
    
    
    [self sendRequestToGetCondictionServer];
}


- (void) dealWithData
{
    self.tableView.tableFooterView = [self footerView];
    [self.tableView reloadData];
}

- (void) sendRequestToGetCondictionServer
{
    __unsafe_unretained ProductSearchExViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[ProductPropertySearchResponse alloc] initWithJsonString:content];
        [blockSelf dealWithData];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    if (!_request) {
        self.request = [[[ProductPropertySearchConditions alloc] init] autorelease];
    }    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

- (void) sendRequestToServer
{
    __unsafe_unretained ProductSearchExViewController *blockSelf = self;
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Submiting...",@"Submiting...")];
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.productResponse = [[ProductResponse alloc] initWithJsonString:content];
        ProductListViewController *controller = [[[ProductListViewController alloc] init] autorelease];
        controller.secondTitleLabel.text = @"Product Search";
        controller.response = blockSelf.productResponse;
        [blockSelf.navigationController hidesBottomBarWhenPushed];
        [blockSelf.navigationController pushViewController:controller animated:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    if (!_productRequest) {
        self.productRequest = [[[SearchProductRequest alloc] init] autorelease];
    }
    
    [self.propertyId removeAllObjects];
    [self.propertyListId removeAllObjects];
    [self.propertyListValues removeAllObjects];
    for (NSString *key in [_contentDictionary allKeys]) {
        ProperListItem *listItem = [_contentDictionary objectForKey:key];
        NSInteger index = [key integerValue];
        ProperItem *item = [self.response at:index];
        [self.propertyId addObject:item.propertyId];
        [self.propertyListId addObject:listItem.propertyListId];
        [self.propertyListValues addObject:listItem.propertyListValue];
    }
    self.productRequest.propertyId = self.propertyId;
    self.productRequest.propertyListId = self.propertyListId;
    self.productRequest.propertyListValues = self.propertyListValues;
    [WASBaseServiceFace serviceWithMethod:[self.productRequest URLString] body:[self.productRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}


- (UIView *) footerView
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
    view.backgroundColor = kClearColor;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:NSLocalizedString(@"SUBMIT",@"SUBMIT") forState:UIControlStateNormal];
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
        cell.topLabel.frame = CGRectMake(60, 10, 100, 30);
        cell.subLabel.frame = CGRectMake(150, 10, 140, 30);
        cell.topLabel.font = cell.subLabel.font = HTFONTSIZE(kFontSize18);
        cell.leftImageView.frame = CGRectMake(8, 3, 44, 44);
        cell.leftImageView.layer.borderColor = [kWhiteColor CGColor];
        cell.leftImageView.layer.cornerRadius = 22.0f;
        cell.leftImageView.layer.borderWidth = 2.0f;
        [cell.contentView addSubview:cell.topLabel];
//        [cell.contentView addSubview:cell.subLabel];
//        [cell.contentView addSubview:cell.leftImageView];
    }
    
    ProperItem *item = [self.response at:_currentIndex ];
    ProperListItem *propsItem = [[item valueList] objectAtIndex:indexPath.row];
    
    cell.topLabel.text = propsItem.propertyListValue;
//    cell.leftImageView.image = [UIImage imageNamed:@"icon"];
    return (UITableViewCell *)cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    ProperItem *item = [self.response at:_currentIndex ];
    return  [[item valueList] count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    [popoverListView.listView deselectRowAtIndexPath:indexPath animated:YES];
    ProperItem *item = [self.response at:_currentIndex ];
    ProperListItem *propsItem = [[item valueList] objectAtIndex:indexPath.row];
    [_contentDictionary setObject:propsItem forKey:kIntToString(_currentIndex)];
    [self.tableView reloadData];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

@end
