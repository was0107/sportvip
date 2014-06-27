//
//  UserItemBase.m
//  GoDate
//
//  Created by allen.wang on 8/5/13.
//  Copyright (c) 2013 www.b5m.com. All rights reserved.
//

#import "UserItemBase.h"


@implementation UserItemBase

- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}


-(void)dealloc
{
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_nickName);
    TT_RELEASE_SAFELY(_gender);
    TT_RELEASE_SAFELY(_avatar);
    TT_RELEASE_SAFELY(_email);
    [super dealloc];
    
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        
        self.userId     = kIntToString([self integerValueFrom:dictionary withKey:@"id"]);
        self.nickName   = [self stringObjectFrom:dictionary withKey:@"nickName"];
        self.gender     = [self stringObjectFrom:dictionary withKey:@"gender"];
        self.avatar     = [self stringObjectFrom:dictionary withKey:@"avatar"];
        self.email      = [self stringObjectFrom:dictionary withKey:@"email"];
        self.phone      = [self stringObjectFrom:dictionary withKey:@"phone"];
        self.birthday   = [self integerValueFrom:dictionary withKey:@"birthday"];
        self.createTime = [self integerValueFrom:dictionary withKey:@"createTime"];
    }
    return self;
}

- (NSString *) genderString
{
    if ([self.gender compare:@"MALE"]) {
        return @"男性";
    }
    else if ([self.gender compare:@"FEMALE"]) {
        return @"女性";
    }
    else if ([self.gender compare:@"NOT_INPUT"]) {
        return @"其他";
    }
    return @"未填";
}

- (NSString *) thumbImage
{
    if ([self.avatar length] > 0) {
        
        NSString *url = [NSString stringWithFormat:@"%@/%d",self.avatar,200];
        return url;
    }
    return self.avatar;
}

@end

