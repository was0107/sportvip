//
//  ProductRequest.h
//  sfdl
//
//  Created by allen.wang on 6/12/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListPaggingRequestBase.h"
#import "ProductResponse.h"
/*
 *server
 */

@interface EnquiryListRequest : ListPaggingRequestBase
@property (nonatomic, copy) NSString *username,*sign;

@end

@interface ViewEnquiryRequest : ListRequestBase

@property (nonatomic, copy) NSString *username,*enquiryId,*sign;

@end

@interface ReplyEnquiryRequest : ViewEnquiryRequest

@property (nonatomic, copy) NSString *title, *content;

@end




