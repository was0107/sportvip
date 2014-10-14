//
//  ProductRequest.m
//  sfdl
//
//  Created by micker on 6/12/14.
//  Copyright (c) 2014 micker. All rights reserved.
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
    [computeSign appendFormat:@"companyId%@key%@username%@",self.comapnyId,[UserDefaultsManager currentKey],self.username];
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
    [computeSign appendFormat:@"companyId%@enquiryId%@key%@username%@",self.comapnyId,self.enquiryId,[UserDefaultsManager currentKey],self.username];
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
    [computeSign appendFormat:@"companyId%@content%@enquiryId%@key%@title%@username%@",self.comapnyId,self.content,
     self.enquiryId,[UserDefaultsManager currentKey],self.title,self.username];
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


@implementation CheckVersionRequest

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"os",@"type", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:@"2",@"1", nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"getLatestVersion";
}

@end