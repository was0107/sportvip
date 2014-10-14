//
//  ChangePasswordViewController.m
//  sfdl
//
//  Created by micker on 14-9-15.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UITextField+DelegateBlocks.h"
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

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_memberIDTextField);
    TT_RELEASE_SAFELY(_pwdTextField);
    TT_RELEASE_SAFELY(_titleTextField);
    TT_RELEASE_SAFELY(_codeImageView);
    TT_RELEASE_SAFELY(_confirmButton);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_verifyCodeResponse);
    TT_RELEASE_SAFELY(_checkCodeResponse);
    [super reduceMemory];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:NSLocalizedString(@"CREATE ACCOUNT",@"CREATE ACCOUNT")];
    [[[self showRight] rightButton] setTitle:NSLocalizedString(@"Login",@"Login") forState:UIControlStateNormal];
    
    
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    [self.scrollView addSubview:self.memberIDTextField];
    [self.scrollView addSubview:self.pwdTextField];
    [self.scrollView addSubview:self.titleTextField];
    [self.scrollView addSubview:self.confirmButton];
    
#ifdef kUseSimulateData
    self.memberIDTextField.pubTextField.text = @"111111";
    self.pwdTextField.pubTextField.text = @"111111";
    self.titleTextField.pubTextField.text = @"111111";
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
        __unsafe_unretained typeof(self) safeSelf = self;
        _memberIDTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 0* kPubTextFieldHeight2  + kImageStartAt , 320, kPubTextFieldHeight) indexTitle:NSLocalizedString(@"Name:",@"Name:") placeHolder:NSLocalizedString(@"Member ID",@"Member ID") pubTextFieldStyle:PubTextFieldStyleTop];
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
        __unsafe_unretained typeof(self) safeSelf = self;
        _pwdTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 1 * kPubTextFieldHeight2  + kImageStartAt, 320, kPubTextFieldHeight) indexTitle:NSLocalizedString(@"Password:",@"Password:") placeHolder:NSLocalizedString(@"Password",@"Password") pubTextFieldStyle:PubTextFieldStyleBottom];
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
        __unsafe_unretained typeof(self) safeSelf = self;
        _titleTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 2 * kPubTextFieldHeight2  + kImageStartAt, 320, kPubTextFieldHeight) indexTitle:NSLocalizedString(@"Repeat Password:",@"Repeat Password:") placeHolder:NSLocalizedString(@"Repeat Password",@"Repeat Password") pubTextFieldStyle:PubTextFieldStyleBottom];
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
        [_confirmButton setTitle:NSLocalizedString(@"SUBMIT",@"SUBMIT") forState:UIControlStateNormal];
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
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Name is error",@"Name is error")];
        return NO;
    }
    
    if (![_pwdTextField.pubTextField.text isEqualToString:_titleTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Password is error",@"Password is error")];
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
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Watting...",@"Watting...")];
    [self.confirmButton setEnabled:NO];
    __unsafe_unretained typeof(self) safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Password updated successfully",@"Password updated successfully")];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Password updated  failed",@"Password updated failed")];
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
