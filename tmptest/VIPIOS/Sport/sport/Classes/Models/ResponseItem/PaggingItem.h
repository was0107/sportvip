//
//  PaggingItem.h
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListResponseItemBase.h"

@interface PaggingItem : ListResponseItemBase

@end



@interface EventTagItem : ListResponseItemBase
@property (nonatomic, copy) NSString *itemId, *icon,*name;
@end


@interface GymnasiumItem : ListResponseItemBase
@property (nonatomic, copy) NSString *address,*name, *priceString, *distanceString;
@property (nonatomic, retain) NSMutableArray *pictures, *tags, *events;
@property (nonatomic, assign) float distance, minPrice, maxPrice;

@end



@interface CoacheItem : ListResponseItemBase

@property (nonatomic, copy) NSString *address,*name,*avatar,*certificate, *priceString, *distanceString;
@property (nonatomic, retain) NSMutableArray *phones, *tags, *hornors;
@property (nonatomic, assign) float distance, minPrice, lantitude, longtitude;
@property (nonatomic, assign) int zan, age;
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