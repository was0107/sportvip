//
//  ListResponseBase.m
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import "ListResponseBase.h"

@implementation ListResponseBase
@synthesize succ = _succ;
@synthesize msg  = _msg;
@synthesize token = _token;

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
        self.succ       = [[dictionary objectForKey:@"code"] integerValue];
        self.msg        = [dictionary objectForKey:@"message"];
        self.token      = [dictionary objectForKey:@"token"];
        self.exception  = [dictionary objectForKey:@"exception"];
    }
    return self;
}

@end


@implementation ListResultResponseBase


- (void) dealloc
{
    TT_RELEASE_SAFELY(_resultDic);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.resultDic  = [dictionary objectForKey:@"result"];
        [self doTranslateResult:self.resultDic];
    }
    return self;
}

- (void) doTranslateResult:(const NSDictionary *) dictionary
{
    
}


@end