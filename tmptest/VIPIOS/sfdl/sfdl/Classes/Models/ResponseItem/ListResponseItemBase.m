//
//  ListResponseItemBase.m
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import "ListResponseItemBase.h"

@implementation ListResponseItemBase

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSString *)stringObjectFrom:(const NSDictionary *)dictionary withKey:(NSString *)key
{
    NSString * stringValue = [dictionary objectForKey:key];
    if (stringValue == (NSString *)[NSNull null]) {
        stringValue = kEmptyString;
        return stringValue;
    }
    return stringValue;
}

-(NSInteger)integerValueFrom:(const NSDictionary *)dictionary withKey:(NSString *)key
{
    NSNumber *num = [dictionary objectForKey:key];
    NSInteger value;
    if (num == (NSNumber *)[NSNull null]) {
        value = 0;
    }
    else
    {
        value = [num integerValue];
    }
    return value;
}

-(CGFloat)floatValueFrom:(const NSDictionary *)dictionary withKey:(NSString *)key
{
    NSNumber *num = [dictionary objectForKey:key];
    CGFloat value;
    if (num == (NSNumber *)[NSNull null]) {
        value = 0.0f;
    }
    else
    {
        value = [num floatValue];
    }
    return value;
}

-(BOOL)boolValueFrom:(const NSDictionary *)dictionary withKey:(NSString *)key
{
    NSNumber *num = [dictionary objectForKey:key];
    BOOL value;
    if (num == (NSNumber *)[NSNull null]) {
        value = NO;
    }
    else
    {
        value = [num boolValue];
    }
    return value;
}

-(NSDate *)dateObjectFrom:(const NSDictionary *)dictionary withKey:(NSString *)key
{
    NSNumber *num = [dictionary objectForKey:key];
    NSDate * value;
    if (num == (NSNumber *)[NSNull null]) {
        value = [NSDate date];
    }
    else
    {
        value = [NSDate dateWithTimeIntervalSince1970:[num doubleValue] * 0.0010];
    }
    return value;
}
@end
