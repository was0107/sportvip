//
//  PaggingItem.m
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "PaggingItem.h"


@implementation CourseItem
- (void)dealloc{
    
    TT_RELEASE_SAFELY(_coachId);
    TT_RELEASE_SAFELY(_advantage);
    TT_RELEASE_SAFELY(_description);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_schoolTime);
    TT_RELEASE_SAFELY(_priceString);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.coachId     = [self stringObjectFrom:dictionary withKey:@"coachId"];
        self.advantage   = [self stringObjectFrom:dictionary withKey:@"advantage"];
        self.description = [self stringObjectFrom:dictionary withKey:@"description"];
        self.name        = [self stringObjectFrom:dictionary withKey:@"name"];
        self.schoolTime  = [self stringObjectFrom:dictionary withKey:@"schoolTime"];
        self.coachId     = [self stringObjectFrom:dictionary withKey:@"coachId"];
        float price      = [self floatValueFrom:dictionary withKey:@"price"];
        self.priceString = [NSString stringWithFormat:@"%.0f",price];

    }
    return self;
}
@end


@implementation PaggingItem
- (void)dealloc{
    
    TT_RELEASE_SAFELY(_itemId);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.itemId = [self stringObjectFrom:dictionary withKey:@"id"];
    }
    return self;
}
@end


@implementation EventTagItem

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_icon);
    TT_RELEASE_SAFELY(_name);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.icon = [self stringObjectFrom:dictionary withKey:@"icon"];
        self.name = [self stringObjectFrom:dictionary withKey:@"name"];
    }
    return self;
}

@end

@implementation GymnasiumItem

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_priceString);
    TT_RELEASE_SAFELY(_distanceString);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_pictures);
    TT_RELEASE_SAFELY(_tags);
    TT_RELEASE_SAFELY(_events);

    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.address  = [self stringObjectFrom:dictionary withKey:@"address"];
        self.name     = [self stringObjectFrom:dictionary withKey:@"name"];
        self.distance = [self floatValueFrom:dictionary withKey:@"distance"];
        self.maxPrice = [self floatValueFrom:dictionary withKey:@"maxPrice"];
        self.minPrice = [self floatValueFrom:dictionary withKey:@"minPirce"];
        
        if (self.minPrice < 1) {
            self.priceString = [NSString stringWithFormat:@"%.0f",self.maxPrice];
        } else {
            self.priceString = [NSString stringWithFormat:@"%.0f-%.0f",self.minPrice,self.maxPrice];
        }
        
        self.distanceString = [NSString stringWithFormat:@"%.0f",self.distance];
        
        NSMutableArray *array = [dictionary objectForKey:@"tags"];
        NSMutableArray *arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                EventTagItem *item = [[[EventTagItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            
            self.tags = arrayResult;
        }
        
        array = [dictionary objectForKey:@"events"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                EventTagItem *item = [[[EventTagItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            
            self.events = arrayResult;
        }
        
        array = [dictionary objectForKey:@"pics"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                [arrayResult addObject:[array objectAtIndex:i]];
            }
            self.pictures = arrayResult;
        }

    }
    return self;
}
@end



@implementation CoacheItem

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_avatar);
    TT_RELEASE_SAFELY(_certificate);
    TT_RELEASE_SAFELY(_priceString);
    TT_RELEASE_SAFELY(_distanceString);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_phones);
    TT_RELEASE_SAFELY(_tags);
    TT_RELEASE_SAFELY(_hornors);
    
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.address                = [self stringObjectFrom:dictionary withKey:@"address"];
        self.name                   = [self stringObjectFrom:dictionary withKey:@"name"];
        self.distance               = [self floatValueFrom:dictionary withKey:@"distance"];
        self.minPrice               = [self floatValueFrom:dictionary withKey:@"minPirce"];
        self.avatar                 = [self stringObjectFrom:dictionary withKey:@"avatar"];
        self.certificate            = [self stringObjectFrom:dictionary withKey:@"certificate"];
        self.zan                    = (int)[self integerValueFrom:dictionary withKey:@"zan"];
        self.age                    = (int)[self integerValueFrom:dictionary withKey:@"age"];

        self.priceString            = [NSString stringWithFormat:@"%.0f",self.minPrice];
        self.distanceString         = [NSString stringWithFormat:@"%.0f",self.distance];

        NSDictionary *location      = [dictionary objectForKey:@"location"];
        self.longtitude             = [self floatValueFrom:location withKey:@"x"];
        self.lantitude              = [self floatValueFrom:location withKey:@"y"];

        NSMutableArray *array       = [dictionary objectForKey:@"tags"];
        NSMutableArray *arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                EventTagItem *item           = [[[EventTagItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            
            self.tags = arrayResult;
        }
        
        array = [dictionary objectForKey:@"phones"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                EventTagItem *item           = [[[EventTagItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            
            self.phones = arrayResult;
        }
        
        array = [dictionary objectForKey:@"honors"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                [arrayResult addObject:[array objectAtIndex:i]];
            }
            self.hornors = arrayResult;
        }
        
        
        self.introduction = [self stringObjectFrom:dictionary withKey:@"introduction"];
        self.resume = [self stringObjectFrom:dictionary withKey:@"resume"];
        
        array = [dictionary objectForKey:@"courses"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                CourseItem *item             = [[[CourseItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            
            self.courses = arrayResult;
        }
    }
    return self;
}
@end

