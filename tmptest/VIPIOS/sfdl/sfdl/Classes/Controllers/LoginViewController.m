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
#import "ForgetPasswordViewController.h"


@interface LoginViewController ()
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) PubTextField *pwdTextField;
@property (nonatomic, retain) UIButton     *confirmButton, *forgetButton, *newButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"SIGN IN"];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.confirmButton];
//    [self.view addSubview:self.newButton];
    
    [[[self showRight] rightButton] setTitle:@"Join" forState:UIControlStateNormal];
#ifdef kUseSimulateData
    self.phoneTextField.pubTextField.text = @"Username";
    self.pwdTextField.pubTextField.text = @"Password";
#endif
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
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + kImageStartAt, 320, 40) indexTitle:@"Name:" placeHolder:@"Member ID or Email" pubTextFieldStyle:PubTextFieldStyleTop];
        _phoneTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _phoneTextField.pubTextField.frame = CGRectMake(0, 0, 250, 40);
        _phoneTextField.autoLayout = YES;
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
        _pwdTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 51 + kImageStartAt, 320, 40) indexTitle:@"Password:" placeHolder:@"Password" pubTextFieldStyle:PubTextFieldStyleBottom];
        _pwdTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.pubTextField.frame = CGRectMake(0, 0, 250, 40);
        _pwdTextField.pubTextField.secureTextEntry = YES;
        _pwdTextField.autoLayout = YES;
        [_pwdTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_pwdTextField resignFirstResponder];
            return YES;
        }];
    }
    return _pwdTextField;
}

- (UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _forgetButton.frame = CGRectMake(90.0f, 137 + 20, 290.0f, 40.0f);
        _forgetButton.backgroundColor = kClearColor;
        [_forgetButton setTitleColor:kButtonNormalColor forState:UIControlStateNormal];
        [_forgetButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        _forgetButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_forgetButton setTitle:@"Forget Password?" forState:UIControlStateNormal];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(76, 30, 138, 1.0f);
        layer.backgroundColor = [kOrangeColor CGColor];
        [_forgetButton.layer addSublayer:layer];
        [_forgetButton addTarget:self action:@selector(forgetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _forgetButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(0.0f, 96.0f + 20, 320.0f, 40.0f);
        _confirmButton.backgroundColor = kClearColor;
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}


- (UIButton *)newButton
{
    if (!_newButton) {
        _newButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _newButton.frame = CGRectMake(115.0f, 166.0f + kImageStartAt + 50, 175.0f, 30.0f);
        _newButton.backgroundColor = kClearColor;
        [_newButton setTitleColor:kButtonNormalColor forState:UIControlStateNormal];
        [_newButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_newButton setTitle:@"New user? Join Now>" forState:UIControlStateNormal];
        [_newButton addTarget:self action:@selector(newButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _newButton;
}

- (IBAction)forgetButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    ForgetPasswordViewController *controller = [[[ForgetPasswordViewController alloc] init] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)newButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    
    RegisterViewController *controller = [[[RegisterViewController alloc] init] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (IBAction)confirmButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self requestServerForLogin:sender];
}


- (BOOL)checkTextField
{
//    if (![IdentifierValidator isValid:IdentifierTypePhone value:_phoneTextField.pubTextField.text] &&
//        ![IdentifierValidator isValid:IdentifierTypeEmail value:_phoneTextField.pubTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号/邮箱"];
//        [_phoneTextField becomeFirstResponder];
//        return NO;
//    }
    
//    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
//        [_pwdTextField becomeFirstResponder];
//        return NO;
//    }
    
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
        [UserDefaultsManager saveUserId:response.key];
        [UserDefaultsManager saveUserName:_phoneTextField.pubTextField.text];
        [UserDefaultsManager saveUserEmail:response.userItem.email];
        [UserDefaultsManager saveKey:response.key];
        [safeSelf.confirmButton setEnabled:YES];
        [SVProgressHUD dismiss];
        [safeSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    LoginRequest *request = [[[LoginRequest alloc] init] autorelease];
    request.username    = _phoneTextField.pubTextField.text;
    request.password = _pwdTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}



@end
