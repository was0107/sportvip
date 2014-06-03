//
//  CategoryItem.h
//  sport
//
//  Created by allen.wang on 5/19/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListResponseItemBase.h"

//获取大分类item
@interface CategoryItem : ListResponseItemBase

@property(nonatomic, copy)NSString *categoryId;          //分类Id
@property(nonatomic, copy)NSString *categoryName;        //分类名字


@end

//获取子分类item
@interface SubCategoryItem : ListResponseItemBase
@property(nonatomic, copy)NSString *categoryId;             //分类Id
@property(nonatomic, copy)NSString *subcategoryId;          //子分类Id
@property(nonatomic, copy)NSString *subcategoryName;        //子分类名字

@end

//获取分类和子分类item
@interface CategoryAndSubCategoryItem : ListResponseItemBase

@property(nonatomic, retain)CategoryItem          *categoryItem;          //分类
@property(nonatomic, retain)NSMutableArray        *subCategoryArray;      //子分类

@end
