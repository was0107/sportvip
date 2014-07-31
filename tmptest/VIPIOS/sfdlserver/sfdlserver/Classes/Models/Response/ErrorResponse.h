//
//  ErrorResponse.h
//  b5mei
//
//  Created by allen.wang on 4/30/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface ErrorResponse : NSObject

@property (nonatomic, assign) NSInteger       errorCode;                // *(Int) ：100
@property (nonatomic, copy)   NSString        *msg;                     // *(String)：您输入的账户不存在
@property (nonatomic, copy)   NSString        *exception;               // * B5MeiRuntimeException

- (id) initWithJsonString:(NSString *) jsonString;

- (id) initWithDictionary:(const NSDictionary *) dictionary;

- (id) show;

@end
