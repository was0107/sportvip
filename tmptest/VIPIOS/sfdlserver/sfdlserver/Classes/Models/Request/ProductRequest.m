//
//  ProductRequest.m
//  sfdl
//
//  Created by allen.wang on 6/12/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductRequest.h"

@implementation EnquiryListRequest
- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_sign);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"companyId%@username%@",self.comapnyId,self.username];
    self.sign = [computeSign md5String];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"CompanyEnquiry/getEnquiryList";
}

@end

@implementation ViewEnquiryRequest
- (void) dealloc
{
    TT_RELEASE_SAFELY(_enquiryId);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_sign);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"enquiryId", @"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"companyId%@enquiryId%@username%@",self.comapnyId,self.enquiryId,self.username];
    self.sign = [computeSign md5String];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.enquiryId,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"CompanyEnquiry/viewEnquiry";
}
@end

@implementation ReplyEnquiryRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_content);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"title",@"content", @"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"companyId%@content%@enquiryId%@title%@username%@",self.comapnyId,self.content,self.enquiryId,self.title,self.username];
    self.sign = [computeSign md5String];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.title,self.content,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"CompanyEnquiry/replyOrder";
}
@end

