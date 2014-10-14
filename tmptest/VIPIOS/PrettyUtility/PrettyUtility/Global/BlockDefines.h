//
//  BlockDefines.h
//  PrettyUtility
//
//  Created by micker on 12/26/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#ifndef PrettyUtility_BlockDefines_h
#define PrettyUtility_BlockDefines_h

typedef void (^voidBlock)();
typedef void (^backBlock)();
typedef void (^idBlock)( id content);
typedef void (^idBOOLBlock)( id content, BOOL direction);
typedef void (^idRangeBlock)( id content1, id content2);
typedef void (^idRange3Block)( id content1, id content2, id content3);
typedef void (^boolBlock)(BOOL finised);
typedef void (^intBlock)(int flag);
typedef void (^refreshContent)(NSString *name);
typedef void (^intIdBlock)(int type , id content);
typedef void (^intBoolBlock)(int type , BOOL flag);



typedef void (^tableViewCellSelectedBlock)( UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^tableViewCellHeight)( UITableView *tableView, NSIndexPath *indexPath);
typedef id (^tableViewCellBlock)( UITableView *tableView, NSIndexPath *indexPath);


#endif
