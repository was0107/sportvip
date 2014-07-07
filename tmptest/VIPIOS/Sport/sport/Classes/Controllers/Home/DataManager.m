//
//  DataManager.m
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "DataManager.h"
#import "ChineseToPinyin.h"

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
        self.serviceTels = [NSMutableArray array];
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
    CategoryItem *item6 = [[[CategoryItem alloc] init] autorelease];
    item6.categoryId = @"";
    item6.categoryName = @"全部";
    self.sortArray = [NSMutableArray arrayWithObjects:item6, nil];
}

- (void) resetSortArray:(EventsResponse *) response
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0, total = response.count; i < total; i++) {
        EventTagItem * tagItem = [response at:i];
        CategoryItem *item1 = [[[CategoryItem alloc] init] autorelease];
        item1.categoryId = tagItem.itemId;
        item1.categoryName = tagItem.name;
        [array addObject:item1];
    }
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        CategoryItem *test1 = obj1;
        CategoryItem *test2 = obj2;
        NSString *name1 = [ChineseToPinyin pinyinFromChiniseString:test1.categoryName ];
        NSString *name2 = [ChineseToPinyin pinyinFromChiniseString:test2.categoryName ];
        return [name1 compare:name2];
    }];
    
    CategoryItem *item6 = [[[CategoryItem alloc] init] autorelease];
    item6.categoryId = @"";
    item6.categoryName = @"全部";
    [array addObject:item6];
    self.sortArray = array;
}

- (void) createDistance
{
    
    CategoryItem *item4 = [[[CategoryItem alloc] init] autorelease];
    item4.categoryId = @"";
    item4.categoryName = @"全城";
    
    CategoryItem *item1 = [[[CategoryItem alloc] init] autorelease];
    item1.categoryId = @"1000";
    item1.categoryName = @"1000米";

    CategoryItem *item2 = [[[CategoryItem alloc] init] autorelease];
    item2.categoryId = @"2000";
    item2.categoryName = @"2000米";

    CategoryItem *item3 = [[[CategoryItem alloc] init] autorelease];
    item3.categoryId = @"5000";
    item3.categoryName = @"5000米";

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
    NSArray *keyArray = [NSArray arrayWithObjects:@"YOUER",@"XIAOXUE",@"CHUZHONG",@"GAOZHONG",@"CHENGREN",@"",nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"幼儿",@"小学",@"初中",@"高中",@"成人",@"全部",nil];
    self.categoryAndsubArray = [NSMutableArray array];
    for (int i = 0 ; i < 6; i++) {
        CategoryItem *item = [[[CategoryItem alloc] init] autorelease];
        item.categoryId = [keyArray objectAtIndex:i];
        item.categoryName = [titleArray objectAtIndex:i];
        [self.categoryAndsubArray addObject:item];
    }
}

-(void)configAreaAndLandmark
{
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_sortArray);
    TT_RELEASE_SAFELY(_cateArray);
    TT_RELEASE_SAFELY(_distanceArray);
    TT_RELEASE_SAFELY(_serviceTels);
    TT_RELEASE_SAFELY(_categoryAndsubArray);
    TT_RELEASE_SAFELY(_areaAndLandmarkArray);
    [super dealloc];
}
@end
