//
//  LoginRequest.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

@synthesize email = _email;
@synthesize password = _password;

- (void) dealloc
{
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_password);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"emailOrPhone", @"password", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.email, self.password, nil];
}


- (NSString *) methodString
{
    return @"user/login";
}

@end

@implementation ForgetPasswordRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_email);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"email", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.email, nil];
}

- (NSString *) methodString
{
    return @"user/forgotPassword";
}

@end


@implementation UpdatePasswordRequest


- (void) dealloc
{
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_theNewPassword);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:@"emailOrPhone"];
    [array addObject:@"oldPassword"];
    [array addObject:@"password"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.email];
    [array addObject:self.password];
    [array addObject:self.theNewPassword];
    return array;
}

- (NSString *) methodString
{
    return @"user/updateCredential";
}

@end



@implementation UpdateUserInfoRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_keys);
    TT_RELEASE_SAFELY(_values);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray * keys = [super keyArrays];
    if (keys) {
        [keys addObjectsFromArray:self.keys];
    }
    return keys;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray * values = [super valueArrays];
    if (values) {
        [values addObjectsFromArray:self.values];
    }
    return values;
}

-(NSString *)methodString
{
    if (self.isUpdate) {
        return @"user/updateUserInfo";
    }
    return  @"user/register";
}
@end



@implementation ClassDetailRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_courseId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"courseId", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.courseId, nil];
}

-(NSString *)methodString
{
    return  @"sport/course";
}
@end




@implementation AddClassCoachRequest


- (id) init
{
    self = [super init];
    if (self) {
        self.userId = self.courseId = @"";
        self.isContact = NO;
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_courseId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"type"];
    [array addObject:@"userId"];
    [array addObject:@"targetId"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:(self.isContact) ? @"CONTACT": @"VIEW"];
    [array addObject:self.userId];
    [array addObject:self.courseId];
    return array;
}

-(NSString *)methodString
{
    return  @"sport/coursehistory";
}
@end

@implementation ServicePhoneRequest

-(NSString *)methodString
{
    return  @"sport/servicephone";
}

@end

