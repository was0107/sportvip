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



@interface ForgetPasswordRequest : ListRequestBase
@property (nonatomic, copy)     NSString    *email;

@end


@interface UpdatePasswordRequest : ForgetPasswordRequest
@property (nonatomic, copy)     NSString    *password;
@property (nonatomic, copy)     NSString    *theNewPassword;

@end

@interface UpdateUserInfoRequest : ListRequestBase
@property (nonatomic, assign) BOOL isUpdate;
@property (nonatomic, retain) NSMutableArray *keys,*values;
@end

