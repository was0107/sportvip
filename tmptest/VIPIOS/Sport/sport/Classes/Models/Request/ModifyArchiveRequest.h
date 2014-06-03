//
//  ModifyArchiveRequest.h
//  GoDate
//
//  Created by allen.wang on 8/14/13.
//  Copyright (c) 2013 www.b5m.com. All rights reserved.
//

#import "ListRequestBase.h"

@interface ModifyArchiveRequest : ListRequestWithUserIDBase
@property (nonatomic, retain) NSMutableArray *keys,*values;

@end
