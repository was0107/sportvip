//
//  BaseGroupTableView.h
//  GoDate
//
//  Created by lei zhang on 13-8-12.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseGroupTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *tableTitleArray;

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
@end
