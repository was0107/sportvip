//
//  ProductCart.m
//  sfdl
//
//  Created by micker on 6/26/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "ProductCart.h"
static ProductCart * sharedInstance = nil;

@interface ProductCart()
@property (nonatomic, retain) NSMutableArray *contents;

@end

@implementation ProductCart

+(ProductCart *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_contents);
    [super dealloc];
}

- (id) init
{
    self = [super init];
    if (self) {
        [self empty];
    }
    return self;
}


- (BOOL) addProductItem:(ProductItem *)item
{
    if (!item) {
        return NO;
    }
    for (ProductItem *itemTemp in [self contents]) {
        if ([itemTemp.productId isEqualToString:item.productId]) {
            return NO;
        }
    }
    [self.contents addObject:item];
    return YES;
}

- (NSMutableArray *) products
{
    return self.contents;
}

- (void) empty
{
    self.contents = [NSMutableArray array];
}

@end
