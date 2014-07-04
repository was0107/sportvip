//
//  LoginResponse.h
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "ListResponseBase.h"
#import "UserItemBase.h"

#pragma mark
#pragma mark 用户基本资料
@interface LoginResponse : ListResponseBase

@property (nonatomic, retain) UserItemBase *userItem;

@end


@interface ClassDetailResponse : ListResponseBase
@property (nonatomic, copy)   NSString   *advantage,*age,*coachName,*description,*coachAvatar;
@property (nonatomic, copy)   NSString   *name,*price,*schoolTime,*coachId,*address,*gymnasiumName;
@property (nonatomic, retain) NSMutableArray *phones;



@end

@interface ServicePhoneResponse : ListResponseBase
@property (nonatomic, copy) NSString     *phone;

@end