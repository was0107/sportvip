//
//  LoginResponse.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 micker. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse
@synthesize userItem = _userItem;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_userItem);
    TT_RELEASE_SAFELY(_key)
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.key = [dictionary objectForKey:@"key"];
        self.userItem = [[[UserItemBase alloc] initWithDictionary:dictionary] autorelease];
    }
    return self;
}


@end



@implementation RegisterResponse

@synthesize userId = _userId;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_userId);
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.userId = [dictionary objectForKey:@"userId"];
    }
    
    return self;
}


@end

@implementation AboutUsResponse

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_companyName);
    TT_RELEASE_SAFELY(_companyDes);
    TT_RELEASE_SAFELY(_contactus);
    TT_RELEASE_SAFELY(_contactus);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_telphone1);
    TT_RELEASE_SAFELY(_telphone2);
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        NSDictionary *company = [dictionary objectForKey:@"company_info"];
        self.companyName = [company objectForKey:@"company_name"];
        self.companyDes = [company objectForKey:@"company_desc"];
        self.contactus = [company objectForKey:@"contactus"];
        self.email = [company objectForKey:@"email"];
        self.telphone1 = [company objectForKey:@"telphone1"];
        self.telphone2 = [company objectForKey:@"telphone2"];
        if ([self.companyDes isKindOfClass:[NSNull class]]) {
            self.companyDes = @"";
        }
        if ([self.contactus isKindOfClass:[NSNull class]]) {
            self.contactus = @"";
        }
        
    }
    
    return self;
}

- (NSString *) companyTelephone
{
    if ([self.telphone1 length] > 0) {
        return self.telphone1;
    }
    else if ([self.telphone2 length] > 0 ) {
        return self.telphone2;
    }
    return @"";
}



@end


@implementation LanguageItem


- (void)dealloc{
    
    TT_RELEASE_SAFELY(_lang);
    TT_RELEASE_SAFELY(_lang_name);
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.lang = [dictionary objectForKey:@"lang"];
        self.lang_name = [dictionary objectForKey:@"lang_name"];
    }
    
    return self;
}


@end


@implementation ProductTypeItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_productTypeId);
    TT_RELEASE_SAFELY(_productTypeImg);
    TT_RELEASE_SAFELY(_productTypeName);
    TT_RELEASE_SAFELY(_templateId);
    TT_RELEASE_SAFELY(_parent);
    TT_RELEASE_SAFELY(_children);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.productTypeId = [dictionary objectForKey:@"productTypeId"];
        self.productTypeImg = [dictionary objectForKey:@"productTypeImg"];
        self.productTypeName = [dictionary objectForKey:@"productTypeName"];
        self.templateId     = [dictionary objectForKey:@"template"];
        self.parent = [dictionary objectForKey:@"parent"];
        
        NSArray *array = [dictionary objectForKey:@"children"];
        NSMutableArray *childRenArray = [NSMutableArray array];
        if (array && [array count] > 0) {
            for (int i = 0 , total = [array count]; i < total; i++) {
                ProductTypeItem *typeItem = [[ProductTypeItem alloc] initWithDictionary:[array objectAtIndex:i]];
                [childRenArray addObject:typeItem];
            }
        }
        self.children = childRenArray;
    }
    
    return self;
}

@end

@implementation ProductItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_productName);
    TT_RELEASE_SAFELY(_productType);
    TT_RELEASE_SAFELY(_productTypeName);
    TT_RELEASE_SAFELY(_productDesc);
    TT_RELEASE_SAFELY(_productImg);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        
        self.productId = [self stringObjectFrom:dictionary withKey:@"productId"];
        self.productName = [self stringObjectFrom:dictionary withKey:@"productName"];
        self.productType = [self stringObjectFrom:dictionary withKey:@"productType"];
        self.productTypeName = [self stringObjectFrom:dictionary withKey:@"productTypeName"];
        self.productDesc = [self stringObjectFrom:dictionary withKey:@"productDesc"];
        self.productImg = [self stringObjectFrom:dictionary withKey:@"productImg"];
        
        self.buyCount = 1;
    }
    
    return self;
}
@end

@implementation ProductPropsItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_propId);
    TT_RELEASE_SAFELY(_propName);
    TT_RELEASE_SAFELY(_proValue);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.propId = [dictionary objectForKey:@"propId"];
        self.propName = [dictionary objectForKey:@"propName"];
        self.proValue = [dictionary objectForKey:@"proValue"];
    }
    
    return self;
}
@end


@implementation PictureItem



- (void) dealloc
{
    TT_RELEASE_SAFELY(_mediaId);
    TT_RELEASE_SAFELY(_creationTime);
    TT_RELEASE_SAFELY(_mediaTitle);
    TT_RELEASE_SAFELY(_mediaDesc);
    TT_RELEASE_SAFELY(_isLocal);
    TT_RELEASE_SAFELY(_mediaUrl);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.mediaId = [dictionary objectForKey:@"mediaId"];
        self.creationTime = [dictionary objectForKey:@"creationTime"];
        self.mediaTitle = [dictionary objectForKey:@"mediaTitle"];
        self.mediaDesc = [dictionary objectForKey:@"mediaDesc"];
        self.isLocal = [dictionary objectForKey:@"isLocal"];
        self.mediaUrl = [dictionary objectForKey:@"mediaUrl"];
    }
    
    return self;
}
@end




@implementation BannerItem : ListResponseItemBase


- (void) dealloc
{
    TT_RELEASE_SAFELY(_bannerId);
    TT_RELEASE_SAFELY(_bannerName);
    TT_RELEASE_SAFELY(_bannerImg);
    TT_RELEASE_SAFELY(_bannerLink);
    TT_RELEASE_SAFELY(_type);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.bannerId = [dictionary objectForKey:@"bannerId"];
        self.bannerName = [dictionary objectForKey:@"bannerName"];
        self.bannerImg = [dictionary objectForKey:@"bannerImg"];
        self.bannerLink = [dictionary objectForKey:@"bannerLink"];
        self.type = [dictionary objectForKey:@"type"];
    }
    
    return self;
}

@end

@implementation NewsItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_newsId);
    TT_RELEASE_SAFELY(_creationTime);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_newsTitle);
    TT_RELEASE_SAFELY(_subTitle);
    TT_RELEASE_SAFELY(_keyWords);
    TT_RELEASE_SAFELY(_abstract);
    TT_RELEASE_SAFELY(_content);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.newsId = [dictionary objectForKey:@"newsId"];
        self.creationTime = [dictionary objectForKey:@"creationTime"];
        self.status = [dictionary objectForKey:@"status"];
        self.newsTitle = [dictionary objectForKey:@"newsTitle"];
        self.subTitle = [dictionary objectForKey:@"subTitle"];
        self.keyWords = [dictionary objectForKey:@"keyWords"];
        self.abstract = [dictionary objectForKey:@"newsAbstract"];
        self.content = [dictionary objectForKey:@"content"];
    }
    
    return self;
}
@end



@implementation AgentItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_agentId);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_desc);
    TT_RELEASE_SAFELY(_regionId);
    TT_RELEASE_SAFELY(_regionName);
    TT_RELEASE_SAFELY(_agentCode);
    TT_RELEASE_SAFELY(_contact);
    TT_RELEASE_SAFELY(_tel);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_zipcode);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_keysArray);
    TT_RELEASE_SAFELY(_valuesArray);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.keysArray = [NSMutableArray array];
        self.valuesArray = [NSMutableArray array];
        self.agentId = [dictionary objectForKey:@"agentId"];
        self.name = [dictionary objectForKey:@"name"];
        self.desc = [dictionary objectForKey:@"desc"];
        self.regionId = [dictionary objectForKey:@"regionId"];
        self.regionName = [dictionary objectForKey:@"regionName"];
        self.agentCode = [dictionary objectForKey:@"agentCode"];
        self.contact = [dictionary objectForKey:@"contact"];
        self.tel = [dictionary objectForKey:@"tel"];
        self.address = [dictionary objectForKey:@"address"];
        self.zipcode = [dictionary objectForKey:@"zipcode"];
        self.email = [dictionary objectForKey:@"email"];
        [self.keysArray addObject:@"Serial number:"];
        [self.keysArray addObject:@"Contacts:"];
        [self.keysArray addObject:@"Description:"];
        [self.keysArray addObject:@"Tel"];
        [self.keysArray addObject:@"Email:"];
        [self.keysArray addObject:@"Zip:"];
        [self.keysArray addObject:@"Address:"];
        
        [self.valuesArray addObject:self.agentCode];
        [self.valuesArray addObject:self.contact];
        [self.valuesArray addObject:self.desc];
        [self.valuesArray addObject:self.tel];
        [self.valuesArray addObject:self.email];
        [self.valuesArray addObject:self.zipcode];
        [self.valuesArray addObject:self.address];
    }
    
    return self;
}
@end


@implementation RegionItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_regionId);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_desc);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.regionId = [dictionary objectForKey:@"regionId"];
        self.name = [dictionary objectForKey:@"name"];
        self.desc = [dictionary objectForKey:@"desc"];
    }
    return self;
}

@end

@implementation OrderItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_sendTime);
    TT_RELEASE_SAFELY(_productIdArray);
    TT_RELEASE_SAFELY(_productList);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_enquiryEmail);
    TT_RELEASE_SAFELY(_toEmail);
    TT_RELEASE_SAFELY(_progress);
    TT_RELEASE_SAFELY(_productListArray);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.orderId     = [dictionary objectForKey:@"orderId"];
        self.title       = [dictionary objectForKey:@"title"];
        self.content     = [dictionary objectForKey:@"content"];
        self.sendTime    = [dictionary objectForKey:@"sendTime"];
        self.progress    = [dictionary objectForKey:@"progress"];
        self.enquiryEmail    = [dictionary objectForKey:@"enquiryEmail"];
        self.toEmail    = [dictionary objectForKey:@"toEmail"];
        self.productList = [dictionary objectForKey:@"productList"];
        
        NSString *statusKey = [dictionary objectForKey:@"status"];
        self.statusInt = [statusKey integerValue];
        if ([statusKey isEqualToString:@"0"]) {
            self.status = @"查询中";
        }
        else if ([statusKey isEqualToString:@"1"]) {
            self.status = @"处理中";
        }
        else {
            self.status = @"完成";
        }
        
        self.titleArray = [NSMutableArray array];
        self.productIdArray = [NSMutableArray array];
        self.productListArray = [NSMutableArray array];

//        NSArray *array = [self.title componentsSeparatedByString:@","];
//        [self.titleArray addObjectsFromArray:array];
//        array = [self.productList componentsSeparatedByString:@","];
//        [self.productIdArray addObjectsFromArray:array];
    }
    
    return self;
}
@end


@implementation CommentItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_comments);
    TT_RELEASE_SAFELY(_commentsId);
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_createTime);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.commentsId = [dictionary objectForKey:@"commentsId"];
        self.comments = [dictionary objectForKey:@"comments"];
        self.productId = [dictionary objectForKey:@"productId"];
        self.username = [dictionary objectForKey:@"username"];
        self.createTime = [dictionary objectForKey:@"createTime"];
    }
    
    return self;
}
@end



@implementation MenuItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_menu_alias);
    TT_RELEASE_SAFELY(_menu_name);
    TT_RELEASE_SAFELY(_menu_url);
    TT_RELEASE_SAFELY(_icon);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.menu_url = [dictionary objectForKey:@"menu_url"];
        self.menu_alias = [self stringObjectFrom:dictionary withKey:@"menu_alias"];
        self.menu_name = [dictionary objectForKey:@"menu_name"];
        self.orderby = [dictionary objectForKey:@"orderby"];
        self.icon = [dictionary objectForKey:@"icon"];
    }
    
    return self;
}
- (BOOL) isNULL
{
    if (!self.menu_alias) {
        return YES;
    }
    if ([self.menu_alias length] == 0) {
        return YES;
    }
    if ([self.menu_alias isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}
@end


@implementation ProperListItem


- (void) dealloc
{
    TT_RELEASE_SAFELY(_propertyListId);
    TT_RELEASE_SAFELY(_propertyListValue);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.propertyListId = [dictionary objectForKey:@"propertyListId"];
        self.propertyListValue = [self stringObjectFrom:dictionary withKey:@"propertyListValue"];
    }
    
    return self;
}

@end


@implementation ProperItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productTypeId);
    TT_RELEASE_SAFELY(_productTypeName);
    TT_RELEASE_SAFELY(_propertyId);
    TT_RELEASE_SAFELY(_propertyName);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.propertyId = [self stringObjectFrom:dictionary withKey:@"propertyId"];
        self.propertyName = [self stringObjectFrom:dictionary withKey:@"propertyName"];
        self.productTypeId = [self stringObjectFrom:dictionary withKey:@"productTypeId"];
        self.productTypeName = [self stringObjectFrom:dictionary withKey:@"productTypeName"];
        
        
        
        NSMutableArray *array = [dictionary objectForKey:@"valueList"];
        NSMutableArray *arrayResult = [NSMutableArray array];
        @autoreleasepool {
            for ( int i = 0 , total = [array count]; i < total; ++i) {
                NSDictionary *dictionary = (NSDictionary *) [array objectAtIndex:i];
                ProperListItem *lisetItem = [[[ProperListItem alloc] initWithDictionary:dictionary] autorelease];
                    [arrayResult addObject:lisetItem];
            }
        }
        
        self.valueList = arrayResult;
    }
    
    return self;
}

@end


@implementation VerifyCodeResponse

- (void) dealloc
{
    TT_RELEASE_SAFELY(_imageUrl);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.imageUrl = [dictionary objectForKey:@"imageUrl"];
    }
    
    return self;
}

@end



@implementation CheckVerifyCodeResponse

- (void) dealloc
{
    TT_RELEASE_SAFELY(_checked );
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.checked = [dictionary objectForKey:@"checked"];
    }
    
    return self;
}

- (BOOL) isChecked
{
    if ([self.checked isEqualToString:@"true"]) {
        return YES;
    }
    return NO;
}

@end




@implementation HistoryItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_historyId);
    TT_RELEASE_SAFELY(_companyId);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_type);
    TT_RELEASE_SAFELY(_refId);
    TT_RELEASE_SAFELY(_creationTime);
    [super dealloc];
}



- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self  = [super init];
    if (self) {
        self.historyId       = [dictionary objectForKey:@"historyId"];
        self.companyId       = [dictionary objectForKey:@"companyId"];
        self.username        = [dictionary objectForKey:@"username"];
        self.content         = [dictionary objectForKey:@"content"];
        self.type            = [dictionary objectForKey:@"type"];
        self.refId           = [dictionary objectForKey:@"refId"];
        self.creationTime    = [dictionary objectForKey:@"creationTime"];
    }

    return self;
}

@end


@implementation HomeProductItem

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.productId       = [dictionary objectForKey:@"productId"];
        self.productName     = [dictionary objectForKey:@"productName"];
        self.recommendFlag   = [dictionary objectForKey:@"recommendFlag"];
        self.hotFlag         = [dictionary objectForKey:@"hotFlag"];
        self.productImg      = [dictionary objectForKey:@"productImg"];
        self.productTypeId   = [dictionary objectForKey:@"productTypeId"];
        self.productTypeName = [dictionary objectForKey:@"productTypeName"];
        self.productDesc     = [dictionary objectForKey:@"productDesc"];
    }

    return self;
}


- (void) dealloc
{
    TT_RELEASE_SAFELY(_productTypeId);
    [super dealloc];
}


@end



@implementation EnquiryItem

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.enquiryId = [dictionary objectForKey:@"enquiryId"];
        self.title = [dictionary objectForKey:@"title"];
        self.content = [dictionary objectForKey:@"content"];
        self.sendTime = [dictionary objectForKey:@"sendTime"];
        self.status = [dictionary objectForKey:@"status"];
        self.productList = [dictionary objectForKey:@"productList"];
        self.progress = [dictionary objectForKey:@"progress"];
    }
    
    return self;
}


- (void) dealloc
{
    TT_RELEASE_SAFELY(_enquiryId);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_sendTime);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_productList);
    TT_RELEASE_SAFELY(_progress);
    [super dealloc];
}

@end



