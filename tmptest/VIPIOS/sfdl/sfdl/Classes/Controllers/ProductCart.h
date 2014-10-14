//
//  ProductCart.h
//  sfdl
//
//  Created by micker on 6/26/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResponse.h"


@interface ProductCart : NSObject

+(ProductCart *)sharedInstance;

- (BOOL) addProductItem:(ProductItem *)item;

- (NSMutableArray *) products;

- (void) empty;

@end