//
//  B5MTableViewBase.m
//  PrettyUtility
//
//  Created by micker on 12/26/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import "B5MTableViewBase.h"

@implementation B5MTableViewBase
@synthesize refreshBlock = _refreshBlock;
@synthesize loadMoreBlock= _loadMoreBlock;
@synthesize cellBlock    = _cellBlock;
@synthesize heightBlock  = _heightBlock;
@synthesize selectedBlock= _selectedBlock;
@synthesize emptyTipView = _emptyTipView;
@synthesize shareTipView = _shareTipView;
@synthesize contentArray = _contentArray;
@synthesize totalCount   = _totalCount;
@synthesize reachTheEndCount    = _reachTheEndCount;
@synthesize selectedIndexPath   = _selectedIndexPath;


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id) theDelegate
{
    self = [super initWithFrame:frame style:UITableViewStylePlain type:theType delegate:self];
    if (self) {
        self.exDelegate = self;
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 90.0f;
        self.backgroundColor = kClearColor;
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self setupContentView];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_refreshBlock);
    TT_RELEASE_SAFELY(_loadMoreBlock);
    TT_RELEASE_SAFELY(_cellBlock);
    TT_RELEASE_SAFELY(_heightBlock);
    TT_RELEASE_SAFELY(_selectedBlock);
    TT_RELEASE_SAFELY(_emptyTipView);
    TT_RELEASE_SAFELY(_contentArray);
    TT_RELEASE_SAFELY(_selectedIndexPath);
    [super dealloc];
}

- (void) setupContentView
{
    
}


- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (!_contentArray) {
        [self.decoreate setFrame:frame];
    }
    
}

- (void) setContentArray:(NSMutableArray *)contentArray
{
    if (_contentArray != contentArray) {
        
        [_contentArray release];
        _contentArray = [contentArray retain];
    }
    
    _totalCount = [_contentArray count];
    [self didSetContentArray];
}

- (void) didSetContentArray
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellBlock) {
        return self.cellBlock(tableView,indexPath);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    if (self.selectedBlock) {
        self.selectedBlock(tableView,indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightBlock) {
        return self.heightBlock(tableView,indexPath);
    }
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _totalCount;
}

- (WASTipView *) emptyTipView
{
    if (!_emptyTipView) {
        _emptyTipView = [[WASTipView alloc] initWithFrame:CGRectZero];
    }
    return _emptyTipView;
}

- (WASShareTipView *) shareTipView
{
    if (!_shareTipView) {
        _shareTipView = [[WASShareTipView alloc] initWithFrame:CGRectZero];
    }
    return nil;//_shareTipView;
}

- (void) showEmtpyView:(NSString *) title Type:(eWASTipType)type
{
    self.emptyTipView.type = type;
    self.emptyTipView.title = title;
    if (!self.emptyTipView.superview) {

        [self addSubview:self.emptyTipView];
        self.emptyTipView.frame = CGRectMake(0, 100, 320, 240);

        self.userInteractionEnabled = NO;
        if (type == eWasPredictTip) {
            DEBUGLOG(@"is predict. %@", self.superview);
            self.userInteractionEnabled = YES;
            self.scrollEnabled = NO;
            self.alwaysBounceVertical = NO;
            UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [tapButton setBackgroundImage:[UIImage imageNamed:@"clear_bg"] forState:UIControlStateNormal];
            tapButton.frame = CGRectMake(140, 150, 70, 25);
            [tapButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.emptyTipView addSubview:tapButton];
        }
    }
}

- (void)buttonTapped:(id)sender
{
    DEBUGLOG(@"tapped.");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BACKTOFIRSTPAGENOTIFICATION" object:nil];
}


- (void) showShareNoErr
{
    [self.emptyTipView showShareNoErr];
    if (!self.emptyTipView.superview) {
        self.emptyTipView.frame = CGRectMake(0, -50, 320, 240);
        [self addSubview:self.emptyTipView];
        self.userInteractionEnabled = NO;
    }

}

- (void) showShareEmtpyView
{
    if (!self.shareTipView.superview) {
        self.shareTipView.frame = CGRectMake(0, -50, 320, 240);
        [self addSubview:self.shareTipView];
        self.userInteractionEnabled = YES;
    }
}

- (void) hideEmtpyView
{
    self.userInteractionEnabled = YES;
    [self.emptyTipView removeFromSuperview];
    [self.shareTipView removeFromSuperview];
}


- (void) doSendRequest:(BOOL) flag;
{
    _totalCount = 0;
    [self reloadData];
    [self tableViewDidFinishedLoading];
    [self launchRefreshing];
}

- (void) prepareToRefresh:(voidBlock)block
{
    //[self tableViewDidFinishedLoading];
    [self prepareRefreshing:block];
}

- (void) refreshData
{
    NSUInteger insertCount = [_contentArray count] - _totalCount;
    self.didReachTheEnd = ([_contentArray count] == self.reachTheEndCount);

    _totalCount = [_contentArray count];
    if (0 == _totalCount) {
        [self reloadData];
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = _totalCount - 1; i >= _totalCount - insertCount; i--) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        [array addObject:path];
    }
    if ([array count] > 0) {
        [self insertRowsAtIndexPaths:array   withRowAnimation:UITableViewRowAnimationNone];
    }

}

- (void) dealWithDataError
{
    [self tableViewDidFinishedLoading];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self tableViewDidEndDragging:scrollView];
}

- (void)tableViewDidStartRefreshing:(WASScrollViewDecorate *)tableView
{
    if (self.refreshBlock)
    {
        self.refreshBlock(nil);
    }
}

- (void)tableViewDidStartLoading:(WASScrollViewDecorate *)tableView
{
    if (self.loadMoreBlock)
    {
        self.loadMoreBlock(nil);
    }
}

@end
