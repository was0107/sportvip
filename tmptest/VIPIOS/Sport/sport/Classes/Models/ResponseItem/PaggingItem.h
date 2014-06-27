//
//  PaggingItem.h
//  sport
//
//  Created by allen.wang on 6/16/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ListResponseItemBase.h"
#import "ListResponseBase.h"

@interface CourseItem : ListResponseItemBase
@property (nonatomic, copy) NSString *advantage,*courseId,*coachId,*description,*name,*schoolTime,*priceString,*coachName;
@end

@interface TelItem : ListResponseItemBase
@property (nonatomic, copy) NSString *coachId,*name,*avatar,*tel;

+(TelItem *) hotItem;

@end

@interface HornorItem : ListResponseItemBase
@property (nonatomic, copy) NSString *year,*honor;

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
@property (nonatomic, assign) float distance, minPrice, maxPrice, lantitude, longtitude;

@end



@interface GymnasiumDetailResponse : ListResponseBase

@property (nonatomic, copy) NSString *itemId,*address,*name,*descriptionString,*introduction,*resume;
@property (nonatomic, retain) NSMutableArray *pictures, *tags, *events,*phones,*hornors,*coaches,*courses;
@property (nonatomic, assign) float distance, lantitude, longtitude;
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

@interface CityItem : ListResponseItemBase
@property (nonatomic, copy) NSString *cityCode,*cityName;
@end


@interface CheckClassItem : ListResponseItemBase
@property (nonatomic, copy) NSString *itemId,*coachId,*address,*name,*coachName,*coachAvatar;
@property (nonatomic, copy) NSString *advantage,*introduction,*price,*schoolTime;


@end