//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+extend.h"

@class XLCycleScrollView;

@protocol XLCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end

@protocol XLCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@interface XLCycleScrollView : UIView

@property (nonatomic, weak) id<XLCycleScrollViewDatasource> dataSource;
@property (nonatomic, weak) id<XLCycleScrollViewDelegate> delegate;

- (void)startCycle;
- (void)stopCycle;
- (void)reloadData;

@end
