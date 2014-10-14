//
//  LoginResponse.h
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 micker. All rights reserved.
//

#import "ListResponseBase.h"
#import "UserItemBase.h"

#pragma mark
#pragma mark 用户基本资料
@interface LoginResponse : ListResponseBase

@property (nonatomic, copy) NSString *key;
@property (nonatomic, retain) UserItemBase *userItem;

@end

@interface RegisterResponse : ListResponseBase

@property (nonatomic, copy) NSString *userId;

@end

@interface AboutUsResponse : ListResponseBase

@property (nonatomic, copy) NSString *companyName, *companyDes,*contactus,*telphone1,*telphone2, *email;

- (NSString *) companyTelephone;

@end


@interface LanguageItem : ListResponseItemBase

@property (nonatomic, copy) NSString *lang, *lang_name;

@end

@interface ProductTypeItem : ListResponseItemBase

@property (nonatomic, copy) NSString *productTypeId, *productTypeName,*productTypeImg, *parent, *templateId;
@property (nonatomic, retain) NSMutableArray *children;

@end



@interface ProductItem : ListResponseItemBase

@property (nonatomic, copy) NSString *productId, *productName, *productType, *productTypeName, *productDesc, *productImg;
@property (nonatomic, assign) NSUInteger buyCount;

@end




@interface ProductPropsItem : ListResponseItemBase

@property (nonatomic, copy) NSString *propId, *propName, *proValue;

@end



@interface PictureItem : ListResponseItemBase

@property (nonatomic, copy) NSString *mediaId, *creationTime, *mediaTitle;
@property (nonatomic, copy) NSString *mediaDesc, *isLocal, *mediaUrl;

@end

@interface BannerItem : ListResponseItemBase

@property (nonatomic, copy) NSString *bannerId, *bannerName, *bannerImg, *bannerLink, *type;

@end

@interface NewsItem : ListResponseItemBase

@property (nonatomic, copy) NSString *newsId, *creationTime, *status;
@property (nonatomic, copy) NSString *newsTitle, *subTitle, *keyWords, *abstract, *content;

@end


@interface AgentItem : ListResponseItemBase

@property (nonatomic, copy) NSString *agentId, *name, *desc, *agentCode,*contact, *tel,*address, *zipcode, *email;
@property (nonatomic, copy) NSString *regionId, *regionName;
@property (nonatomic, retain) NSMutableArray *keysArray, *valuesArray;

@end

@interface RegionItem : ListResponseItemBase

@property (nonatomic, copy) NSString *regionId, *name, *desc;

@end


@interface OrderItem : ListResponseItemBase

@property (nonatomic, copy) NSString *orderId, *title, *content,*productList;
@property (nonatomic, copy) NSString *sendTime, *status;
@property (nonatomic, assign) NSInteger statusInt;

@property (nonatomic, retain) NSMutableArray *titleArray,*productIdArray, *productListArray;
//productList productList:[111,115,124]

@property (nonatomic, copy) NSString *progress, *enquiryEmail, *toEmail;

@end


@interface CommentItem : ListResponseItemBase

@property (nonatomic, copy) NSString *commentsId, *comments, *productId;
@property (nonatomic, copy) NSString *username, *createTime;

@end

@interface MenuItem : ListResponseItemBase

@property (nonatomic, copy) NSString *menu_url, *orderby, *icon;
@property (nonatomic, copy) NSString *menu_alias, *menu_name;

- (BOOL) isNULL;

@end

@interface ProperListItem: ListResponseItemBase

@property (nonatomic, copy) NSString *propertyListId, *propertyListValue;

@end

@interface ProperItem : ListResponseItemBase

@property (nonatomic, copy) NSString *propertyId, *propertyName, *productTypeId, *productTypeName;
@property (nonatomic, retain) NSMutableArray *valueList;

@end

@interface VerifyCodeResponse : ListResponseBase

@property (nonatomic, copy) NSString *imageUrl;

@end

@interface CheckVerifyCodeResponse : ListResponseBase

@property (nonatomic, copy) NSString *checked;

- (BOOL) isChecked;

@end


@interface HistoryItem : ListResponseItemBase

@property (nonatomic, copy) NSString *historyId, *companyId, *username;

@property (nonatomic, copy) NSString *content, *type, *refId, *creationTime;

@end


@interface HomeProductItem : ProductItem

@property (nonatomic, copy) NSString  *recommendFlag,*productTypeId, *hotFlag;

@end


/*
 *server
 */


@interface EnquiryItem : ListResponseItemBase

@property (nonatomic, copy) NSString *enquiryId,*title,*content,*sendTime,*status;

@property (nonatomic, copy) NSString *productList,*progress;

@end






