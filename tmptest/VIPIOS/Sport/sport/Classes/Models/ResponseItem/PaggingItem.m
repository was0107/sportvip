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
    TT_RELEASE_SAFELY(_coachName)
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
        self.coachName     = [self stringObjectFrom:dictionary withKey:@"coachName"];
        float price      = [self floatValueFrom:dictionary withKey:@"price"];
        self.priceString = [NSString stringWithFormat:@"￥%.0f",price];
//        if ([self.name length] == 0) {
//            self.name = @"篮球课程";
//        }

    }
    return self;
}
@end
@implementation TelItem

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_avatar);
    TT_RELEASE_SAFELY(_tel);
    [super dealloc];
}


+(TelItem *) hotItem
{
    TelItem *item = [[[TelItem alloc] init] autorelease];
    item.name = @"";
    item.avatar = kImageDefault;
    item.tel = @"13600000000";
    return item;
}

@end

@implementation HornorItem

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_year);
    TT_RELEASE_SAFELY(_honor);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.year = [self stringObjectFrom:dictionary withKey:@"year"];
        self.honor = [self stringObjectFrom:dictionary withKey:@"honor"];
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
            self.priceString = [NSString stringWithFormat:@"￥%.0f",self.maxPrice];
        } else {
            self.priceString = [NSString stringWithFormat:@"￥%.0f-%.0f",self.minPrice,self.maxPrice];
        }
        if (self.distance < 1000) {
            self.distanceString = [NSString stringWithFormat:@"%.0fm",self.distance];
        }
        else if (self.distance < 100000) {
            self.distanceString = [NSString stringWithFormat:@"%.1fkm",self.distance/1000];
        }
        else if (self.distance < 1000000) {
            self.distanceString = [NSString stringWithFormat:@"%.0fkm",self.distance/1000];
        } else {
            self.distanceString = [NSString stringWithFormat:@"很远"];
        }
        
        NSDictionary *location      = [dictionary objectForKey:@"location"];
        self.longtitude             = [self floatValueFrom:location withKey:@"x"];
        self.lantitude              = [self floatValueFrom:location withKey:@"y"];

        
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


@implementation GymnasiumDetailResponse

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_resume);
    TT_RELEASE_SAFELY(_descriptionString);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_introduction);
    TT_RELEASE_SAFELY(_pictures);
    TT_RELEASE_SAFELY(_tags);
    TT_RELEASE_SAFELY(_events);
    TT_RELEASE_SAFELY(_phones);
    TT_RELEASE_SAFELY(_hornors);
    TT_RELEASE_SAFELY(_coaches);
    TT_RELEASE_SAFELY(_courses);
    
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        
        self.itemId            = [dictionary objectForKey:@"id"];
        self.address           = [dictionary objectForKey:@"address"];
        self.name              = [dictionary objectForKey:@"name"];
        self.descriptionString = [dictionary objectForKey:@"description"];
        self.resume            = [dictionary objectForKey:@"resume"];
        
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
        
        
//        array = [dictionary objectForKey:@"phones"];
//        arrayResult = [NSMutableArray array];
//        @autoreleasepool {
//            for ( int i = 0 , total = [array count]; i < total; ++i) {
//                [arrayResult addObject:[array objectAtIndex:i]];
//            }
//            self.phones = arrayResult;
//        }
//        
        array = [dictionary objectForKey:@"hornors"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                HornorItem *item           = [[[HornorItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            self.hornors = arrayResult;
        }
        
        self.phones = [NSMutableArray array];
        array = [dictionary objectForKey:@"coaches"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                CoacheItem *item = [[[CoacheItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
                
                [self.phones addObjectsFromArray:item.phones];
            }
            self.coaches = arrayResult;
            
            
        }
        
        array = [dictionary objectForKey:@"courses"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                CourseItem *item = [[[CourseItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            self.courses = arrayResult;
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
       
        self.priceString            = [NSString stringWithFormat:@"￥%.0f",self.minPrice];
        self.distanceString         = [NSString stringWithFormat:@"%.0f",self.distance];
        if (self.distance < 1000) {
            self.distanceString = [NSString stringWithFormat:@"%.0fm",self.distance];
        }
        else if (self.distance < 100000) {
            self.distanceString = [NSString stringWithFormat:@"%.1fkm",self.distance/1000];
        }
        else if (self.distance < 1000000) {
            self.distanceString = [NSString stringWithFormat:@"%.0fkm",self.distance/1000];
        } else {
            self.distanceString = [NSString stringWithFormat:@"很远"];
        }

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
        
        array = [dictionary objectForKey:@"phoneNum"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                TelItem *item = [[[TelItem alloc] init] autorelease];
                item.name     = self.name;
                item.avatar   = self.avatar;
                item.tel      = [array objectAtIndex:i];
                [arrayResult addObject:item];
            }
            
            self.phones = arrayResult;
        }
        
        array = [dictionary objectForKey:@"honors"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                HornorItem *item           = [[[HornorItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
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


@implementation CoacheDetailResponse

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_itemId);
    TT_RELEASE_SAFELY(_resume);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_introduction);
    TT_RELEASE_SAFELY(_avatar);
    TT_RELEASE_SAFELY(_tags);
    TT_RELEASE_SAFELY(_phones);
    TT_RELEASE_SAFELY(_hornors);
    TT_RELEASE_SAFELY(_courses);
    
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        
        self.itemId       = [dictionary objectForKey:@"id"];
        self.age          = [[dictionary objectForKey:@"age"] intValue];
        self.name         = [dictionary objectForKey:@"name"];
        self.avatar       = [dictionary objectForKey:@"avatar"];
        self.resume       = [dictionary objectForKey:@"resume"];
        self.introduction = [dictionary objectForKey:@"introduction"];
        
        
        NSDictionary *location      = [dictionary objectForKey:@"location"];
        self.longtitude             = [[location objectForKey:@"x"] floatValue];
        self.lantitude              = [[location objectForKey:@"y"] floatValue];
        
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
        
        array = [dictionary objectForKey:@"phoneNum"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                TelItem *hornorItem = [[[TelItem alloc] init] autorelease];
                hornorItem.name = self.name;
                hornorItem.avatar = self.avatar;
                hornorItem.tel =[array objectAtIndex:i];
                [arrayResult addObject:hornorItem];
            }
            self.phones = arrayResult;
        }
        
        array = [dictionary objectForKey:@"honors"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                HornorItem *item = [[[HornorItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];

            }
            self.hornors = arrayResult;
        }
        
        
        array = [dictionary objectForKey:@"courses"];
        arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionaryItem = (NSDictionary *) [array objectAtIndex:i];
                CourseItem *item = [[[CourseItem alloc] initWithDictionary:dictionaryItem] autorelease];
                [arrayResult addObject:item];
            }
            self.courses = arrayResult;
        }
        
    }
    return self;
}
@end



@implementation CityItem
- (void)dealloc{
    
    TT_RELEASE_SAFELY(_cityCode);
    TT_RELEASE_SAFELY(_cityName);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.cityCode     = [self stringObjectFrom:dictionary withKey:@"cityCode"];
        self.cityName   = [self stringObjectFrom:dictionary withKey:@"cityName"];
    }
    return self;
}
@end


