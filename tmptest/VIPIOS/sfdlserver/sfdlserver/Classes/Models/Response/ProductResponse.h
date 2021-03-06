//
//  ProductResponse.h
//  sfdl
//
//  Created by micker on 6/13/14.
//  Copyright (c) 2014 micker. All rights reserved.
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

@interface CheckVersionResponse : ListResponseBase

@property (nonatomic, copy) NSString *version, *download_url;

- (BOOL) isNeedToTip;

@end