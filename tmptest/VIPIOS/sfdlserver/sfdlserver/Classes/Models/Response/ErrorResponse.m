//
//  ErrorResponse.m
//  b5mei
//
//  Created by allen.wang on 4/30/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ErrorResponse.h"

@implementation ErrorResponse

@synthesize errorCode = _errorCode;
@synthesize msg  = _msg;
@synthesize exception = _exception;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_msg);
    [super dealloc];
}

- (id) initWithJsonString:(NSString *) jsonString
{
    SBJSON *json = [[[SBJSON alloc]init] autorelease];
    NSDictionary *dictionary = [json fragmentWithString:jsonString error:nil];
    self = [self initWithDictionary:dictionary];
    return self;
    
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.errorCode  = [[dictionary objectForKey:@"code"] integerValue];
        self.msg        = [dictionary objectForKey:@"message"];
        self.exception  = [dictionary objectForKey:@"exception"];
    }
    return self;
}

- (id) show
{
    [SVProgressHUD showErrorWithStatus:self.msg];
    return self;
}

@end
