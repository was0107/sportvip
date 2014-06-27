//
//  LoginViewController.m
//  sport
//
//  Created by allen.wang on 5/20/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "LoginViewController.h"
#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "RegisterViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "CreateObject.h"
#import "CustomAnimation.h"
#import "ForgetPWDViewController.h"

@interface LoginViewController ()
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) PubTextField *pwdTextField;
@property (nonatomic, retain) UIButton     *confirmButton,*forgetButton;

@end

@implementation LoginViewController


- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_phoneTextField);
    TT_RELEASE_SAFELY(_pwdTextField);
    TT_RELEASE_SAFELY(_confirmButton);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"登录"];
    [[[self showRight] rightButton] setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.forgetButton];
    
#ifdef kUseSimulateData
    self.phoneTextField.pubTextField.text = @"13611111111";
    self.pwdTextField.pubTextField.text = @"111111";
#endif

}

- (void) rightButtonAction:(id)sender
{
    RegisterViewController *controller = [[[RegisterViewController alloc] init] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (PubTextField *)phoneTextField
{
    if (!_phoneTextField) {
        __unsafe_unretained LoginViewController *safeSelf = self;
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 15, 304, 40) indexTitle:@"帐号" placeHolder:@"请输入手机号/邮箱" pubTextFieldStyle:PubTextFieldStyleTop];
        _phoneTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        [_phoneTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _phoneTextField;
}

- (PubTextField *)pwdTextField
{
    if (!_pwdTextField) {
        __block LoginViewController *safeSelf = self;
        _pwdTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 62, 304, 40) indexTitle:@"密码" placeHolder:@"6-16位的字母和数字组成" pubTextFieldStyle:PubTextFieldStyleBottom];
        _pwdTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.pubTextField.secureTextEntry = YES;
        [_pwdTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_pwdTextField resignFirstResponder];
            return YES;
        }];
    }
    return _pwdTextField;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(8.0f, 120.0f, 304.0f, 40.0f);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        UIImage *image = [[UIImage imageNamed:@"button_login_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [_confirmButton setBackgroundImage:image forState:UIControlStateNormal];
        [_confirmButton setTitle:@"登录" forState:UIControlStateNormal];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _forgetButton.frame = CGRectMake(210.0f, 165.0f, 100.0f, 40.0f);
        _forgetButton.backgroundColor = kLightGrayColor;
        [_forgetButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        UIImage *image = [[UIImage imageNamed:@"button_login_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [_forgetButton setBackgroundImage:image forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [CreateObject addTargetEfection:_forgetButton];
        [_forgetButton addTarget:self action:@selector(forgetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (IBAction)confirmButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self requestServerForLogin:sender];
}

- (IBAction)forgetButtonAction:(id)sender
{
    ForgetPWDViewController *controller = [[[ForgetPWDViewController alloc] init] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (BOOL)checkTextField
{
    if (![IdentifierValidator isValid:IdentifierTypePhone value:_phoneTextField.pubTextField.text] &&
        ![IdentifierValidator isValid:IdentifierTypeEmail value:_phoneTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号/邮箱"];
        [CustomAnimation shakeAnimation:_phoneTextField duration:0.2 vigour:0.01 number:5  direction:1];
        [_phoneTextField becomeFirstResponder];
        return NO;
    }
    
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
        [CustomAnimation shakeAnimation:_pwdTextField duration:0.2 vigour:0.01 number:5  direction:1];
        [_pwdTextField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)requestServerForLogin:(id)sender
{
    [self.view endEditing:YES];
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    [SVProgressHUD showWithStatus:@"正在登录..."];
    [self.confirmButton setEnabled:NO];

    __unsafe_unretained LoginViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        
        [UserDefaultsManager saveUserName:response.userItem.nickName];
        [UserDefaultsManager saveUserId:response.userItem.userId];
        [UserDefaultsManager saveUserEmail:response.userItem.email];
        [UserDefaultsManager saveUserTel:response.userItem.phone];
        [UserDefaultsManager saveUserIcon:response.userItem.avatar];
        [UserDefaultsManager saveUserBirthDay:response.userItem.birthday];
        [UserDefaultsManager saveUserGender:response.userItem.gender];
        
//        [UserDefaultsManager saveUserLogin:YES];
        [safeSelf.confirmButton setEnabled:YES];
        [SVProgressHUD dismiss];
        [safeSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    LoginRequest *request = [[[LoginRequest alloc] init] autorelease];
    request.email    = _phoneTextField.pubTextField.text;
    request.password = _pwdTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}



@end
