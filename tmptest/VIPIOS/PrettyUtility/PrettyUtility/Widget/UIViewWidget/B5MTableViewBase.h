//
//  B5MTableViewBase.h
//  PrettyUtility
//
//  Created by micker on 12/26/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import "WASEXTableView.h"
#import "WASTipView.h"
#import "WASShareTipView.h"

@interface B5MTableViewBase : WASEXTableView<UITableViewDataSource,UITableViewDelegate,WASScrollViewDecorateDelegate>
{
    NSMutableArray          *_contentArray;
}

@property (nonatomic, retain) NSMutableArray    *contentArray;
@property (nonatomic, assign) NSUInteger        reachTheEndCount;
@property (nonatomic, retain) WASTipView        *emptyTipView;
@property (nonatomic, retain) WASShareTipView   *shareTipView;
@property (nonatomic, copy  ) idBlock           refreshBlock;
@property (nonatomic, copy  ) idBlock           loadMoreBlock;
@property (nonatomic, copy  ) tableViewCellBlock cellBlock;
@property (nonatomic, copy  ) tableViewCellHeight heightBlock;
@property (nonatomic, copy  ) tableViewCellSelectedBlock selectedBlock;
@property (nonatomic, assign) NSUInteger        totalCount;
@property (nonatomic, retain) NSIndexPath       *selectedIndexPath;

- (void) setupContentView;

- (void) dealWithDataError;

- (void) refreshData;

- (void) doSendRequest:(BOOL)flag;

- (void) showEmtpyView:(NSString *) title Type:(eWASTipType)type;

- (void) showShareNoErr;

- (void) showShareEmtpyView;

- (void) hideEmtpyView;

- (void) prepareToRefresh:(voidBlock)block;

- (void) didSetContentArray;

@end
