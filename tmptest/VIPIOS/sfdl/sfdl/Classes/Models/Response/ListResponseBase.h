//
//  ListResponseBase.h
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "ErrorResponse.h"



@interface ListResponseBase : NSObject

@property (nonatomic, assign) NSInteger       succ;                     // *(Int) ：操作状态，1表示成功，0表示失败
@property (nonatomic, copy)   NSString        *msg;                     // *(String)：操作中文信息描述
@property (nonatomic, copy)   NSString        *token;
@property (nonatomic, copy)   NSString        *exception;

- (id) initWithJsonString:(NSString *) jsonString;

- (id) initWithDictionary:(const NSDictionary *) dictionary;

@end


@interface ListResultResponseBase : ListResponseBase
@property (nonatomic, retain) NSDictionary *resultDic;

- (void) doTranslateResult:(const NSDictionary *) dictionary;

@end