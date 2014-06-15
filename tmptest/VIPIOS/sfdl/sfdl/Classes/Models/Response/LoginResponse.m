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
    
    [super dealloc];
}

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        NSDictionary *company = [dictionary objectForKey:@"company_info"];
        self.companyName = [company objectForKey:@"company_name"];
        self.companyDes = [company objectForKey:@"company_desc"];
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
        self.productId = [dictionary objectForKey:@"productId"];
        self.productName = [dictionary objectForKey:@"productName"];
        self.productType = [dictionary objectForKey:@"productType"];
        self.productTypeName = [dictionary objectForKey:@"productTypeName"];
        self.productDesc = [dictionary objectForKey:@"productDesc"];
        self.productImg = [dictionary objectForKey:@"productImg"];
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
        self.abstract = [dictionary objectForKey:@"abstract"];
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


@implementation OrderItem

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.orderId = [dictionary objectForKey:@"orderId"];
        self.title = [dictionary objectForKey:@"title"];
        self.content = [dictionary objectForKey:@"content"];
        self.sendTime = [dictionary objectForKey:@"sendTime"];
        self.status = [dictionary objectForKey:@"status"];
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



