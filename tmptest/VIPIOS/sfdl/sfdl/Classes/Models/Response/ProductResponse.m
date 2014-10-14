//
//  ProductResponse.m
//  sfdl
//
//  Created by micker on 6/13/14.
//  Copyright (c) 2014 micker. All rights reserved.
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

@implementation SurportLangResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[LanguageItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"langs";
}

@end

@implementation ProductDetailResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[ProductPropsItem alloc] initWithDictionary:dictionary] autorelease];
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_productDesc);
    TT_RELEASE_SAFELY(_productName);
    TT_RELEASE_SAFELY(_productType);
    TT_RELEASE_SAFELY(_productTypeName);
    TT_RELEASE_SAFELY(_productImg);
    TT_RELEASE_SAFELY(_videoImg);
    TT_RELEASE_SAFELY(_videoUrl);
    TT_RELEASE_SAFELY(_feature);
    TT_RELEASE_SAFELY(_others);
    TT_RELEASE_SAFELY(_imagesArray);
    [super dealloc];
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    self.productId = [dictionary objectForKey:@"productId"];
    self.productName = [dictionary objectForKey:@"productName"];
    self.videoUrl = [dictionary objectForKey:@"videoUrl"];
    self.productType = [dictionary objectForKey:@"productType"];
    self.productTypeName = [dictionary objectForKey:@"productTypeName"];
    self.productDesc = [dictionary objectForKey:@"productDesc"];
    self.productImg = [dictionary objectForKey:@"productImg"];
    self.videoImg = [dictionary objectForKey:@"videoImg"];
    self.feature = [dictionary objectForKey:@"feature"];
    self.others = [dictionary objectForKey:@"others"];
    
    self.imagesArray = [NSMutableArray array];
    [self dealWithImage:@"productImg1" from:dictionary];
    [self dealWithImage:@"productImg2" from:dictionary];
    [self dealWithImage:@"productImg3" from:dictionary];
    [self dealWithImage:@"productImg4" from:dictionary];
    [self dealWithImage:@"productImg5" from:dictionary];
    return self;
}

- (void) dealWithImage:(NSString *) key from:(const NSDictionary *) dictionary
{
    NSString *images = [dictionary objectForKey:key];
    if (images && [images length] > 0) {
        [self.imagesArray addObject:images];
    }
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

@implementation RegionResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[RegionItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"regionList";
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


@implementation ViewOrderResponse

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.orderItem = [[[OrderItem alloc] initWithDictionary:[dictionary objectForKey:@"order"]] autorelease];
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_orderItem);
    [super dealloc];
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

- (void) dealloc
{
    TT_RELEASE_SAFELY(_item);
    [super dealloc];
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
    return @"propertyList";
}

@end

@implementation ProductForHomePageResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[HomeProductItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"recommendProductList";
}

- (id) translateFrom:(const NSDictionary *) dictionary
{
    self.hotArray = [self getHotResultFrom:dictionary];
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_hotArray);
    [super dealloc];
}

- (NSMutableArray *) getHotResultFrom:(const NSDictionary *) dictionary
{
    NSMutableArray *array = [dictionary objectForKey:@"hotProductList"];
    NSMutableArray *arrayResult = [NSMutableArray array];
    if ([array isKindOfClass:[NSNull class]]) {
        return arrayResult;
    }
    @autoreleasepool {
        for ( int i = 0 , total = [array count]; i < total; ++i) {
            NSDictionary *dictionary = (NSDictionary *) [array objectAtIndex:i];
            id valied = [self translateItemFrom:dictionary];
            [arrayResult addObject:valied];
        }
    }
    return arrayResult;
}

@end


@implementation BrowsingHistoryListResponse


- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[HistoryItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"historyList";
}

@end




@implementation BannerResponse


- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[BannerItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"pictureList";
}

@end


/*
 *server
 */

@implementation EnquiryListResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[EnquiryItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"enquiryList";
}

@end


@implementation ViewEnquiryResponse

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.item = [[[EnquiryItem alloc] initWithDictionary:[dictionary objectForKey:@"enquiry"]] autorelease];
    return self;
}


- (void) dealloc
{
    TT_RELEASE_SAFELY(_item);
    [super dealloc];
}

@end

@implementation ReplyEnquiryResponse

@end




@implementation CheckVersionResponse

- (void) dealloc
{
    TT_RELEASE_SAFELY(_version);
    TT_RELEASE_SAFELY(_download_url);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.version = [dictionary objectForKey:@"version"];
    self.download_url = [dictionary objectForKey:@"download_url"];
    return self;
}


- (BOOL) isNeedToTip
{
    NSString *versionTemp =  [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    if ([self.version length] > 0 && ![versionTemp isEqualToString:self.version]) {
        return YES;
    }
    return NO;
}

@end
