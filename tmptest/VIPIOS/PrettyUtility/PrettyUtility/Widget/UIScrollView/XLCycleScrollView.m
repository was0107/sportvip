//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"

static const CGFloat kTimerInteveral = 6.0f;

@interface XLCycleScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) NSMutableArray *curViews;
@property (nonatomic, strong) NSTimer *timer;

@property(nonatomic, assign)CGFloat userContentOffsetX;;
@property(nonatomic, assign)NSInteger scrollPath;
@property(nonatomic, assign)BOOL userScrollAction;

@end

@implementation XLCycleScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [_scrollView setDecelerationRate:0.001];
        [_scrollView setCanCancelContentTouches:NO];
        [self addSubview:_scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 20;
        rect.size.height = 20;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = YES;
        _pageControl.pageIndicatorTintColor = kLightGrayColor;
        _pageControl.currentPageIndicatorTintColor = [UIColor getColor:@"1EA897"];
        [self addSubview:_pageControl];
        
        _curPage = 0;
    }
    return self;
}

- (void)startCycle
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kTimerInteveral target:self selector:@selector(happenTimer:) userInfo:nil repeats:YES];
    }
    
    _totalPages = [_dataSource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kTimerInteveral]];
}

- (void)stopCycle
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)reloadData
{
    _totalPages = [_dataSource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    _pageControl.currentPage = _curPage;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 3; i++) {
        UIView *view = [_curViews objectAtIndex:i];
        view.frame = CGRectOffset(view.frame, view.width * i, 0);
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [view addGestureRecognizer:singleTap];
        [_scrollView addSubview:view];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre  = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[_dataSource pageAtIndex:pre]];
    [_curViews addObject:[_dataSource pageAtIndex:page]];
    [_curViews addObject:[_dataSource pageAtIndex:last]];
}

- (int)validPageValue:(NSInteger)value
{
    if( value < 0 ) value = _totalPages - 1;
    if( value >= _totalPages) value = 0;
    
    return value;
}

#pragma mark - timer
- (void)happenTimer:(NSTimer *)timer
{
    if (_totalPages <= 1) {
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [_scrollView setContentOffset:CGPointMake(_scrollView.width*2, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            _curPage = [self validPageValue:_curPage + 1];
            [self loadData];
        }
    }];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _userScrollAction = YES;
    _userContentOffsetX = scrollView.contentOffset.x;
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat  offsetX = scrollView.contentOffset.x;
    if (_userContentOffsetX < offsetX && offsetX > 1.5*scrollView.width)
    {
        _scrollPath = 1;
    }
    else if(_userContentOffsetX > offsetX && offsetX < 0.5*scrollView.width)
    {
        _scrollPath = 2;
    }
    else
    {
        _scrollPath = 0;
    }
    
    if (offsetX <= 0 && _userScrollAction) {
        _curPage = [self validPageValue:_curPage - 1];
        [self loadData];
    }
    if (offsetX >= 2*scrollView.width && _userScrollAction) {
        _curPage = [self validPageValue:_curPage + 1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    if (1 == _scrollPath) {
        _curPage = [self validPageValue:_curPage + 1];
        [self loadData];
    }
    else if(2 == _scrollPath)
    {
        _curPage = [self validPageValue:_curPage - 1];
        [self loadData];
    }
    _userScrollAction = NO;
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kTimerInteveral]];
}

@end

