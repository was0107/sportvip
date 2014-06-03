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

@interface LoginViewController ()
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) PubTextField *pwdTextField;
@property (nonatomic, retain) UIButton     *confirmButton;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"登录"];
    [[[self showRight] rightButton] setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.confirmButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 15, 304, 40) indexTitle:@"手机号" placeHolder:@"请输入手机号" pubTextFieldStyle:PubTextFieldStyleTop];
        _phoneTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _phoneTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
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
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (IBAction)confirmButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self requestServerForLogin:sender];
}


- (BOOL)checkTextField
{
    if (![IdentifierValidator isValid:IdentifierTypeEmail value:_phoneTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        [_phoneTextField becomeFirstResponder];
        return NO;
    }
    
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
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
//    [SVProgressHUD showWithStatus:@"正在登录..."];
//    
//    [self.loginButton setEnabled:NO];
//    __unsafe_unretained LoginViewController *safeSelf = self;
//    
//    idBlock succBlock = ^(id content){
//        DEBUGLOG(@"succ content %@", content);
//        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
//        
//        [UserDefaultsManager saveUserName:response.userItem.nickName];
//        [UserDefaultsManager saveUserId:response.userItem.userId];
//        [UserDefaultsManager saveUserEmail:response.userItem.email];
//        [UserDefaultsManager saveUserIcon:response.userItem.avatar];
//        [UserDefaultsManager saveUserAge:response.userItem.age];
//        [UserDefaultsManager saveUserBirthDay:response.userItem.birthday];
//        [UserDefaultsManager saveUserGender:response.userItem.gender];
//        
//        if (response.userItem.skinTested)
//        {
//            [UserDefaultsManager saveUserSkin:response.userItem.userSkin];
//        }
//        
//        [UserDefaultsManager saveUserLogin:YES];
//        [SVProgressHUD dismiss];
//        [safeSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
//        [safeSelf.loginButton setEnabled:YES];
//    };
//    
//    idBlock failedBlock = ^(id content){
//        DEBUGLOG(@"failed content %@", content);
//        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
//        [safeSelf.loginButton setEnabled:YES];
//    };
//    idBlock errBlock = ^(id content){
//        DEBUGLOG(@"failed content %@", content);
//        [SVProgressHUD showErrorWithStatus:@"登录失败"];
//        [safeSelf.loginButton setEnabled:YES];
//    };
//    
//    LoginRequest *request = [[[LoginRequest alloc] init] autorelease];
//    request.email    = _userMailField.text;
//    request.password = _userPwdField.text;
//    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}



@end
