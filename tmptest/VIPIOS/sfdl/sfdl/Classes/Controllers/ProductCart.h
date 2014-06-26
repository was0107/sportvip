//
//  ProductCart.h
//  sfdl
//
//  Created by allen.wang on 6/26/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResponse.h"


@interface ProductCart : NSObject

+(ProductCart *)sharedInstance;

- (BOOL) addProductItem:(ProductItem *)item;

- (NSMutableArray *) products;


@end