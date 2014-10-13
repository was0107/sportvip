//
//  LoginResponse.m
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
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
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        NSDictionary *company = [dictionary objectForKey:@"company_info"];
        self.companyName = [company objectForKey:@"company_name"];
        self.companyDes = [company objectForKey:@"company_desc"];
        self.contactus = [company objectForKey:@"contactus"];
    }
    
    return self;
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

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.productTypeId = [dictionary objectForKey:@"productTypeId"];
        self.productTypeName = [dictionary objectForKey:@"productTypeName"];
        self.parent = [dictionary objectForKey:@"parent"];
    }
    
    return self;
}

@end

@implementation ProductItem

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


@implementation NewsItem

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

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.agentId = [dictionary objectForKey:@"agentId"];
        self.name = [dictionary objectForKey:@"name"];
        self.desc = [dictionary objectForKey:@"desc"];
        self.regionId = [dictionary objectForKey:@"regionId"];
        self.regionName = [dictionary objectForKey:@"regionName"];
    }
    
    return self;
}
@end


@implementation RegionItem

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

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.orderId     = [dictionary objectForKey:@"orderId"];
        self.title       = [dictionary objectForKey:@"title"];
        self.content     = [dictionary objectForKey:@"content"];
        self.sendTime    = [dictionary objectForKey:@"sendTime"];
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

        NSArray *array = [self.title componentsSeparatedByString:@","];
        [self.titleArray addObjectsFromArray:array];
        array = [self.productList componentsSeparatedByString:@","];
        [self.productIdArray addObjectsFromArray:array];
    }
    
    return self;
}
@end


@implementation CommentItem

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


@implementation EnquiryItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_enquiryId);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_sendTime);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_productList);
    TT_RELEASE_SAFELY(_progress);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_readFlag);
    TT_RELEASE_SAFELY(_ip_address);
    TT_RELEASE_SAFELY(_country);
    TT_RELEASE_SAFELY(_area);
    TT_RELEASE_SAFELY(_field_value1);
    TT_RELEASE_SAFELY(_field_value2);
    TT_RELEASE_SAFELY(_field_value3);
    TT_RELEASE_SAFELY(_field_value4);
    TT_RELEASE_SAFELY(_field_value5);
    [super dealloc];
}

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.enquiryId    = [self stringObjectFrom:dictionary withKey:@"enquiryId"];
        self.title        = [self stringObjectFrom:dictionary withKey:@"title"];
        self.content      = [self stringObjectFrom:dictionary withKey:@"content"];
        self.sendTime     = [self stringObjectFrom:dictionary withKey:@"sendTime"];
        self.status       = [self stringObjectFrom:dictionary withKey:@"status"];
        self.progress     = [self stringObjectFrom:dictionary withKey:@"progress"];
        self.username     = [self stringObjectFrom:dictionary withKey:@"username"];
        self.readFlag     = [self stringObjectFrom:dictionary withKey:@"readFlag"];
        self.ip_address   = [self stringObjectFrom:dictionary withKey:@"ip_address"];
        self.country      = [self stringObjectFrom:dictionary withKey:@"country"];
        self.area         = [self stringObjectFrom:dictionary withKey:@"area"];
        self.field_value1 = [self stringObjectFrom:dictionary withKey:@"field_value1"];
        self.field_value2 = [self stringObjectFrom:dictionary withKey:@"field_value2"];
        self.field_value3 = [self stringObjectFrom:dictionary withKey:@"field_value3"];
        self.field_value4 = [self stringObjectFrom:dictionary withKey:@"field_value4"];
        self.field_value5 = [self stringObjectFrom:dictionary withKey:@"field_value5"];
        
        
        self.keysArray = [NSMutableArray array];
        self.valuesArray = [NSMutableArray array];
        self.productList = [NSMutableString stringWithString:@""];
        
        NSArray *array = [dictionary objectForKey:@"productList"];
        if ([array isKindOfClass:[NSArray class]]) {
            for (int i = 0 , total = [array count]; i < total; i++) {
                NSDictionary *dict = [array objectAtIndex:i];
                NSString *proName = [dict objectForKey:@"product_name"];
                [self.productList appendFormat:@"%@",proName];
                if (i != total -1) {
                    [self.productList appendString:@"\n"];
                }
            }
        }
        
        NSString *statusKey = [dictionary objectForKey:@"status"];
        if ([statusKey isEqualToString:@"0"]) {
            self.status = @"查询中";
        }
        else if ([statusKey isEqualToString:@"1"]) {
            self.status = @"处理中";
        }
        else {
            self.status = @"完成";
        }
        
        [self.keysArray addObject:@"Subject:"];
        [self.keysArray addObject:@"From:"];
        [self.keysArray addObject:@"Message:"];
        [self.keysArray addObject:@"Time:"];
        [self.keysArray addObject:@"Progress:"];
        [self.keysArray addObject:@"IP:"];
        [self.keysArray addObject:@"Country:"];
        [self.keysArray addObject:@"Regional:"];
        if ([self.productList length] > 0) {
            [self.keysArray addObject:@"Product:"];
        }
        
        [self.valuesArray addObject:self.title];
        [self.valuesArray addObject:self.username];
        [self.valuesArray addObject:self.content];
        [self.valuesArray addObject:self.sendTime];
        [self.valuesArray addObject:self.status];
        [self.valuesArray addObject:self.ip_address];
        [self.valuesArray addObject:self.country];
        [self.valuesArray addObject:self.area];
        if ([self.productList length] > 0) 
        [self.valuesArray addObject:self.productList];
    }
    
    return self;
}

- (BOOL) isItemReaded
{
    return[self.readFlag isEqualToString:@"1"];
}

@end



