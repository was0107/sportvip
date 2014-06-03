//
//  CategoryItem.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "CategoryItem.h"


//获取大分类item
@implementation CategoryItem
@synthesize categoryId       = _categoryId;
@synthesize categoryName     = _categoryName;

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.categoryId = [dictionary objectForKey:@"categoryId"];
        self.categoryName = [dictionary objectForKey:@"categoryName"];
    }
    
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_categoryId);
    TT_RELEASE_SAFELY(_categoryName);
    [super dealloc];
}
@end

//获取子分类item
@implementation SubCategoryItem
@synthesize categoryId          = _categoryId;
@synthesize subcategoryId       = _subcategoryId;
@synthesize subcategoryName     = _subcategoryName;

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.categoryId = [dictionary objectForKey:@"categoryId"];
        self.subcategoryId = [dictionary objectForKey:@"subcategoryId"];
        self.subcategoryName = [dictionary objectForKey:@"subcategoryName"];
    }
    
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_categoryId);
    TT_RELEASE_SAFELY(_subcategoryId);
    TT_RELEASE_SAFELY(_subcategoryName);
    [super dealloc];
}
@end

//获取分类和子分类item

@implementation CategoryAndSubCategoryItem
@synthesize categoryItem  = _categoryItem;
@synthesize subCategoryArray  = _subCategoryArray;

- (id)initWithDictionary:(const NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    
    if (self) {
        self.subCategoryArray = [[[NSMutableArray alloc]init]autorelease];
        self.categoryItem = [[ CategoryItem alloc]initWithDictionary:[dictionary objectForKey:@"category"]];
        NSArray * array = [dictionary objectForKey:@"subcategory"];
        for (int i = 0; i < [array count]; i++) {
            NSDictionary * landMarkDictionary = [array objectAtIndex:i];
            SubCategoryItem * item = [[[SubCategoryItem alloc]initWithDictionary:landMarkDictionary]autorelease];
            [_subCategoryArray addObject:item];
        }
    }
    
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_categoryItem);
    TT_RELEASE_SAFELY(_subCategoryArray);
    [super dealloc];
}
@end
