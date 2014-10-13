//
//  MiddleViewController.m
//  sfdl
//
//  Created by boguang on 14-9-21.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "MiddleViewController.h"
#import "InfiniteTreeView.h"
#import "InfiniteTreeBaseCell.h"
#import "CreateObject.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "ProductListViewController.h"

@interface MiddleviewCell : InfiniteTreeBaseCell

@property (nonatomic, retain) UILabel   *myTextLabel;

@end


@implementation MiddleviewCell

- (void) dealloc
{
    TT_RELEASE_SAFELY(_myTextLabel);
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.myTextLabel];
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
        view.backgroundColor = kWhiteColor;
        self.selectedBackgroundView = view;

    }
    return self;
}

- (UILabel *) myTextLabel
{
    if (!_myTextLabel) {
        _myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, 312, 36)];
        _myTextLabel.backgroundColor = kClearColor;
        _myTextLabel.textColor = kBlackColor;
    }
    return _myTextLabel;
}
@end

@interface MiddleViewController () <PushTreeViewDataSource, PushTreeViewDelegate>
@property (nonatomic, retain) InfiniteTreeView *pushTreeView;

@property (nonatomic, retain) ProductTypeRequest *prodcutTypeRequest;
@property (nonatomic, retain) ProductTypeReponse *prodcutTypeResponse;
@property (nonatomic, retain) NSMutableDictionary *selectedDiction;
@property (nonatomic, assign) ProductTypeItem     *lastSelectedItem;
@end

@implementation MiddleViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_prodcutTypeRequest);
    TT_RELEASE_SAFELY(_prodcutTypeResponse);
    TT_RELEASE_SAFELY(_selectedDiction);
    TT_RELEASE_SAFELY(_pushTreeView);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self showSearch] showRight];
    [self setTitleContent:NSLocalizedString(@"PRODUCTS",@"PRODUCTS")];
    [self.view addSubview:self.pushTreeView];
    self.selectedDiction = [NSMutableDictionary dictionary];
    [self sendRequestToGetProductTypeServer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (InfiniteTreeView *) pushTreeView
{
    if (!_pushTreeView) {
        _pushTreeView = [[InfiniteTreeView loadFromXib] retain];
        _pushTreeView.frame = self.view.bounds;
        _pushTreeView.dataSource = self;
        _pushTreeView.delegate = self;
    }
    return _pushTreeView ;
}

- (void) sendRequestToGetProductTypeServer
{
    __unsafe_unretained typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.prodcutTypeResponse = [[ProductTypeReponse alloc] initWithJsonString:content];
        
        [blockSelf.pushTreeView reloadData];
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

- (NSMutableArray *) getCurrentLevelArray:(NSInteger) level
{
    if (0 == level) {
        return [self.prodcutTypeResponse result];
    }
    else if (1 == level){
        NSIndexPath *indexPath = [self.selectedDiction objectForKey:kIntToString(0)];
        ProductTypeItem  *typeItem = [self.prodcutTypeResponse at:indexPath.row];
        return typeItem.children;
    }
    else {
        NSIndexPath *indexPath = [self.selectedDiction objectForKey:kIntToString(0)];
        ProductTypeItem  *typeItem = [self.prodcutTypeResponse at:indexPath.row];
        for (int i = 1; i < level; i++) {
            indexPath = [self.selectedDiction objectForKey:kIntToString(i)];
            typeItem = [[typeItem children] objectAtIndex:indexPath.row];
        }
        return typeItem.children;
    }
    return [NSMutableArray array];
}

#pragma mark - PushTreeViewDataSource
- (NSInteger)numberOfSectionsInLevel:(NSInteger)level
{
    return 1;
}

- (NSInteger)numberOfRowsInLevel:(NSInteger)level section:(NSInteger)section
{
    return [[self getCurrentLevelArray:level] count];
}

- (InfiniteTreeBaseCell *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    static NSString *identifier = @"UserInfoCell";
    MiddleviewCell *cell = (MiddleviewCell*)[pushTreeView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MiddleviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (0 == level) {
        cell.backgroundColor = kWhiteColor;
        cell.myTextLabel.textColor = kBlackColor;
        cell.selectedBackgroundView.backgroundColor =  kWhiteColor;//[UIColor getColor:@"434343"];
    } else if (1 == level) {
        cell.backgroundColor = [UIColor getColor:@"434343"];
        cell.myTextLabel.textColor = kWhiteColor;
        cell.selectedBackgroundView.backgroundColor =  [UIColor getColor:@"262626"];
    } else {
        cell.backgroundColor = [UIColor getColor:@"262626"];
        cell.myTextLabel.textColor = kWhiteColor;
        cell.selectedBackgroundView.backgroundColor =  kBlackColor;
    }
    ProductTypeItem *item = [[self getCurrentLevelArray:level] objectAtIndex:indexPath.row];
    cell.myTextLabel.text = item.productTypeName;
    return cell;
}

#pragma mark - PushTreeViewDelegate
- (void)pushTreeView:(InfiniteTreeView *)pushTreeView didSelectedLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    [self.selectedDiction setObject:indexPath   forKey:kIntToString(level)];
    ProductTypeItem *item = [[self getCurrentLevelArray:level] objectAtIndex:indexPath.row];

    if ([[item children] count] == 0)
    {
        ProductTypeItem *selectedItem = [[self getCurrentLevelArray:level] objectAtIndex:indexPath.row];
        ProductListViewController *controller = [[[ProductListViewController alloc] init] autorelease];
        controller.sectionTitle = selectedItem.productTypeName;
        controller.productTypeId = selectedItem.productTypeId;
        [self.navigationController hidesBottomBarWhenPushed];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (UIView *)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)pushTreeView:(InfiniteTreeView *)pushTreeView level:(NSInteger)level heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (BOOL)pushTreeViewHasNextLevel:(InfiniteTreeView *)pushTreeView currentLevel:(NSInteger)level indexPath:(NSIndexPath*)indexPath
{
    [self.selectedDiction setObject:indexPath   forKey:kIntToString(level)];
    BOOL next = TRUE;
    
    ProductTypeItem *item = [[self getCurrentLevelArray:level] objectAtIndex:indexPath.row];
    
    if ([[item children] count] == 0) {
        next = FALSE;
    }
    return next;
}

- (void)pushTreeViewWillReloadAtLevel:(InfiniteTreeView*)pushTreeView currentLevel:(NSInteger)currentLevel level:(NSInteger)level                            indexPath:(NSIndexPath*)indexPath
{
    pushTreeView.backgroundColor = kRedColor;
}

#pragma mark - IBAction methods
- (IBAction)onBackBtnTouched:(id)sender
{
    if (_pushTreeView.level > 0) {
        [_pushTreeView back];
    }
}



@end
