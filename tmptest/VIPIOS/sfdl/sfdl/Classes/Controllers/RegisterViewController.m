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

@interface RegisterViewController ()
@property (nonatomic, retain) PubTextField            *cuntryTextField;
@property (nonatomic, retain) PubTextField            *emailTextField;
@property (nonatomic, retain) PubTextField            *memberIDTextField;
@property (nonatomic, retain) PubTextField            *pwdTextField;
@property (nonatomic, retain) PubTextField            *titleTextField;
@property (nonatomic, retain) PubTextField            *fullNameTextField;
@property (nonatomic, retain) PubTextField            *companyTextField;
@property (nonatomic, retain) PubTextField            *telephoneTextField;
@property (nonatomic, retain) PubTextField            *codePub;
@property (nonatomic, retain) UIButton                *confirmButton;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;

@property (nonatomic, retain) RegiseterRequest        *request;
@property (nonatomic, retain) RegisterResponse        *response;

@end

@implementation RegisterViewController
{
    int _type;
}

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
    
    [self setTitleContent:@"用户注册"];
    
    
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    
    
    UIImageView *imageVeiw = [[[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 250, 30)] autorelease];
    imageVeiw.backgroundColor = kClearColor;
    imageVeiw.image = [UIImage imageNamed:@"icon"];
    [self.scrollView addSubview:imageVeiw];
    
    
    [self.scrollView addSubview:self.cuntryTextField];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.memberIDTextField];
    [self.scrollView addSubview:self.pwdTextField];
    [self.scrollView addSubview:self.titleTextField];
    [self.scrollView addSubview:self.fullNameTextField];
    [self.scrollView addSubview:self.companyTextField];
    [self.scrollView addSubview:self.telephoneTextField];
    [self.scrollView addSubview:self.codePub];
    [self.scrollView addSubview:self.confirmButton];
    
#ifdef kUseSimulateData
    self.cuntryTextField.pubTextField.text = @"cuntry";
    self.emailTextField.pubTextField.text = @"hr@163.com";
    self.memberIDTextField.pubTextField.text = @"111111";
    self.pwdTextField.pubTextField.text = @"111111";
    self.titleTextField.pubTextField.text = @"title";
    self.fullNameTextField.pubTextField.text = @"fullname";
    self.companyTextField.pubTextField.text = @"msmc";
    self.telephoneTextField.pubTextField.text = @"13611111111";
#endif
    
    [self.scrollView setContentSize:CGSizeMake(320, 50 + 10 * kPubTextFieldHeight2  + kImageStartAt)];

    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (PubTextField *)cuntryTextField
{
    if (!_cuntryTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _cuntryTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 15  + kImageStartAt , 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Country/Region" pubTextFieldStyle:PubTextFieldStyleTop];
        _cuntryTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _cuntryTextField.autoLayout = YES;
        _cuntryTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_cuntryTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.emailTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _cuntryTextField;
}


- (PubTextField *)emailTextField
{
    if (!_emailTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _emailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 30 + 1 * kPubTextFieldHeight2  + kImageStartAt , 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Current Email" pubTextFieldStyle:PubTextFieldStyleTop];
        _emailTextField.autoLayout = YES;
        _emailTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _emailTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_emailTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.memberIDTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _emailTextField;
}

- (PubTextField *)memberIDTextField
{
    if (!_memberIDTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _memberIDTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 30 + 2 * kPubTextFieldHeight2  + kImageStartAt , 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Member ID" pubTextFieldStyle:PubTextFieldStyleTop];
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
        __block RegisterViewController *safeSelf = self;
        _pwdTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  30 + 3 * kPubTextFieldHeight2  + kImageStartAt, 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Password" pubTextFieldStyle:PubTextFieldStyleBottom];
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
        __block RegisterViewController *safeSelf = self;
        _titleTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  45 + 4 * kPubTextFieldHeight2  + kImageStartAt, 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Title" pubTextFieldStyle:PubTextFieldStyleBottom];
        _titleTextField.autoLayout = YES;
        _titleTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _titleTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_titleTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_fullNameTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _titleTextField;
}



- (PubTextField *)fullNameTextField
{
    if (!_fullNameTextField) {
        __block RegisterViewController *safeSelf = self;
        _fullNameTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  45 + 5 * kPubTextFieldHeight2  + kImageStartAt, 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Full Name" pubTextFieldStyle:PubTextFieldStyleBottom];
        _fullNameTextField.autoLayout = YES;
        _fullNameTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _fullNameTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_fullNameTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_companyTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _fullNameTextField;
}



- (PubTextField *)companyTextField
{
    if (!_companyTextField) {
        __block RegisterViewController *safeSelf = self;
        _companyTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  45 + 6 * kPubTextFieldHeight2  + kImageStartAt, 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Company Name" pubTextFieldStyle:PubTextFieldStyleBottom];
        _companyTextField.autoLayout = YES;
        _companyTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _companyTextField.pubTextField.secureTextEntry = YES;
        _companyTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_companyTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_telephoneTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _companyTextField;
}



- (PubTextField *)telephoneTextField
{
    if (!_telephoneTextField) {
        __block RegisterViewController *safeSelf = self;
        _telephoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  45 + 7 * kPubTextFieldHeight2  + kImageStartAt, 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Telephone" pubTextFieldStyle:PubTextFieldStyleBottom];
        _telephoneTextField.autoLayout = YES;
        _telephoneTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _telephoneTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_telephoneTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_codePub becomeFirstResponder];
            return YES;
        }];
    }
    return _telephoneTextField;
}


- (PubTextField *)codePub
{
    if (!_codePub) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _codePub = [[PubTextField alloc] initWithFrame:CGRectMake(10,  45 + 8 * kPubTextFieldHeight2  + kImageStartAt, 300, kPubTextFieldHeight) indexTitle:@"" placeHolder:@"Code" pubTextFieldStyle:PubTextFieldStyleTop];
        _codePub.pubTextField.returnKeyType = UIReturnKeyDone;
        _codePub.autoLayout = YES;
        _codePub.indexLabel.frame = CGRectMake(0, 0, 0, 0);
        _codePub.pubTextField.frame = CGRectMake(8, 5, 100, 20);
        _codePub.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_codePub.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.codePub resignFirstResponder];
            [safeSelf confirmButtonAction:nil];
            return YES;
        }];
    }
    return _codePub;
}



- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(50.0f, 45 + 9 * kPubTextFieldHeight2  + kImageStartAt, 220.0f, 40.0f);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"Join Now" forState:UIControlStateNormal];
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
    if (![IdentifierValidator isValid:IdentifierTypeEmail value:_emailTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱"];
        [_emailTextField becomeFirstResponder];
        return NO;
    }
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
        [_pwdTextField becomeFirstResponder];
        return NO;
    }
    if (![IdentifierValidator isValid:IdentifierTypePhone value:_telephoneTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        [_telephoneTextField becomeFirstResponder];
        return NO;
    }
    
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_memberIDTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的用户名"];
        [_telephoneTextField becomeFirstResponder];
        return NO;
    }
    
    
    return YES;
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
    __unsafe_unretained RegisterViewController *safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);        
        [safeSelf requestServerForLogin];
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
    self.request.title    = self.titleTextField.pubTextField.text;
    self.request.fullName    = self.fullNameTextField.pubTextField.text;
    self.request.userCompany    = self.companyTextField.pubTextField.text;
    self.request.tel    = self.telephoneTextField.pubTextField.text;
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
