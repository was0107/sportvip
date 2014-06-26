//
//  PaggingRequest.m
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "PaggingRequest.h"

@implementation PaggingRequest

- (id) init
{
    self = [super init];
    if (self) {
        self.longitude = 0.0f;
        self.longitude = 0.0f;
        self.age = self.distance = self.eventId = @"";
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_age);
    TT_RELEASE_SAFELY(_distance);
    TT_RELEASE_SAFELY(_eventId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"lon"];
    [array addObject:@"lat"];
    [array addObject:@"age"];
    [array addObject:@"distance"];
    [array addObject:@"eventId"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:[NSNumber numberWithDouble:self.longitude]];
    [array addObject:[NSNumber numberWithDouble:self.latitude]];
    [array addObject:self.age];
    [array addObject:self.distance];
    [array addObject:self.eventId];
    return array;
}

@end


@implementation GymnasiumsRequest

- (NSString *) methodString
{
    return @"sport/nearbyGymnasiums";
}

@end


@implementation CoachesRequest

- (NSString *) methodString
{
    return @"sport/nearbyCoaches";
}

@end


@implementation DetailRequest
- (void) dealloc
{
    TT_RELEASE_SAFELY(_itemId);
    [super dealloc];
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.itemId];
    return array;
}

@end

@implementation GymnasiumDetailRequest

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"gymnasiumId"];
    return array;
}

- (NSString *) methodString
{
    return @"sport/gymnasium";
}
@end


@implementation CoachDetailRequest

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"coachId"];
    return array;
}

- (NSString *) methodString
{
    return @"sport/coach";
}
@end


@implementation EventsRequest

- (NSString *) methodString
{
    return @"sport/events";
}

@end


@implementation CitysRequest

- (NSString *) methodString
{
    return @"sport/cities";
}

@end

@implementation CheckClassesRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"userId"];
    [array addObject:@"type"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.userId];
    [array addObject:@"VIEW"];
    return array;
}


- (NSString *) methodString
{
    return @"sport/findcoursehistory";
}

@end


@implementation CheckCoachesRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"userId"];
    [array addObject:@"type"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.userId];
    [array addObject:@"CONTACT"];
    return array;
}


- (NSString *) methodString
{
    return @"sport/findcoursehistory";
}

@end




