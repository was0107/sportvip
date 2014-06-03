//
//  FeedBackRequest.h
//  GoDate
//
//  Created by lei zhang on 13-8-8.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#import "ListRequestBase.h"

@interface FeedBackRequest : ListRequestWithUserIDBase

/**
 * type*(String)：类型
 * description*(String):用户建议
 */
@property (nonatomic, copy)     NSString    *type;
@property (nonatomic, copy)     NSString    *description;

@end
