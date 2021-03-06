//
//  ServerLoginViewController.m
//  sport
//
//  Created by micker on 5/20/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "ServerLoginViewController.h"
#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "CreateObject.h"
#import "EnquiryListViewController.h"

@interface ServerLoginViewController ()
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) PubTextField *pwdTextField;
@property (nonatomic, retain) UIButton     *confirmButton, *forgetButton, *newButton;

@end

@implementation ServerLoginViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_phoneTextField);
    TT_RELEASE_SAFELY(_pwdTextField);
    TT_RELEASE_SAFELY(_confirmButton);
    TT_RELEASE_SAFELY(_forgetButton);
    TT_RELEASE_SAFELY(_newButton);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"LOGIN"];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.pwdTextField];
//    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.confirmButton];
//    [self.view addSubview:self.newButton];
    
#ifdef kUseSimulateData
    self.phoneTextField.pubTextField.text = @"shoufan";
    self.pwdTextField.pubTextField.text = @"shoufan";
#endif
}

- (PubTextField *)phoneTextField
{
    if (!_phoneTextField) {
        __block typeof(self) safeSelf = self;
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + kImageStartAt, 320, 40) indexTitle:@"Name:" placeHolder:@"Name" pubTextFieldStyle:PubTextFieldStyleTop];
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
        __block typeof(self) safeSelf = self;
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
        _newButton.frame = CGRectMake(150.0f, 166.0f + kImageStartAt + 50, 140.0f, 30.0f);
        _newButton.backgroundColor = kClearColor;
        [_newButton setTitleColor:kButtonNormalColor forState:UIControlStateNormal];
        [_newButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [_newButton setTitle:@"New user? Join Now>" forState:UIControlStateNormal];
        [_newButton addTarget:self action:@selector(newButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _newButton;
}

- (IBAction)forgetButtonAction:(id)sender
{
//    [self.pwdTextField resignFirstResponder];
//    [self.phoneTextField resignFirstResponder];
//    ForgetPasswordViewController *controller = [[[ForgetPasswordViewController alloc] init] autorelease];
//    [controller setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)newButtonAction:(id)sender
{
//    [self.pwdTextField resignFirstResponder];
//    [self.phoneTextField resignFirstResponder];
//    
//    RegisterViewController *controller = [[[RegisterViewController alloc] init] autorelease];
//    [controller setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:controller animated:YES];
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
//    
//    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
//        [_pwdTextField becomeFirstResponder];
//        return NO;
//    }
//
    if ([self.phoneTextField.pubTextField.text length ] == 0 ||
        [self.pwdTextField.pubTextField.text length] == 0) {
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
    [SVProgressHUD showWithStatus:@"Logining..."];
    [self.confirmButton setEnabled:NO];

    __block typeof(self) safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        [UserDefaultsManager saveUserId:response.key];
        [UserDefaultsManager saveUserName:_phoneTextField.pubTextField.text];
        [UserDefaultsManager saveKey:response.key];
        [safeSelf.confirmButton setEnabled:YES];
        [SVProgressHUD dismiss];

        EnquiryListViewController *controller = [[[EnquiryListViewController alloc] init] autorelease];
        [controller setHidesBottomBarWhenPushed:YES];
        [safeSelf.navigationController pushViewController:controller animated:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
//        EnquiryListViewController *controller = [[[EnquiryListViewController alloc] init] autorelease];
//        [controller setHidesBottomBarWhenPushed:YES];
//        [safeSelf.navigationController pushViewController:controller animated:YES];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
        [safeSelf.confirmButton setEnabled:YES];
//        EnquiryListViewController *controller = [[[EnquiryListViewController alloc] init] autorelease];
//        [controller setHidesBottomBarWhenPushed:YES];
//        [safeSelf.navigationController pushViewController:controller animated:YES];
    };
    
    ServerLoginRequest *request = [[[ServerLoginRequest alloc] init] autorelease];
    request.username    = _phoneTextField.pubTextField.text;
    request.password = _pwdTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}



@end
