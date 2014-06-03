//
//  LoginRequest.h
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"

@interface LoginRequest : ListRequestBase


/**
 * username*(String)：用户名
 * password*(String): 密码
 */
@property (nonatomic, copy)     NSString    *email;
@property (nonatomic, copy)     NSString    *password;

@end


//获取启动页面图片
@interface GuidePictureRequest : ListRequestBase
@property (nonatomic, copy)     NSString    *screenSize;

@end


//上传APN TOKEN接口
@interface UpdateAPNTokenRequest : ListRequestWithUserIDBase
@property (nonatomic, copy) NSString *deviceToken;
@end



@interface ForgetPasswordRequest : ListRequestBase
@property (nonatomic, copy)     NSString    *email;

@end


@interface UpdatePasswordRequest : ListRequestWithUserIDBase
@property (nonatomic, copy)     NSString    *password;
@property (nonatomic, copy)     NSString    *theNewPassword;

@end