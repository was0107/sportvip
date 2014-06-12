//
//  LoginRequest.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
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

@implementation RegiseterRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_fullName);
    TT_RELEASE_SAFELY(_userCompany);
    TT_RELEASE_SAFELY(_tel);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"email", @"title", @"fullName", @"userCompany", @"tel",  nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:self.email, self.title,self.fullName,self.userCompany,self.tel, nil];
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
