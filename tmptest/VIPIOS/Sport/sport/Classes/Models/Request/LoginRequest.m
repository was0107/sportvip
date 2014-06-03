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
    return [NSMutableArray arrayWithObjects:@"email", @"password", nil];
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


@implementation GuidePictureRequest

- (id) init
{
    self = [super init];
    if (self) {
        self.screenSize = iPhone5 ? @"1" : @"0";
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_screenSize);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"screenSize"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.screenSize];
    return array;
}

- (NSString *) methodString
{
    return @"user/guide-picture";
}

@end


@implementation UpdateAPNTokenRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_deviceToken);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"deviceToken"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.deviceToken];
    return array;
}

- (NSString *) methodString
{
    return @"user/update-device-token";
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
    [array addObject:@"password"];
    [array addObject:@"newPassword"];
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
