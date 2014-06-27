//
//  UserItemBase.h
//  GoDate
//
//  Created by allen.wang on 8/5/13.
//  Copyright (c) 2013 www.b5m.com. All rights reserved.
//

#import "ListResponseItemBase.h"


@interface UserItemBase : ListResponseItemBase

@property(nonatomic, copy)NSString * userId;
@property(nonatomic, copy)NSString * nickName;
@property(nonatomic, copy)NSString * gender;
@property(nonatomic, copy)NSString * avatar;
@property(nonatomic, copy)NSString * email, *phone;
@property(nonatomic, assign)long birthday;
@property(nonatomic, assign)long createTime;


@end



