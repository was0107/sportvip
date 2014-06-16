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
