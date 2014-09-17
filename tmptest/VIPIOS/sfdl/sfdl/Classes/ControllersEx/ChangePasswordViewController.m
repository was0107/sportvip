//
//  ChangePasswordViewController.m
//  sfdl
//
//  Created by boguang on 14-9-15.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "UIKeyboardAvoidingScrollView.h"
#import "CreateObject.h"
#import "UIImageView+WebCache.h"


@interface ChangePasswordViewController ()
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

@implementation ChangePasswordViewController
{
    int _type;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleContent:@"CREATE ACCOUNT"];
    [[[self showRight] rightButton] setTitle:@"Login" forState:UIControlStateNormal];
    
    
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    [self.scrollView addSubview:self.memberIDTextField];
    [self.scrollView addSubview:self.pwdTextField];
    [self.scrollView addSubview:self.titleTextField];
    [self.scrollView addSubview:self.confirmButton];
    
#ifdef kUseSimulateData
    self.memberIDTextField.pubTextField.text = @"111111";
    self.pwdTextField.pubTextField.text = @"111111";
    self.titleTextField.pubTextField.text = @"title";
#endif
    
    [self.scrollView setContentSize:CGSizeMake(320, 50 + 4 * kPubTextFieldHeight2  + kImageStartAt)];
    
    [self.view addSubview:self.scrollView];    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) rightButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (PubTextField *)memberIDTextField
{
    if (!_memberIDTextField) {
        __block typeof(self) safeSelf = self;
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
        __block typeof(self) safeSelf = self;
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
        __block typeof(self) safeSelf = self;
        _titleTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 2 * kPubTextFieldHeight2  + kImageStartAt, 320, kPubTextFieldHeight) indexTitle:@"Repeat Password:" placeHolder:@"Title" pubTextFieldStyle:PubTextFieldStyleBottom];
        _titleTextField.autoLayout = YES;
        _titleTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _titleTextField.pubTextField.secureTextEntry = YES;
        _titleTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_titleTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf confirmButtonAction:nil];
            return YES;
        }];
    }
    return _titleTextField;
}


- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(0.0f, 25 + 3 * kPubTextFieldHeight2  + kImageStartAt, 320.0f, 40.0f);
        _confirmButton.backgroundColor = kClearColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (IBAction)confirmButtonAction:(id)sender
{
    [self.pwdTextField resignFirstResponder];
    [self requestServerForRegister:sender];
}


- (BOOL)checkTextField
{
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_memberIDTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的用户名"];
        return NO;
    }
    
    if (![_pwdTextField.pubTextField.text isEqualToString:_titleTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        [_pwdTextField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void) loadCodeImageView:(VerifyCodeResponse *) response
{
    [self.codeImageView setImageWithURL:[NSURL URLWithString:response.imageUrl] placeholderImage:[UIImage imageNamed:kImageDefault]];
}

- (void)requestServerForRegister:(id)sender
{
    [self.view endEditing:YES];
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在注册..."];
    [self.confirmButton setEnabled:NO];
    __block typeof(self) safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"密码修改失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    if (!self.request) {
        self.request = [[[RegiseterRequest alloc] init] autorelease];
    }
    
    self.request.username    = self.memberIDTextField.pubTextField.text;
    self.request.password = self.pwdTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

@end
