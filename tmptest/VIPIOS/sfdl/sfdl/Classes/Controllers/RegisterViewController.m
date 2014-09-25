//
//  RegisterViewController.m
//  sport
//
//  Created by allen.wang on 5/20/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "RegisterViewController.h"
#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "UIKeyboardAvoidingScrollView.h"
#import "CreateObject.h"
#import "UIImageView+WebCache.h"


@interface RegisterViewController ()
@property (nonatomic, retain) PubTextField            *emailTextField;
@property (nonatomic, retain) PubTextField            *memberIDTextField;
@property (nonatomic, retain) PubTextField            *pwdTextField;
@property (nonatomic, retain) PubTextField            *titleTextField;
@property (nonatomic, retain) UIButton                *confirmButton;
@property (nonatomic, retain) UIImageView             *codeImageView;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;

@property (nonatomic, retain) RegiseterRequest        *request;
@property (nonatomic, retain) RegisterResponse        *response;
@property (nonatomic, retain) VerifyCodeResponse      *verifyCodeResponse;
@property (nonatomic, retain) CheckVerifyCodeResponse *checkCodeResponse;

@end

@implementation RegisterViewController
{
    int _type;
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_emailTextField);
    TT_RELEASE_SAFELY(_memberIDTextField);
    TT_RELEASE_SAFELY(_pwdTextField);
    TT_RELEASE_SAFELY(_titleTextField);
    TT_RELEASE_SAFELY(_confirmButton);
    TT_RELEASE_SAFELY(_codeImageView);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_verifyCodeResponse);
    TT_RELEASE_SAFELY(_checkCodeResponse);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleContent:@"CREATE ACCOUNT"];
    [[[self showRight] rightButton] setTitle:@"Login" forState:UIControlStateNormal];

    
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.memberIDTextField];
    [self.scrollView addSubview:self.pwdTextField];
    [self.scrollView addSubview:self.titleTextField];
    [self.scrollView addSubview:self.confirmButton];
    
#ifdef kUseSimulateData
    self.emailTextField.pubTextField.text = @"hr@163.com";
    self.memberIDTextField.pubTextField.text = @"111111";
    self.pwdTextField.pubTextField.text = @"111111";
    self.titleTextField.pubTextField.text = @"111111";
#endif
    
    [self.scrollView setContentSize:CGSizeMake(320, 50 + 5 * kPubTextFieldHeight2  + kImageStartAt)];

    [self.view addSubview:self.scrollView];
//    [self requestServerForCode];

    // Do any additional setup after loading the view.
}

- (void) rightButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (PubTextField *)memberIDTextField
{
    if (!_memberIDTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _memberIDTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 0* kPubTextFieldHeight2  + kImageStartAt , 320, kPubTextFieldHeight) indexTitle:@"Name:" placeHolder:@"Member ID" pubTextFieldStyle:PubTextFieldStyleTop];
        _memberIDTextField.autoLayout = YES;
        _memberIDTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _memberIDTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_memberIDTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _memberIDTextField;
}


- (PubTextField *)pwdTextField
{
    if (!_pwdTextField) {
        __weak RegisterViewController *safeSelf = self;
        _pwdTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 1 * kPubTextFieldHeight2  + kImageStartAt, 320, kPubTextFieldHeight) indexTitle:@"Password:" placeHolder:@"Password" pubTextFieldStyle:PubTextFieldStyleBottom];
        _pwdTextField.autoLayout = YES;
        _pwdTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _pwdTextField.pubTextField.secureTextEntry = YES;
        _pwdTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_pwdTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_titleTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _pwdTextField;
}


- (PubTextField *)titleTextField
{
    if (!_titleTextField) {
        __weak RegisterViewController *safeSelf = self;
        _titleTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 2 * kPubTextFieldHeight2  + kImageStartAt, 320, kPubTextFieldHeight) indexTitle:@"Repeat Password:" placeHolder:@"Title" pubTextFieldStyle:PubTextFieldStyleBottom];
        _titleTextField.autoLayout = YES;
        _titleTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _titleTextField.pubTextField.secureTextEntry = YES;
        _titleTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_titleTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.emailTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _titleTextField;
}

- (PubTextField *)emailTextField
{
    if (!_emailTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _emailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 3 * kPubTextFieldHeight2  + kImageStartAt , 320, kPubTextFieldHeight) indexTitle:@"Email:" placeHolder:@"Current Email" pubTextFieldStyle:PubTextFieldStyleTop];
        _emailTextField.autoLayout = YES;
        _emailTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _emailTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_emailTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf confirmButtonAction:nil];
            return YES;
        }];
    }
    return _emailTextField;
}


- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(0.0f, 25 + 4 * kPubTextFieldHeight2  + kImageStartAt, 320.0f, 40.0f);
        _confirmButton.backgroundColor = kClearColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (void) codeAction:(UIGestureRecognizer *) recoginizer
{
    [self requestServerForCode];
}

- (IBAction)confirmButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self requestServerForRegister:sender];
}


- (BOOL)checkTextField
{
//    if (![self.checkCodeResponse isChecked]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正常的验证码信息"];
//        [_codePub becomeFirstResponder];
//        return NO;
//    }
//
//    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
//        [_pwdTextField becomeFirstResponder];
//        return NO;
//    }
//    if (![IdentifierValidator isValid:IdentifierTypePhone value:_telephoneTextField.pubTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
//        [_telephoneTextField becomeFirstResponder];
//        return NO;
//    }
//
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_memberIDTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的用户名"];
        return NO;
    }
    
    if (![_pwdTextField.pubTextField.text isEqualToString:_titleTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        [_pwdTextField becomeFirstResponder];
        return NO;
    }
    
    if (![IdentifierValidator isValid:IdentifierTypeEmail value:_emailTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱"];
        [_emailTextField becomeFirstResponder];
        return NO;
    }
    
    
    return YES;
}

- (void) loadCodeImageView:(VerifyCodeResponse *) response
{
    [self.codeImageView setImageWithURL:[NSURL URLWithString:response.imageUrl] placeholderImage:[UIImage imageNamed:kImageDefault]];
}

- (void)requestServerForCode
{
    __unsafe_unretained RegisterViewController *safeSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.verifyCodeResponse = [[[VerifyCodeResponse   alloc] initWithJsonString:content] autorelease];
        [safeSelf loadCodeImageView:safeSelf.verifyCodeResponse];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    VerifyCodeRequest *codeRequest = [[[VerifyCodeRequest alloc] init] autorelease];
    [WASBaseServiceFace serviceWithMethod:[codeRequest URLString] body:[codeRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

- (void)requestServerToCheckCode
{
//    [SVProgressHUD showWithStatus:@"正在检验..."];
//    __unsafe_unretained RegisterViewController *safeSelf = self;
//    idBlock succBlock = ^(id content){
//        DEBUGLOG(@"succ content %@", content);
//        safeSelf.checkCodeResponse = [[[CheckVerifyCodeResponse   alloc] initWithJsonString:content] autorelease];
//        if ([safeSelf.checkCodeResponse isChecked]) {
//            [safeSelf requestServerForRegister:nil];
//            return ;
//        }
//        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
//    };
//    
//    idBlock failedBlock = ^(id content){
//        DEBUGLOG(@"failed content %@", content);
//        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
//        [safeSelf requestServerForRegister:nil];
//    };
//    idBlock errBlock = ^(id content){
//        DEBUGLOG(@"failed content %@", content);
//        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
//        [safeSelf requestServerForRegister:nil];
//    };
//    
//    CheckVerifyCodeRequest *codeRequest = [[[CheckVerifyCodeRequest alloc] init] autorelease];
//    codeRequest.verifyCode = self.codePub.pubTextField.text;
//    [WASBaseServiceFace serviceWithMethod:[codeRequest URLString] body:[codeRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

- (void)requestServerForRegister:(id)sender
{
    [self.view endEditing:YES];
//    if (![self.checkCodeResponse isChecked]) {
//        [self requestServerToCheckCode];
//        return;
//    }
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在注册..."];
    [self.confirmButton setEnabled:NO];
    __unsafe_unretained RegisterViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        [SVProgressHUD showSuccessWithStatus:@"请等待后台审核或是联系客服!"];
//        [safeSelf requestServerForLogin];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"注册失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };

    if (!self.request) {
        self.request = [[[RegiseterRequest alloc] init] autorelease];
    }
    
    self.request.email    = self.emailTextField.pubTextField.text;
    self.request.username    = self.memberIDTextField.pubTextField.text;
    self.request.password = self.pwdTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

- (void)requestServerForLogin
{
    __unsafe_unretained RegisterViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        [UserDefaultsManager saveUserId:response.key];
        [UserDefaultsManager saveKey:response.key];
        [UserDefaultsManager saveUserEmail:response.userItem.email];
        [UserDefaultsManager saveUserName:_memberIDTextField.pubTextField.text];
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
        [SVProgressHUD showErrorWithStatus:@"注册失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    LoginRequest *request = [[[LoginRequest alloc] init] autorelease];
    request.username    = _memberIDTextField.pubTextField.text;
    request.password = _pwdTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}





@end
