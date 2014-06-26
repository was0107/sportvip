//
//  PaggingResponse.m
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "PaggingResponse.h"


@implementation GymnasiumsResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[GymnasiumItem alloc] initWithDictionary:dictionary] autorelease];
}

@end


@implementation CoachsResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[CoacheItem alloc] initWithDictionary:dictionary] autorelease];
}

@end

@implementation EventsResponse

- (id) translateFrom:(const NSDictionary *) dictionary
{
    NSArray *array = (NSArray *) dictionary;
    self.result = [NSMutableArray array];
    for (int i = 0 ; i < [array count]; i++) {
        EventTagItem *item = [[[EventTagItem alloc] initWithDictionary:[array objectAtIndex:i]] autorelease];
        [self.result addObject:item];
    }
    self.count = [self.result count];
    
    return self;
}


@end

@implementation CitysResponse


- (id) translateFrom:(const NSDictionary *) dictionary
{
    NSArray *array = (NSArray *) dictionary;
    self.result = [NSMutableArray array];
    for (int i = 0 ; i < [array count]; i++) {
            CityItem *item = [[[CityItem alloc] initWithDictionary:[array objectAtIndex:i]] autorelease];
        [self.result addObject:item];
    }
    self.count = [self.result count];

    return self;
}


- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[CityItem alloc] initWithDictionary:dictionary] autorelease];
}
@end
