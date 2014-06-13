//
//  YoukuResponseItem.h
//  b5mei
//
//  Created by allen.wang on 4/25/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListResponseItemBase.h"

@interface YoukuResponseItem : ListResponseItemBase

@property (nonatomic, copy)   NSString        *url;                     // *(String)：操作中文信息描述
@property (nonatomic, assign) NSInteger       seconds,size;             // *(String)：操作中文信息描述
@end
