//
//  LoginResponse.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "LoginResponse.h"
#import "PaggingItem.h"

@implementation LoginResponse
@synthesize userItem = _userItem;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_userItem);
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        
        self.userItem = [[[UserItemBase alloc] initWithDictionary:dictionary] autorelease];
    }
    return self;
}


@end



@implementation ClassDetailResponse
- (void)dealloc{
    
    TT_RELEASE_SAFELY(_advantage);
    TT_RELEASE_SAFELY(_age);
    TT_RELEASE_SAFELY(_coachName);
    TT_RELEASE_SAFELY(_description);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_price);
    TT_RELEASE_SAFELY(_schoolTime);
    TT_RELEASE_SAFELY(_coachId);
    TT_RELEASE_SAFELY(_phones);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_coachAvatar)
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.advantage = [dictionary objectForKey:@"advantage"];
        self.coachName = [dictionary objectForKey:@"coachName"];
        self.coachId = [dictionary objectForKey:@"coachId"];
        self.description = [dictionary objectForKey:@"description"];
        self.name = [dictionary objectForKey:@"name"];
        self.address = [dictionary objectForKey:@"address"];
        self.gymnasiumName = [dictionary objectForKey:@"gymnasiumName"];
        self.schoolTime = [dictionary objectForKey:@"schoolTime"];
        NSString *priceTemp = [dictionary objectForKey:@"price"];
        self.price = [NSString stringWithFormat:@"￥%@",priceTemp];
        NSArray *array = [dictionary objectForKey:@"age"];
        NSArray *keyArray = [NSArray arrayWithObjects:@"YOUER",@"XIAOXUE",@"CHUZHONG",@"GAOZHONG",@"CHENGREN",@"",nil];
        NSArray *titleArray = [NSArray arrayWithObjects:@"幼儿",@"小学",@"初中",@"高中",@"成人",@"全部",nil];
        NSString *keyTemp = [array objectAtIndex:0];
        NSMutableString *ageString = [NSMutableString string];
        for (int i = 0 ; i < [keyArray count]; i++) {
            NSString *key = [keyArray objectAtIndex:i];
            if ([key isEqualToString:keyTemp]) {
                [ageString appendFormat:@"%@、",[titleArray objectAtIndex:i] ];
            }
        }
        if ([ageString length] > 0) {
            self.age = [ageString substringToIndex:ageString.length-1];
        } else {
            self.age = @"";
        }
        
        
        array = [dictionary objectForKey:@"phones"];
        NSMutableArray *arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                TelItem *item = [[[TelItem alloc] init] autorelease];
                item.coachId     = self.coachId;
                item.name     = self.name;
                item.avatar   = self.coachAvatar;
                item.tel      = [array objectAtIndex:i];
                [arrayResult addObject:item];
            }
            
            self.phones = arrayResult;
        }

    }
    return self;
}

@end


@implementation ServicePhoneResponse

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_phone);
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        NSArray *array = (NSArray *) dictionary;
        if ([array count] > 0) {
            self.phone = [array objectAtIndex:0];
        } else {
            self.phone = @"";
        }
        
    }
    return self;
}



@end