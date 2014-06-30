//
//  ProductRequest.m
//  sfdl
//
//  Created by allen.wang on 6/12/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductRequest.h"


@implementation ProductTypeRequest

- (NSString *) methodString
{
    return @"Product/getProductTypeList";
}

@end

@implementation ProductListRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productTypeId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"productTypeId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.productTypeId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Product/getProductList";
}

@end

@implementation SearchProductRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productName);
    TT_RELEASE_SAFELY(_propertyId);
    TT_RELEASE_SAFELY(_propertyListId);
    TT_RELEASE_SAFELY(_propertyListValues);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"productName", nil];
    [array addObjectsFromArray: [super keyArrays]];
    if ([self.propertyId count] > 0) {
        for (int i = 0 ; i < [self.propertyId count]; i++) {
            [array addObject:[NSString stringWithFormat:@"propertyId[%d]",i]];
            [array addObject:[NSString stringWithFormat:@"propertyListId[%d]",i]];
            [array addObject:[NSString stringWithFormat:@"propertyListValue[%d]",i]];

        }
    }
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.productName ? self.productName : @"", nil];
    [array addObjectsFromArray: [super valueArrays]];
    if ([self.propertyId count] > 0) {
        for (int i = 0 ; i < [self.propertyId count]; i++) {
            [array addObject:[self.propertyId objectAtIndex:i]];
            [array addObject:[self.propertyListId objectAtIndex:i]];
            [array addObject:[self.propertyListValues objectAtIndex:i]];
        }
    }
    return array;
}

- (NSString *) methodString
{
    return @"Product/searchProduct";
}

@end


@implementation ViewProductRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"productId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.productId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Product/viewProduct";
}

@end


@implementation PromotionListRequest

- (NSString *) methodString
{
    return @"Promotion/getPromotionList";
}

@end


@implementation ViewPromotionRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_promotionId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"promotionId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.promotionId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Promotion/viewPromotion";
}

@end


@implementation PictureListRequest

- (NSString *) methodString
{
    return @"Picture/getPictureList";
}

@end


@implementation ViewPictureRequest
- (void) dealloc
{
    TT_RELEASE_SAFELY(_pictureId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"pictureId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.pictureId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Picture/viewPicture";
}
@end

@implementation VideoListRequest

- (NSString *) methodString
{
    return @"Video/getVideoList";
}
@end


@implementation ViewVideoRequest
- (void) dealloc
{
    TT_RELEASE_SAFELY(_videoId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"videoId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.videoId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Video/viewVideo";
}

@end

@implementation NewsListRequest

- (NSString *) methodString
{
    return @"News/getNewsList";
}

@end

@implementation ViewNewsRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_newsId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"newsId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.newsId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"News/viewNews";
}

@end

@implementation AgentListRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productTypeId);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_regionId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"productTypeId",@"regionId",@"name", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    if (!self.name) {
        self.name = @"";
    }
    if (!self.productTypeId) {
        self.productTypeId = @"";
    }
    if (!self.regionId) {
        self.regionId = @"";
    }
    
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.productTypeId,self.regionId,self.name, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Agent/getAgentList";
}

@end

@implementation RegionListRequest

- (NSString *) methodString
{
    return @"Agent/getRegionList";
}

@end


@implementation ViewAgentRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_agentId);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"agentId", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.agentId, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}


- (NSString *) methodString
{
    return @"Agent/viewAgent";
}
@end


@implementation OrdertListRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_sign);
    
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"companyId%@key%@page%@rows%@username%@",self.comapnyId,[UserDefaultsManager currentKey],kIntToString(self.pageno),kIntToString(self.pagesize),self.username];
    self.sign = [computeSign md5String];
    
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Enquiry/getOrderList";
}

@end

@implementation ViewOrderRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_sign);

    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"orderId",@"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"companyId%@key%@orderId%@username%@",self.comapnyId,[UserDefaultsManager currentKey],self.orderId,self.username];
    self.sign = [computeSign md5String];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.orderId,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Enquiry/viewOrder";
}
@end



@implementation CreateOrderRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_username);
    TT_RELEASE_SAFELY(_productList);
    TT_RELEASE_SAFELY(_content);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_sign);
    TT_RELEASE_SAFELY(_quantityList);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"productList",@"content",@"title",@"sign", nil];
//    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"productList",@"quantityList",@"content",@"title",@"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"companyId%@content%@key%@productList%@title%@username%@",self.comapnyId,self.content,[UserDefaultsManager currentKey],self.productList,self.title,self.username];
//    [computeSign appendFormat:@"companyId%@content%@key%@quantityList%@productList%@title%@username%@",self.comapnyId,self.content,[UserDefaultsManager currentKey],self.quantityList,self.productList,self.title,self.username];
    self.sign = [computeSign md5String];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.productList,self.content,self.title,self.sign, nil];
//    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.quantityList,self.productList,self.content,self.title,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Enquiry/createOrder";
}
@end


@implementation DeleteOrderRequest

- (NSString *) methodString
{
    return @"Enquiry/deleteOrder";
}

@end


@implementation SendMessageRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_from);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_fromCompany);
    TT_RELEASE_SAFELY(_tel);
    TT_RELEASE_SAFELY(_message);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"from", @"email", @"fromCompany", @"tel", @"message", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.from,self.email,self.fromCompany,self.tel,self.message, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Message/sendMessage";
}

@end

@implementation CommentListRequest

- (NSString *) methodString
{
    return @"Comment/getCommentsList";
}

@end

@implementation AddCommentRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_comments);
    TT_RELEASE_SAFELY(_sign);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"username",@"productId", @"comments", @"sign", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableString *computeSign = [NSMutableString string];
    [computeSign appendFormat:@"comments%@companyId%@key%@productId%@username%@",self.comments,self.comapnyId,[UserDefaultsManager currentKey],self.productId,self.username];
    self.sign = [computeSign md5String];
    NSMutableArray *array =   [NSMutableArray arrayWithObjects:self.username,self.productId,self.comments,self.sign, nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;
}

- (NSString *) methodString
{
    return @"Comment/addComments";
}

@end


@implementation MenuListRequest
- (NSString *) methodString
{
    return @"Menu/getMenuList";
}
@end



@implementation ProductPropertySearchConditions

- (NSString *) methodString
{
    return @"Product/getProductPropertySearchConditions";
}


@end