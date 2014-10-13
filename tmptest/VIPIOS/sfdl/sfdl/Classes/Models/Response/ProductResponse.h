//
//  ProductResponse.h
//  sfdl
//
//  Created by allen.wang on 6/13/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListPaggingResponseBase.h"
#import "LoginResponse.h"

@interface ProductTypeReponse : ListPaggingResponseBase

@end

@interface ProductResponse : ListPaggingResponseBase


@end

@interface SurportLangResponse : ListPaggingResponseBase

@end


@interface ProductDetailResponse : ListPaggingResponseBase
@property (nonatomic, copy) NSString *productId, *productName, *videoUrl, *productType, *productTypeName, *productDesc, *productImg;

@property (nonatomic, copy) NSString *videoImg, *feature, *others;

@property (nonatomic, retain) NSMutableArray *imagesArray;

@end

@interface PictureResponse : ListPaggingResponseBase

@end


@interface VideoResponse : ListPaggingResponseBase

@end


@interface NewsResponse : ListPaggingResponseBase

@end


@interface AgentResponse : ListPaggingResponseBase

@end


@interface RegionResponse : ListPaggingResponseBase

@end


@interface OrdersResponse : ListPaggingResponseBase

@end


@interface ViewOrderResponse : ListResponseBase

@property (nonatomic, retain) OrderItem *orderItem;

@end


@interface CommentsResponse : ListPaggingResponseBase

@end


@interface NewsDetailResponse : ListResponseBase

@property (nonatomic, retain) NewsItem *item;

@end


@interface MenuResponse : ListPaggingResponseBase

@end


@interface ProductPropertySearchResponse : ListPaggingResponseBase

@end


/*
 * add new interface
 */



@interface ProductForHomePageResponse : ListPaggingResponseBase
@property (nonatomic, retain) NSMutableArray * hotArray;                  //结果集

@end

@interface BrowsingHistoryListResponse : ListPaggingResponseBase

@property (nonatomic, copy) NSString *username;

@end


@interface BannerResponse : ListPaggingResponseBase

@end


@interface CheckVersionResponse : ListResponseBase

@property (nonatomic, copy) NSString *version, *download_url;

- (BOOL) isNeedToTip;

@end


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

