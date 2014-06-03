//
//  LoginResponse.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

@synthesize userId = _userId;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_userId);
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.userId = [dictionary objectForKey:@"userId"];
    }
    
    return self;
}


@end
