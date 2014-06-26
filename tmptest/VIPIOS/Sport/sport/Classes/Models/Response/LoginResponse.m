//
//  LoginResponse.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "LoginResponse.h"

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
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.advantage = [dictionary objectForKey:@"advantage"];
        self.coachName = [dictionary objectForKey:@"coachName"];
        self.description = [dictionary objectForKey:@"description"];
        self.name = [dictionary objectForKey:@"name"];
        self.schoolTime = [dictionary objectForKey:@"schoolTime"];
        NSString *priceTemp = [dictionary objectForKey:@"price"];
        self.price = [NSString stringWithFormat:@"￥%@",priceTemp];
        NSArray *array = [dictionary objectForKey:@"age"];
        NSArray *keyArray = [NSArray arrayWithObjects:@"YOUER",@"XIAOXUE",@"CHUZHONG",@"GAOZHONG",@"CHENGREN",@"",nil];
        NSArray *titleArray = [NSArray arrayWithObjects:@"幼儿",@"小学",@"初中",@"高中",@"成人",@"全部",nil];
        NSString *keyTemp = [array objectAtIndex:0];
        for (int i = 0 ; i < [keyArray count]; i++) {
            NSString *key = [keyArray objectAtIndex:i];
            if ([key isEqualToString:keyTemp]) {
                self.age = [titleArray objectAtIndex:i];
            }
        }
    }
    return self;
}




@end