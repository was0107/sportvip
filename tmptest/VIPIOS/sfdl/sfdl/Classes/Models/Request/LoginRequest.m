//
//  LoginRequest.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 micker. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest


- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_password);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"username", @"password", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:self.username, self.password, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}


- (NSString *) methodString
{
    return @"User/login";
}

@end

@implementation ServerLoginRequest


- (NSString *) methodString
{
    return @"CompanyUser/login";
}


@end

@implementation RegiseterRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_email);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"email",  nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:self.email, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}


- (NSString *) methodString
{
    return @"User/register";
}



@end

@implementation ForgetPasswordRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"user/forgotPassword";
}

@end

@implementation SurportLangRequest

- (NSString *) methodString
{
    return @"Company/getSupportedLangList";
}

@end


@implementation CompanyInfoRequest

- (NSString *) methodString
{
    return @"Company/getCompanyInfo";
}

@end

@implementation SetSurportlangRequest

- (void) dealloc
{
    [super dealloc];
}

- (NSString *) methodString
{
    return @"user/setPrefLang";
}

@end

@implementation VerifyCodeRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_deviceId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"deviceId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    self.deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.deviceId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"User/getVerifyCode";
}

@end

@implementation CheckVerifyCodeRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_verifyCode);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"verifyCode", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.verifyCode, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"User/checkVerifyCode";
}

@end
