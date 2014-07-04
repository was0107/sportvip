//
//  BaseTableView.m
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTableView.h"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

@interface BaseTableView (extend)
- (UIView*)findFirstResponderBeneathView:(UIView*)view;
- (UIEdgeInsets)contentInsetForKeyboard;
- (CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space;
- (CGRect)keyboardRect;
@end


@implementation BaseTableView
@synthesize startLoadingView    = _startLoadingView;
@synthesize emptyView           = _emptyView;
@synthesize parentView          = _parentView;
@synthesize contentArray        = _contentArray;
@synthesize selectedIndexPath   = _selectedIndexPath;
@synthesize totalCount          = _totalCount;
@synthesize reachTheEndCount    = _reachTheEndCount;
@synthesize cellSelectedBlock   = _cellSelectedBlock;
@synthesize cellDeSelectedBlock = _cellDeSelectedBlock;
@synthesize cellHeightBlock     = _cellHeightBlock;
@synthesize cellCreateBlock     = _cellCreateBlock;
@synthesize cellEditBlock       = _cellEditBlock;
@synthesize cellEditActionBlock = _cellEditActionBlock;
@synthesize refreshBlock        = _refreshBlock;
@synthesize loadMoreBlock       = _loadMoreBlock;
@synthesize cellNumberBlock     = _cellNumberBlock;
@synthesize sectionNumberBlock  = _sectionNumberBlock;
@synthesize sectionHeaderBlock  = _sectionHeaderBlock;
@synthesize sectionFooterBlock  = _sectionFooterBlock;
@synthesize sectionHeaderHeightBlock = _sectionHeaderHeightBlock;
@synthesize sectionFooterHeightBlock = _sectionFooterHeightBlock;
@synthesize scrollViewDidScrollBlock = _scrollViewDidScrollBlock;

//@synthesize allowCellAnimate     = _allowCellAnimate;
//@synthesize cellZoomXScaleFactor = _xZoomFactor;
//@synthesize cellZoomYScaleFactor = _yZoomFactor;
//@synthesize cellZoomAnimationDuration = _animationDuration;
//@synthesize cellZoomInitialAlpha = _initialAlpha;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style type:(eViewType)theType delegate:(id) theDelegate
{
    self = [super initWithFrame:frame style:style type:theType delegate:self];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 90.0f;
        self.backgroundColor = [UIColor clearColor];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
//        self.allowCellAnimate = YES;
    }
    return self;
}


- (void) setContentArray:(NSMutableArray *)contentArray
{
    if (_contentArray != contentArray) {
        
        [_contentArray release];
        _contentArray = [contentArray retain];
    }
    
    _totalCount = [_contentArray count];
    [self refreshData];
}

- (void) showStartLoadingView:(BOOL) flag
{
    if (flag) {
        if (self.startLoadingView) {
            if (self.superview) {
                [self removeFromSuperview];
                self.startLoadingView.center = self.center;
            }
            [self.parentView addSubview:self.startLoadingView];
        }
    } else {
        if (self.startLoadingView.superview) {
            [self.startLoadingView removeFromSuperview];
        }
        if (!self.startLoadingView) {
            [self.parentView addSubview:self];
        }
    }
}

- (void) showEmptyView:(BOOL) flag
{
    if (flag) {
        if (self.emptyView) {
            if (self.superview) {
                [self removeFromSuperview];
                self.emptyView.center = self.center;
            }
            [self.parentView addSubview:self.emptyView];
        }
    } else {
        if (self.emptyView.superview) {
            [self.emptyView removeFromSuperview];
        }
        if (!self.superview) {
            [self.parentView addSubview:self];
        }
    }
}

- (void) refreshData
{
    NSUInteger insertCount = [_contentArray count] - _totalCount;
    self.didReachTheEnd = ([_contentArray count] == self.reachTheEndCount);
    
    _totalCount = [_contentArray count];
    if (0 == _totalCount) {
        [self reloadData];
        [self showEmptyView:YES];
        return;
    }
    [self showEmptyView:NO];
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = _totalCount - 1; i >= _totalCount - insertCount; i--) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        [array addObject:path];
    }
    if ([array count] > 0) {
        [self insertRowsAtIndexPaths:array   withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
    TT_RELEASE_SAFELY(_startLoadingView);
    TT_RELEASE_SAFELY(_emptyView);
    TT_RELEASE_SAFELY(_contentArray);
    TT_RELEASE_SAFELY(_selectedIndexPath);
    TT_RELEASE_SAFELY(_cellSelectedBlock);
    TT_RELEASE_SAFELY(_cellDeSelectedBlock);
    TT_RELEASE_SAFELY(_cellHeightBlock);
    TT_RELEASE_SAFELY(_cellCreateBlock);
    TT_RELEASE_SAFELY(_cellNumberBlock);
    TT_RELEASE_SAFELY(_cellEditBlock);
    TT_RELEASE_SAFELY(_cellEditActionBlock);
    TT_RELEASE_SAFELY(_refreshBlock);
    TT_RELEASE_SAFELY(_loadMoreBlock);
    TT_RELEASE_SAFELY(_sectionNumberBlock);
    TT_RELEASE_SAFELY(_sectionHeaderBlock);
    TT_RELEASE_SAFELY(_sectionFooterBlock);
    TT_RELEASE_SAFELY(_sectionHeaderHeightBlock);
    TT_RELEASE_SAFELY(_sectionFooterHeightBlock);
    
    
//    TT_RELEASE_SAFELY(_xZoomFactor);
//    TT_RELEASE_SAFELY(_yZoomFactor);
//    TT_RELEASE_SAFELY(_animationDuration);
//    TT_RELEASE_SAFELY(_initialAlpha);
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super dealloc];
}

- (void) doSendRequest:(BOOL) flag;
{
    _totalCount = 0;
    if (flag) {
        [self reloadData];
    }
    [self tableViewDidFinishedLoading];
    [self launchRefreshing];
}

- (void) prepareToRefresh:(voidBlock)block
{
    [self tableViewDidFinishedLoading];
    //    [self prepareRefreshing:block];
}

- (void) dealWithDataError
{
    [self tableViewDidFinishedLoading];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tableViewDidScroll:scrollView];
    if (self.scrollViewDidScrollBlock)
    {
        self.scrollViewDidScrollBlock(scrollView);
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderHeightBlock) {
        return  (CGFloat)self.sectionHeaderHeightBlock(tableView, section);
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterHeightBlock) {
        return  (CGFloat)self.sectionFooterHeightBlock(tableView, section);
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sectionHeaderBlock) {
        return  (UIView *)self.sectionHeaderBlock(tableView, section);
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.sectionFooterBlock) {
        return  (UIView *)self.sectionFooterBlock(tableView, section);
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.sectionNumberBlock) {
        return (NSInteger)self.sectionNumberBlock(tableView);
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cellNumberBlock) {
        return (NSInteger)self.cellNumberBlock(tableView,section);
    }
    return _totalCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellCreateBlock) {
        return (UITableViewCell *)self.cellCreateBlock(tableView,indexPath);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    if (self.cellSelectedBlock) {
        self.cellSelectedBlock(tableView,indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellDeSelectedBlock) {
        self.cellDeSelectedBlock(tableView,indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellHeightBlock) {
        return (CGFloat)self.cellHeightBlock(tableView,indexPath);
    }
    return 44.0f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellEditBlock) {
        return self.cellEditBlock(tableView,indexPath);
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellEditActionBlock) {
        return self.cellEditActionBlock(tableView,editingStyle,indexPath);
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (!self.allowCellAnimate) {
//        return;
//    }
//    if ((indexPath.section == 0 && currentMaxDisplayedCell == 0) || indexPath.section > currentMaxDisplayedSection){ //first item in a new section, reset the max row count
//        currentMaxDisplayedCell = -1; //-1 because the check for currentMaxDisplayedCell has to be > rather than >= (otherwise the last cell is ALWAYS animated), so we need to set this to -1 otherwise the first cell in a section is never animated.
//    }
//    
//    if (indexPath.section >= currentMaxDisplayedSection && indexPath.row > currentMaxDisplayedCell){ //this check makes cells only animate the first time you view them (as you're scrolling down) and stops them re-animating as you scroll back up, or scroll past them for a second time.
//        
//        //now make the image view a bit bigger, so we can do a zoomout effect when it becomes visible
//        cell.contentView.alpha = self.cellZoomInitialAlpha.floatValue;
//        
//        CGAffineTransform transformScale = CGAffineTransformMakeScale(self.cellZoomXScaleFactor.floatValue, self.cellZoomYScaleFactor.floatValue);
//        CGAffineTransform transformTranslate = CGAffineTransformMakeTranslation(self.cellZoomXOffset.floatValue, self.cellZoomYOffset.floatValue);
//        
//        cell.contentView.transform = CGAffineTransformConcat(transformScale, transformTranslate);
//        
//        [self bringSubviewToFront:cell.contentView];
//        [UIView animateWithDuration:self.cellZoomAnimationDuration.floatValue animations:^{
//            cell.contentView.alpha = 1;
//            //clear the transform
//            cell.contentView.transform = CGAffineTransformIdentity;
//        } completion:nil];
//        
//        
//        currentMaxDisplayedCell = indexPath.row;
//        currentMaxDisplayedSection = indexPath.section;
//    }
//}
//
//
//
//-(void)resetViewedCells{
//    currentMaxDisplayedSection = 0;
//    currentMaxDisplayedCell = 0;
//}
//
//#pragma -mark Setters for four customisable variables
//-(void)setCellZoomXScaleFactor:(NSNumber *)xZoomFactor{
//    if (_xZoomFactor != xZoomFactor) {
//        [_xZoomFactor release];
//        _xZoomFactor = [xZoomFactor retain];
//    }
//}
//
//-(void)setCellZoomYScaleFactor:(NSNumber *)yZoomFactor{
//    if (_yZoomFactor != yZoomFactor) {
//        [_yZoomFactor release];
//        _yZoomFactor = [yZoomFactor retain];
//    }
//}
//
//-(void)setCellZoomAnimationDuration:(NSNumber *)animationDuration{
//    if (_animationDuration != animationDuration) {
//        [_animationDuration release];
//        _animationDuration = [animationDuration retain];
//    }
//}
//
//-(void)setCellZoomInitialAlpha:(NSNumber *)initialAlpha{
//    _initialAlpha = initialAlpha;
//}
//
//#pragma -mark Getters for four customisable variable. Provide default if not set.
//-(NSNumber *)cellZoomXScaleFactor{
//    if (_xZoomFactor == nil){
//        _xZoomFactor = [[NSNumber numberWithFloat:1.25] retain];
//    }
//    return _xZoomFactor;
//}
//
//-(NSNumber *)cellZoomXOffset{
//    if (_cellZoomXOffset == nil){
//        _cellZoomXOffset = [[NSNumber numberWithFloat:0] retain];
//    }
//    return _cellZoomXOffset;
//}
//
//-(NSNumber *)cellZoomYOffset{
//    if (_cellZoomYOffset == nil){
//        _cellZoomYOffset = [[NSNumber numberWithFloat:0] retain];
//    }
//    return _cellZoomYOffset;
//}
//
//-(NSNumber *)cellZoomYScaleFactor{
//    if (_yZoomFactor == nil){
//        _yZoomFactor = [[NSNumber numberWithFloat:1.25] retain];
//    }
//    return _yZoomFactor;
//}
//
//-(NSNumber *)cellZoomAnimationDuration{
//    if (_animationDuration == nil){
//        _animationDuration = [[NSNumber numberWithFloat:0.35] retain];
//    }
//    return _animationDuration;
//}
//
//-(NSNumber *)cellZoomInitialAlpha{
//    if (_initialAlpha == nil){
//        _initialAlpha = [[NSNumber numberWithFloat:0.3] retain];
//    }
//    return _initialAlpha;
//}



//adjust keyboard


- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(id)initWithFrame:(CGRect)frame {
    if ( !(self = [super initWithFrame:frame]) ) return nil;
    [self setup];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ( !(self = [super initWithCoder:aDecoder]) ) return nil;
    [self setup];
    return self;
}


-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if ( _keyboardVisible ) {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

-(void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    if ( _keyboardVisible ) {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self findFirstResponderBeneathView:self] resignFirstResponder];
    [super touchesEnded:touches withEvent:event];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardVisible = YES;
    
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if ( !firstResponder ) {
        // No child view is the first responder - nothing to do here
        return;
    }
    
    if (!_priorInsetSaved) {
        _priorInset = self.contentInset;
        _priorInsetSaved = YES;
    }
    
    // Shrink view's inset by the keyboard's height, and scroll to show the text field/view being edited
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    self.contentInset = [self contentInsetForKeyboard];
    [self setContentOffset:CGPointMake(self.contentOffset.x,
                                       [self idealOffsetForView:firstResponder withSpace:[self keyboardRect].origin.y - self.bounds.origin.y])
                  animated:YES];
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    _keyboardRect = CGRectZero;
    _keyboardVisible = NO;
    
    // Restore dimensions to prior size
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    self.contentInset = _priorInset;
    _priorInsetSaved = NO;
    [UIView commitAnimations];
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view {
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) return result;
    }
    return nil;
}

- (UIEdgeInsets)contentInsetForKeyboard {
    UIEdgeInsets newInset = self.contentInset;
    CGRect keyboardRect = [self keyboardRect];
    newInset.bottom = keyboardRect.size.height - ((keyboardRect.origin.y+keyboardRect.size.height) - (self.bounds.origin.y+self.bounds.size.height));
    return newInset;
}

-(CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space {
    
    // Convert the rect to get the view's distance from the top of the scrollView.
    CGRect rect = [view convertRect:view.bounds toView:self];
    
    // Set starting offset to that point
    CGFloat offset = rect.origin.y;
    
    
    if ( self.contentSize.height - offset < space ) {
        // Scroll to the bottom
        offset = self.contentSize.height - space;
    } else {
        if ( view.bounds.size.height < space ) {
            // Center vertically if there's room
            offset -= floor((space-view.bounds.size.height)/2.0);
        }
        if ( offset + space > self.contentSize.height ) {
            // Clamp to content size
            offset = self.contentSize.height - space;
        }
    }
    
    if (offset < 0) offset = 0;
    
    return offset;
}

-(void)adjustOffsetToIdealIfNeeded {
    
    // Only do this if the keyboard is already visible
    if ( !_keyboardVisible ) return;
    
    CGFloat visibleSpace = self.bounds.size.height - self.contentInset.top - self.contentInset.bottom;
    
    CGPoint idealOffset = CGPointMake(0, [self idealOffsetForView:[self findFirstResponderBeneathView:self] withSpace:visibleSpace]);
    
    [self setContentOffset:idealOffset animated:YES];
}

- (CGRect)keyboardRect {
    CGRect keyboardRect = [self convertRect:_keyboardRect fromView:nil];
    if ( keyboardRect.origin.y == 0 ) {
        CGRect screenBounds = [self convertRect:[UIScreen mainScreen].bounds fromView:nil];
        keyboardRect.origin = CGPointMake(0, screenBounds.size.height - keyboardRect.size.height);
    }
    return keyboardRect;
}


@end
