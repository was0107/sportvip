//
//  ProductResponse.m
//  sfdl
//
//  Created by allen.wang on 6/13/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductResponse.h"


/*
 *server
 */

@implementation EnquiryListResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[EnquiryItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"enquiryList";
}

@end


@implementation ViewEnquiryResponse

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.item = [[[EnquiryItem alloc] initWithDictionary:[dictionary objectForKey:@"enquiry"]] autorelease];
    return self;
}

@end

@implementation ReplyEnquiryResponse

@end
