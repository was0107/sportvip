//
//  YoukuResponse.h
//  b5mei
//
//  Created by allen.wang on 4/25/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListResponseBase.h"
#import "YoukuResponseItem.h"

@interface YoukuResponse : ListResponseBase
@property (nonatomic, copy)   NSString        *title;                     // *(String)：操作中文信息描述
@property (nonatomic, copy)   NSString        *img;                     // *(String)：操作中文信息描述
@property (nonatomic, copy)   NSString        *img_hd;                     // *(String)：操作中文信息描述
@property (nonatomic, copy)   NSString        *format;                     // *(String)：操作中文信息描述
@property (nonatomic, copy)   NSString        *desc;                     // *(String)：操作中文信息描述
@property (nonatomic, copy)   NSString        *videoid;                     // *(String)：操作中文信息描述
@property (nonatomic, retain) NSMutableArray  *result;


- (id) initWithJsonStringEx:(NSString *)jsonString;

- (NSString *) URLString;

@end
