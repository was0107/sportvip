//
//  BaseSectionTableViewController.h
//  sport
//
//  Created by allen.wang on 5/21/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIView+extend.h"

@interface BaseSectionTableViewController : BaseTableViewController
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, assign) NSUInteger    currentIndex;

- (void) didSelected:(NSUInteger ) index;

@end
