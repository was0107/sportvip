//
//  ListPaggingRequestBase.h
//  b5mappsejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"

@interface ListPaggingRequestBase : ListRequestBase
@property (nonatomic, assign) NSUInteger      pageno;                //(Int)：页码
@property (nonatomic, assign) NSUInteger      pagesize;              //(Int)：每页最大数据量

- (id) nextPage;

- (id) firstPage;

- (BOOL) isFristPage;
@end



@interface ListPaggingRequestWithUserIDBase : ListPaggingRequestBase
@property (nonatomic, copy)  NSString *userID;
@property (nonatomic, copy)  NSString *token;
@end