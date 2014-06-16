//
//  PaggingItem.m
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "PaggingItem.h"

@implementation PaggingItem

@end


@implementation EventTagItem

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_itemId);
    TT_RELEASE_SAFELY(_icon);
    TT_RELEASE_SAFELY(_name);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.itemId = [self stringObjectFrom:dictionary withKey:@"id"];
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
    self = [super init];
    if (self) {
        self.address = [self stringObjectFrom:dictionary withKey:@"address"];
        self.name = [self stringObjectFrom:dictionary withKey:@"name"];
        self.distance = [self floatValueFrom:dictionary withKey:@"distance"];
        self.maxPrice = [self floatValueFrom:dictionary withKey:@"maxPrice"];
        self.minPirce = [self floatValueFrom:dictionary withKey:@"minPirce"];
        
        if (self.minPirce < 1) {
            self.priceString = [NSString stringWithFormat:@"%d",self.maxPrice];
        } else {
            self.priceString = [NSString stringWithFormat:@"%d-%d",self.minPirce,self.maxPrice];
        }
        
        self.distanceString = [NSString stringWithFormat:@"%d",self.distance]
        
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



@interface CoacheItem : ListResponseItemBase

@property (nonatomic, copy) NSString *address,*name,*avatar,*certificate, *priceString, *distanceString;
@property (nonatomic, retain) NSMutableArray *phones, *tags, *honors;
@property (nonatomic, assign) float distance, minPrice *lantitude,*longtitude;
@property (nonatomic, assign) int zan, age;
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
    self = [super init];
    if (self) {
        self.address = [self stringObjectFrom:dictionary withKey:@"address"];
        self.name = [self stringObjectFrom:dictionary withKey:@"name"];
        self.distance = [self floatValueFrom:dictionary withKey:@"distance"];
        self.minPirce = [self floatValueFrom:dictionary withKey:@"minPirce"];
        self.avatar = [self floatValueFrom:dictionary withKey:@"avatar"];
        self.certificate = [self floatValueFrom:dictionary withKey:@"certificate"];
        self.zan = [[self integerValueFrom:dictionary withKey:@"zan"] intValue];
        self.age = [[self integerValueFrom:dictionary withKey:@"age"] intValue];

        self.priceString = [NSString stringWithFormat:@"%d",self.minPirce];
        self.distanceString = [NSString stringWithFormat:@"%d",self.distance]
        
        NSDictionary *location = [dictionary objectForKey:@"location"];
        self.longtitude = [self floatValueFrom:location withKey:@"x"];
        self.lantitude = [self floatValueFrom:location withKey:@"y"];

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
        
        array = [dictionary objectForKey:@"phones"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                EventTagItem *item = [[[EventTagItem alloc] initWithDictionary:dictionaryItem] autorelease];
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
            self.honors = arrayResult;
        }
            }
    return self;
}
@end

