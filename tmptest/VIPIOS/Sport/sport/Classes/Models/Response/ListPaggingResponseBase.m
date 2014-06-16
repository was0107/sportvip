//
//  ListPaggingResponseBase.m
//  b5mappsejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListPaggingResponseBase.h"

@implementation ListPaggingResponseBase
@synthesize result      = _result;
@synthesize count       = _count;
@synthesize arrayCount  = _arrayCount;

- (id) initWithDictionary:(NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.lastPage = NO;
        self.result = [self getResultFrom:dictionary];
        self.count  = [[dictionary objectForKey:@"totalElements"] integerValue];
        self.lastPage = [[dictionary objectForKey:@"lastPage"] boolValue];
        self.arrayCount = [self.result count];
        [self translateFrom:dictionary];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_result);
    [super dealloc];
}


- (NSMutableArray *) getResultFrom:(NSDictionary *) dictionary
{
//    DEBUGLOG(@"dictionary = %@",dictionary);
    NSMutableArray *array = [dictionary objectForKey:[self resultKey]];
    NSMutableArray *arrayResult = [NSMutableArray array];
    @autoreleasepool {
        for ( int i = 0 , total = [array count]; i < total; ++i) {
            NSDictionary *dictionary = (NSDictionary *) [array objectAtIndex:i];
            if ([self canDoTransLate:dictionary]) {
                id valied = [self translateItemFrom:dictionary];
                ValiedCheck(valied);
                [self doTransLateAfter];
                [arrayResult addObject:valied];
            }
        }
    }
    return arrayResult;
}

- (void) appendPaggingFromJsonString:(NSString *) jsonString
{
    SBJSON *json = [[[SBJSON alloc] init] autorelease];
    NSDictionary *dictionary = [json fragmentWithString:jsonString error:nil];
    [self.result addObjectsFromArray:[self getResultFrom:dictionary]];
    self.lastPage = [[dictionary objectForKey:@"lastPage"] boolValue];
    self.arrayCount = [self.result count];
}

- (BOOL) reachTheEnd
{
//    if (self.result) {
//        return self.arrayCount >= self.count;
//    }
    return self.lastPage;
}

- (BOOL) isEmpty
{
    return self.arrayCount == 0;
}


- (NSString *) resultKey
{
    return @"content";
}


- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return nil;
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    return nil;
}


- (BOOL) canDoTransLate:(NSDictionary *)dictionary
{
    return YES;
}

- (id) doTransLateAfter
{
    return self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"self = %@ ;self.resultKey= %@ ; self.result = %@", self, self.resultKey, self.result];
}

- (NSString *) debugDescription
{
    return self.description;
}


- (id) at:(NSInteger) index
{
    return [self.result objectAtIndex:index];
}

@end
