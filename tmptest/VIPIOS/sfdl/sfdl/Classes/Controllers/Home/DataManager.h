//
//  DataManager.h
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryItem.h"

@interface DataManager : NSObject
@property (nonatomic, retain) NSMutableArray *cateArray;
@property (nonatomic, retain) NSMutableArray *distanceArray;
@property (nonatomic, retain) NSMutableArray *sortArray;

@property (nonatomic, retain) NSMutableArray *categoryAndsubArray;
@property (nonatomic, retain) NSMutableArray *areaAndLandmarkArray;

+(DataManager *)sharedInstance;

- (void) addDefaultCategory;

- (void) emptyData;

@end
