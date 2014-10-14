//
//  LoginRequest.h
//  taoappios
//
//  Created by Eason on 5/14/13.
//  Copyright (c) 2013 micker. All rights reserved.
//

#import "ListRequestBase.h"

@interface LoginRequest : ListRequestBase

@property (nonatomic, copy)     NSString    *username;
@property (nonatomic, copy)     NSString    *password;

@end



@interface ServerLoginRequest : LoginRequest

@end




@interface RegiseterRequest : LoginRequest

@property (nonatomic, copy)     NSString    *email;

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



