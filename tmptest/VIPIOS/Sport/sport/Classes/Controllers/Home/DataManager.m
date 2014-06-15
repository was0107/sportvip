//
//  DataManager.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "DataManager.h"

static DataManager * sharedInstance = nil;

@implementation DataManager

@synthesize sortArray       = _sortArray;
@synthesize distanceArray   = _distanceArray;
@synthesize cateArray       = _cateArray;

@synthesize categoryAndsubArray = _categoryAndsubArray;
@synthesize areaAndLandmarkArray = _areaAndLandmarkArray;

+(DataManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self createSort];
        [self createDistance];
        [self addDefaultCategory];
        [self configAreaAndLandmark];
        [self configCategoryAndSub];
    }
    return self;
}

- (void) createSort
{
    CategoryItem *item1 = [[[CategoryItem alloc] init] autorelease];
    item1.categoryId = @"1";
    item1.categoryName = @"乒乓";
    
    CategoryItem *item2 = [[[CategoryItem alloc] init] autorelease];
    item2.categoryId = @"2";
    item2.categoryName = @"篮球";
    
    CategoryItem *item3 = [[[CategoryItem alloc] init] autorelease];
    item3.categoryId = @"3";
    item3.categoryName = @"网球";
    
    CategoryItem *item4 = [[[CategoryItem alloc] init] autorelease];
    item3.categoryId = @"4";
    item3.categoryName = @"游泳";
    
    CategoryItem *item5 = [[[CategoryItem alloc] init] autorelease];
    item3.categoryId = @"5";
    item3.categoryName = @"羽毛";
    
    self.sortArray = [NSMutableArray arrayWithObjects:item1, item2, item3,item4, item5, nil];
}

- (void) createDistance
{
    CategoryItem *item1 = [[[CategoryItem alloc] init] autorelease];
    item1.categoryId = @"1000";
    item1.categoryName = @"1000米";

    CategoryItem *item2 = [[[CategoryItem alloc] init] autorelease];
    item2.categoryId = @"2000";
    item2.categoryName = @"2000米";

    CategoryItem *item3 = [[[CategoryItem alloc] init] autorelease];
    item3.categoryId = @"5000";
    item3.categoryName = @"5000米";

    CategoryItem *item4 = [[[CategoryItem alloc] init] autorelease];
    item4.categoryId = @"-1";
    item4.categoryName = @"全城";
    self.distanceArray = [NSMutableArray arrayWithObjects:item1, item2, item3, item4, nil];
}

- (void) addDefaultCategory
{
    CategoryItem *item = [[[CategoryItem alloc] init] autorelease];
    item.categoryId = @"-1";
    item.categoryName = @"分类";
    self.cateArray = [NSMutableArray arrayWithObject:item];
}

- (void) emptyData
{
    [self addDefaultCategory];
    [self configCategoryAndSub];
    [self configAreaAndLandmark];
}

-(void)configCategoryAndSub
{
//    CategoryItem *item = [[[CategoryItem alloc] init] autorelease];
//    item.categoryId = @"-1";
//    item.categoryName = @"分类";
//    
//    SubCategoryItem *subItem = [[[SubCategoryItem alloc] init] autorelease];
//    subItem.categoryId = @"";
//    subItem.subcategoryName = @"分类";
//    subItem.subcategoryId = @"-1";
//    
//    NSMutableArray *array = [NSMutableArray arrayWithObject:subItem];
//    
//    CategoryAndSubCategoryItem * cateItem = [[[CategoryAndSubCategoryItem alloc] init] autorelease];
//    cateItem.categoryItem = item;
//    cateItem.subCategoryArray = array;
//    
//    self.categoryAndsubArray = [NSMutableArray arrayWithObject:cateItem];
    
    self.categoryAndsubArray = [NSMutableArray array];
    for (int i = 0 ; i < 20; i++) {
        CategoryItem *item4 = [[[CategoryItem alloc] init] autorelease];
        item4.categoryId = kIntToString(i);
        item4.categoryName = [NSString stringWithFormat:@"%d岁", i ];
        [self.categoryAndsubArray addObject:item4];
    }
}

-(void)configAreaAndLandmark
{
//    AreaItem *item = [[[AreaItem alloc] init] autorelease];
//    item.cityAreaId = @"-1";
//    item.cityAreaName = @"区域";
//    item.cityId = @"";
//    
//    LandmarkItem *subItem = [[[LandmarkItem alloc] init] autorelease];
//    subItem.landmarkId = @"-1";
//    subItem.landmarkName = @"区域";
//    
//    NSMutableArray *array = [NSMutableArray arrayWithObject:subItem];
//    
//    AreaAndLandmarkItem  * cateItem = [[[AreaAndLandmarkItem alloc] init] autorelease];
//    cateItem.cityArea = item;
//    cateItem.landmarkArray = array;
//    self.areaAndLandmarkArray = [NSMutableArray arrayWithObject:cateItem];
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_sortArray);
    TT_RELEASE_SAFELY(_cateArray);
    TT_RELEASE_SAFELY(_distanceArray);
    
    TT_RELEASE_SAFELY(_categoryAndsubArray);
    TT_RELEASE_SAFELY(_areaAndLandmarkArray);
    [super dealloc];
}
@end
