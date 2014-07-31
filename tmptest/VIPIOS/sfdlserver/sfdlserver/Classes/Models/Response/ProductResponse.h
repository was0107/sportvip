//
//  ProductResponse.h
//  sfdl
//
//  Created by allen.wang on 6/13/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListPaggingResponseBase.h"
#import "LoginResponse.h"

/*
 *server
 */

@interface EnquiryListResponse : ListPaggingResponseBase

@end


@interface ViewEnquiryResponse : ListResponseBase
@property (nonatomic, retain) EnquiryItem *item;

@end

@interface ReplyEnquiryResponse : ListResponseBase

@end

