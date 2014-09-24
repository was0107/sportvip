//
//  ForgetPasswordViewController.m
//  sfdl
//
//  Created by allen.wang on 7/1/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ForgetPasswordViewController.h"

#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "RegisterViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "CreateObject.h"
#import "ForgetPasswordViewController.h"


@interface ForgetPasswordViewController ()
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) UIButton     *confirmButton;

@end

@implementation ForgetPasswordViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_phoneTextField);
    TT_RELEASE_SAFELY(_confirmButton);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"Forget password"];
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.confirmButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PubTextField *)phoneTextField
{
    if (!_phoneTextField) {
        __weak ForgetPasswordViewController *safeSelf = self;
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 15 , 320, 40) indexTitle:@"Name:" placeHolder:@"Username" pubTextFieldStyle:PubTextFieldStyleTop];
        _phoneTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _phoneTextField.pubTextField.frame = CGRectMake(0, 0, 250, 40);
        _phoneTextField.autoLayout = YES;
        [_phoneTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_phoneTextField resignFirstResponder];
            return YES;
        }];
    }
    return _phoneTextField;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(0.0f,  70, 320.0f, 40.0f);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}


- (IBAction)confirmButtonAction:(id)sender
{
    [self.phoneTextField resignFirstResponder];
    [self requestServerForLogin:sender];
}


- (BOOL)checkTextField
{
//    if ([_phoneTextField.pubTextField.text length] == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正常的用户名"];
//        [_phoneTextField becomeFirstResponder];
//        return NO;
//    }
//    
    return YES;
}

- (void)requestServerForLogin:(id)sender
{
    [self.view endEditing:YES];
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    [self.confirmButton setEnabled:NO];
    
    __unsafe_unretained ForgetPasswordViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
//        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
//        [UserDefaultsManager saveUserId:response.key];
//        [UserDefaultsManager saveUserName:_phoneTextField.pubTextField.text];
//        [UserDefaultsManager saveKey:response.key];
//        [safeSelf.confirmButton setEnabled:YES];
        [SVProgressHUD dismiss];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [safeSelf.confirmButton setEnabled:YES];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    ForgetPasswordRequest *request = [[[ForgetPasswordRequest alloc] init] autorelease];
    request.username    = _phoneTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}



@end
