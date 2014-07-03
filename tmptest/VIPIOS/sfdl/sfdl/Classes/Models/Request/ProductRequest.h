//
//  ProductRequest.h
//  sfdl
//
//  Created by allen.wang on 6/12/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListPaggingRequestBase.h"
#import "ProductResponse.h"

@interface ProductTypeRequest : ListPaggingRequestBase

@end

@interface ProductListRequest : ListPaggingRequestBase

@property (nonatomic, copy) NSString *productTypeId;
@end


@interface SearchProductRequest : ListPaggingRequestBase

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, retain) NSMutableArray *propertyId,*propertyListId,*propertyListValues;
@end


@interface ViewProductRequest : ListRequestBase

@property (nonatomic, copy) NSString *productId;

@end


@interface PromotionListRequest : ListPaggingRequestBase

@end


@interface ViewPromotionRequest : ListRequestBase

@property (nonatomic, copy) NSString *promotionId;

@end


@interface PictureListRequest : ListPaggingRequestBase

@end


@interface ViewPictureRequest : ListRequestBase

@property (nonatomic, copy) NSString *pictureId;

@end

@interface VideoListRequest : ListPaggingRequestBase

@end


@interface ViewVideoRequest : ListRequestBase

@property (nonatomic, copy) NSString *videoId;

@end

@interface NewsListRequest : ListPaggingRequestBase

@end

@interface ViewNewsRequest : ListRequestBase

@property (nonatomic, copy) NSString *newsId;

@end

@interface AgentListRequest : ListPaggingRequestBase

@property (nonatomic, copy) NSString *name,*productTypeId,*regionId;

@end

@interface RegionListRequest : ListPaggingRequestBase

@end

@interface ViewAgentRequest : ListRequestBase

@property (nonatomic, copy) NSString *agentId;

@end

@interface OrdertListRequest : ListPaggingRequestBase

@property (nonatomic, copy) NSString *username,*sign;

@end

@interface ViewOrderRequest : ListRequestBase

@property (nonatomic, copy) NSString *username,*orderId,*sign;

@end


@interface CreateOrderRequest : ListRequestBase

@property (nonatomic, copy) NSString *username,*productList,*content,*title,*sign,*quantityList;

@end


@interface DeleteOrderRequest : ViewOrderRequest

@end


@interface SendMessageRequest : ListRequestBase

@property (nonatomic, copy) NSString *from, *email, *fromCompany,*tel,*message;

@end

@interface CommentListRequest : ViewProductRequest

@end

@interface AddCommentRequest : ListRequestBase

@property (nonatomic, copy) NSString *username, *productId,*comments, *sign;

@end


@interface MenuListRequest : ListRequestBase

@end


@interface ProductPropertySearchConditions : ListRequestBase

@end






