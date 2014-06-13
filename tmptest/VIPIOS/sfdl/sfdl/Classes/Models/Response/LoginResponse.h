//
//  LoginResponse.h
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "ListResponseBase.h"
#import "UserItemBase.h"

#pragma mark
#pragma mark 用户基本资料
@interface LoginResponse : ListResponseBase

@property (nonatomic, retain) UserItemBase *userItem;

@end


@interface RegisterResponse : ListResponseBase

@property (nonatomic, copy) NSString *userId;

@end


@interface ProductTypeItem : ListResponseItemBase
@property (nonatomic, copy) NSString *productTypeId, *productTypeName, *parent;
@end


@interface ProductItem : ListResponseItemBase
@property (nonatomic, copy) NSString *productId, *productName, *productType, *productTypeName, *productDesc, *productImg;
@end



@interface ProductPropsItem : ListResponseItemBase
@property (nonatomic, copy) NSString *propId, *propName, *proValue;
@end



@interface PictureItem : ListResponseItemBase
@property (nonatomic, copy) NSString *mediaId, *creationTime, *mediaTitle;
@property (nonatomic, copy) NSString *mediaDesc, *isLocal, *mediaUrl;
@end

@interface NewsItem : ListResponseItemBase
@property (nonatomic, copy) NSString *newsId, *creationTime, *status;
@property (nonatomic, copy) NSString *newsTitle, *subTitle, *keyWords, *abstract;
@end


@interface AgentItem : ListResponseItemBase
@property (nonatomic, copy) NSString *agentId, *name, *desc;
@property (nonatomic, copy) NSString *regionId, *regionName;
@end


@interface OrderItem : ListResponseItemBase
@property (nonatomic, copy) NSString *orderId, *title, *content;
@property (nonatomic, copy) NSString *sendTime, *status;
//productList productList:[111,115,124]
@end


@interface CommentItem : ListResponseItemBase
@property (nonatomic, copy) NSString *commentsId, *comments, *productId;
@property (nonatomic, copy) NSString *username, *createTime;
@end

