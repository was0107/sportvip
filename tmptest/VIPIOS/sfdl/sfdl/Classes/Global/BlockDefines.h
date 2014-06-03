//
//  BlockDefines.h
//  GoDate
//
//  Created by lei zhang on 13-8-3.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#ifndef BlockDefines_h
#define BlockDefines_h

//tableView Block
typedef void        (^tableViewVoidBlock)( UITableView *tableView, NSIndexPath *indexPath);
typedef void        (^tableViewVoidExBlock)( UITableView *tableView, NSInteger editingStyle, NSIndexPath *indexPath);
typedef id          (^tableViewIdBlock)( UITableView *tableView, NSIndexPath *indexPath);
typedef UIView*     (^tableViewViewBlock)( UITableView *tableView, NSInteger section);
typedef NSInteger   (^tableViewIntBlock)( UITableView *tableView, NSInteger section);
typedef NSInteger   (^tableViewIntPathBlock)( UITableView *tableView, NSIndexPath *indexPath);
typedef NSInteger   (^tableViewIntBlockEx)( UITableView *tableView);
typedef CGFloat     (^tableViewFloatBlock)( UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat     (^tableViewFloatSectionBlock)( UITableView *tableView, NSInteger section);

//pickerView block
typedef id          (^pickeCellBlock)(UIPickerView *pickerView, NSInteger row, NSInteger component);
typedef id          (^pickeCellViewBlock)(UIPickerView *pickerView, NSInteger row, NSInteger component,UIView *reuseView);
typedef NSInteger   (^PickerComponentBlock)(id content);
typedef NSInteger   (^PickerNumberBlock)(id content, NSInteger positon);
typedef CGFloat     (^PickerWidthBlock)(id content, NSInteger positon);
typedef void        (^PickerselectBlock)(id content, NSInteger row, NSInteger positon);

#endif



