//
//  ProductResponse.m
//  sfdl
//
//  Created by allen.wang on 6/13/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductResponse.h"



@implementation ProductTypeReponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[ProductTypeItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"productTypeList";
}
@end



@implementation ProductResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[ProductItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"productList";
}

@end

@implementation ProductDetailResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[ProductPropsItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"productProps";
}

@end

@implementation PictureResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[PictureItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"pictureList";
}

@end

@implementation VideoResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[PictureItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"videoList";
}

@end


@implementation NewsResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[NewsItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"newsList";
}

@end



@implementation AgentResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[AgentItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"agentList";
}

@end


@implementation OrdersResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[OrderItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"orderList";
}

@end

@implementation CommentsResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[CommentItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"commentsList";
}

@end

@implementation NewsDetailResponse

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.item = [[[NewsItem alloc] initWithDictionary:dictionary] autorelease];
    return self;
}

@end

@implementation MenuResponse


- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[MenuItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"items";
}

@end



@implementation ProductPropertySearchResponse


- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[ProperItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"items";
}

@end