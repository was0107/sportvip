//
//  PaggingItem.h
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListResponseItemBase.h"
#import "ListResponseBase.h"

//
//advantage: ""
//age: [ ]
//coachId: 1
//description: ""
//name: ""
//price: 123
//schoolTime: "每周六周日下午"


@interface CourseItem : ListResponseItemBase
@property (nonatomic, copy) NSString *advantage,*coachId,*description,*name,*schoolTime,*priceString,*coachName;
@end




@interface PaggingItem : ListResponseItemBase
@property (nonatomic, copy) NSString *itemId;
@end



@interface EventTagItem : PaggingItem
@property (nonatomic, copy) NSString *icon,*name;
@end


@interface GymnasiumItem : PaggingItem
@property (nonatomic, copy) NSString *address,*name, *priceString, *distanceString;
@property (nonatomic, retain) NSMutableArray *pictures, *tags, *events;
@property (nonatomic, assign) float distance, minPrice, maxPrice;

@end



@interface GymnasiumDetailResponse : ListResponseBase

@property (nonatomic, copy) NSString *itemId,*address,*name,*descriptionString,*introduction,*resume;
@property (nonatomic, retain) NSMutableArray *pictures, *tags, *events,*phones,*hornors,*coaches,*courses;
@property (nonatomic, assign) float distance, lantitude, longtitudee;
@end





@interface CoacheItem : PaggingItem

@property (nonatomic, copy) NSString *address,*name,*avatar,*certificate, *priceString, *distanceString;
@property (nonatomic, retain) NSMutableArray *phones, *tags, *hornors;
@property (nonatomic, assign) float distance, minPrice, lantitude, longtitude;
@property (nonatomic, assign) int zan, age;

//detail item
@property (nonatomic, copy) NSString *resume,*introduction;
@property (nonatomic, retain) NSMutableArray *courses;
@end


@interface CoacheDetailResponse : ListResponseBase

@property (nonatomic, copy) NSString *itemId,*avatar,*name,*introduction,*resume;
@property (nonatomic, retain) NSMutableArray *tags,*phones,*hornors,*courses;
@property (nonatomic, assign) float lantitude, longtitude;
@property (nonatomic, assign) int age;
@end


/*
address: ""
age: 32
ageRange: [ ]
avatar: http://www.baidu.com/favicon.ico
certificate: "国家二级"
distance: 7106905.87
honors: [ ]
id: 1
-location: {
x: 116.12
y: 35.3
}
minPrice: 0
name: "王教练"
phones: [ ]
-tags: [
        -{
        icon: http://www.baidu.com/favicon.ico
            id: 23
        name: "新"
        }
        ]
zan: 12
*/