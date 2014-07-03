//
//  LoginRequest.h
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"

@interface LoginRequest : ListRequestBase

@property (nonatomic, copy)     NSString    *username;
@property (nonatomic, copy)     NSString    *password;

@end


@interface RegiseterRequest : LoginRequest

@property (nonatomic, copy)     NSString    *email;
@property (nonatomic, copy)     NSString    *title;
@property (nonatomic, copy)     NSString    *fullName;
@property (nonatomic, copy)     NSString    *userCompany;
@property (nonatomic, copy)     NSString    *tel;

@end


@interface ForgetPasswordRequest : ListRequestBase

@property (nonatomic, copy)     NSString    *username;

@end


@interface SurportLangRequest : ListRequestBase

@end


@interface SetSurportlangRequest : ForgetPasswordRequest

@end

@interface CompanyInfoRequest : ListRequestBase

@end

@interface VerifyCodeRequest : ListRequestBase

@property (nonatomic, copy) NSString *deviceId;

@end


@interface CheckVerifyCodeRequest : VerifyCodeRequest

@property (nonatomic, copy) NSString *verifyCode;

@end



