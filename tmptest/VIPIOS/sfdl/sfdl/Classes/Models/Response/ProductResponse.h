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


@interface ProductDetailResponse : ListPaggingResponseBase


@end


@interface PictureResponse : ListPaggingResponseBase

@end



@interface VideoResponse : ListPaggingResponseBase

@end


@interface NewsResponse : ListPaggingResponseBase

@end


@interface AgentResponse : ListPaggingResponseBase

@end


@interface OrdersResponse : ListPaggingResponseBase

@end


@interface CommentsResponse : ListPaggingResponseBase

@end


@interface NewsDetailResponse : ListResponseBase
@property (nonatomic, retain) NewsItem *item;

@end
