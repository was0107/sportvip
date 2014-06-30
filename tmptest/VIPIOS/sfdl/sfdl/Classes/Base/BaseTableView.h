//
//  BaseTableView.h
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WASEXTableView.h"


@interface BaseTableView : WASEXTableView<UITableViewDataSource,UITableViewDelegate>
{
    int currentMaxDisplayedCell; //keep track of the maximum cell index that has been displayed (for the animation, so as we move down the table the cells are animated when they're viewed for the first time - if index is greated than currentMaxDisplayedCell - but then as you scroll back up they're not re-animated.
    int currentMaxDisplayedSection;
    
    //adjust keyboard
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
}


@property (nonatomic, retain) UIView            *startLoadingView;
@property (nonatomic, retain) UIView            *emptyView;
@property (nonatomic, assign) UIView            *parentView;
@property (nonatomic, retain) NSMutableArray    *contentArray;
@property (nonatomic, retain) NSIndexPath       *selectedIndexPath;
@property (nonatomic, assign) NSUInteger        reachTheEndCount;
@property (nonatomic, assign) NSUInteger        totalCount;

@property (nonatomic, copy) tableViewVoidBlock  cellSelectedBlock;
@property (nonatomic, copy) tableViewVoidBlock  cellDeSelectedBlock;
@property (nonatomic, copy) tableViewIntBlock   cellNumberBlock;
@property (nonatomic, copy) tableViewFloatBlock cellHeightBlock;
@property (nonatomic, copy) tableViewIdBlock    cellCreateBlock;

@property (nonatomic, copy) tableViewViewBlock  sectionHeaderBlock;
@property (nonatomic, copy) tableViewViewBlock  sectionFooterBlock;
@property (nonatomic, copy) tableViewFloatSectionBlock   sectionHeaderHeightBlock;
@property (nonatomic, copy) tableViewFloatSectionBlock   sectionFooterHeightBlock;
@property (nonatomic, copy) tableViewIntBlockEx sectionNumberBlock;

@property (nonatomic, copy) tableViewIntPathBlock   cellEditBlock;
@property (nonatomic, copy) tableViewVoidExBlock    cellEditActionBlock;

@property (nonatomic, copy  ) idBlock           refreshBlock;
@property (nonatomic, copy  ) idBlock           loadMoreBlock;

@property (nonatomic, copy)   idBlock        scrollViewDidScrollBlock;

- (void) dealWithDataError;

- (void) refreshData;

- (void) doSendRequest:(BOOL)flag;

- (void) showEmptyView:(BOOL) flag;

- (void) showStartLoadingView:(BOOL) flag;


#pragma mark ==
#pragma mark animataeMode

@property (nonatomic, assign)  BOOL     allowCellAnimate;

/**  @property cellZoomXScaleFactor
 *   @brief The X Zoom Factor
 *   How much to scale to x axis of the cell before it is animated back to normal size. 1 is normal size. >1 is bigger, <1 is smaller. Default if not set is 1.25 **/
@property (retain, nonatomic) NSNumber* cellZoomXScaleFactor;

/**  @property cellZoomYScaleFactor
 *   @brief The Y Zoom Factor
 *   How much to scale to y axis of the cell before it is animated back to normal size. 1 is normal size. >1 is bigger, <1 is smaller. Default if not set is 1.25 **/
@property (retain, nonatomic) NSNumber* cellZoomYScaleFactor;

/**  @property cellZoomXOffset
 *   @brief Specify an X offset (in pixels) for the animation's initial position
 *   Allows you to specify an X offset (in pixels) for the animation's initial position, so for example if you say -50 this will mean as well as the rest of the animation, the cell also comes in from 50 pixels to the left of the screen. If you say 100 it will come in from 100 pixels to the right of the screen. Combine it with the cellZoomYOffset to get the cell to come in diagonally (see TabThreeViewController in Demo examples). If not set, the default is 0.  **/
@property (retain, nonatomic) NSNumber* cellZoomXOffset;

/**  @property cellZoomYOffset
 *   @brief Specify a Y offset (in pixels). for the animations initial position
 *   Allows you to specify a Y offset (in pixels) for the animation's initial position, so for example if you say -50 this will mean as well as the rest of the animation, the cell also comes in from 50 pixels to the top of the screen. If you say 100 it will come in from 100 pixels to the bottom of the screen. Combine it with the cellZoomXOffset to get the cell to come in diagonally (see TabThreeViewController in Demo examples). If not set, the default is 0.  **/
@property (retain, nonatomic) NSNumber* cellZoomYOffset;

/**  @property cellZoomInitialAlpha
 *   @brief The inital Alpha value of the cell
 *   The initial alpha value of the cell when it starts animation. For example if you set this to be 0 then the cell will begin completely transparent, and will fade into view as well as zooming. Value between 0 and 1. Default if not set is 0.3 **/
@property (retain, nonatomic) NSNumber* cellZoomInitialAlpha;

/**  @property cellZoomAnimationDuration
 *   @brief The Animation Duration
 *   The duration of the animation effect, in seconds. Default if not set is 0.65 seconds **/
@property (retain, nonatomic) NSNumber* cellZoomAnimationDuration;

/*
 Resets the view counter. The animation effect doesnt repeat when you've already seen a cell once, for example if you scroll down past cell #5, then scroll back to the top and down again, the animation won't repeat as you scroll back down past #5. This is by design to make only "new" cells animate as they appear. Call this method to reset the count of which cells have been seen (e.g when you call reload on the table's data)
 */
-(void)resetViewedCells;


- (void)adjustOffsetToIdealIfNeeded;

- (void)setup;


@end
