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
@property(nonatomic, copy)NSString * email;
@property(nonatomic, assign)long birthday;
@property(nonatomic, assign)long createTime;

//avatar: http://s0.hao123img.com/res/img/logo/souju-24.png
//birthday: 1392188785133
//createTime: 1401790692000
//gender: "MALE"
//id: 1
//nickName: "昵称"


@end



