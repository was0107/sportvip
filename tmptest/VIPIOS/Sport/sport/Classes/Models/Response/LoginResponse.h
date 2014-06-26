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
@property (nonatomic, copy)   NSString  *advantage,*age,*coachName,*description,*name,*price,*schoolTime;                     // *(String)：操作中文信息描述



@end