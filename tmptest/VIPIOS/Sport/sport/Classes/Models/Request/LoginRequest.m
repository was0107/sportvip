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
    return @"user/forget-password";
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
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"oldPassword"];
    [array addObject:@"password"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.password];
    [array addObject:self.theNewPassword];
    return array;
}

- (NSString *) methodString
{
    return @"user/update-password";
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

