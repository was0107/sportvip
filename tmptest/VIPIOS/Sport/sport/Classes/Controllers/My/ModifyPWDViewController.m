//
//  ModifyPWDViewController.m
//  sport
//
//  Created by allen.wang on 5/20/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ModifyPWDViewController.h"
#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "UIKeyboardAvoidingScrollView.h"
#import "CustomAnimation.h"

@interface ModifyPWDViewController ()
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) PubTextField *oldTextField;
@property (nonatomic, retain) PubTextField *newTextField;
@property (nonatomic, retain) PubTextField *confirmTextField;
@property (nonatomic, retain) UIButton     *confirmButton;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;

@end

@implementation ModifyPWDViewController

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
    [self setTitleContent:@"修改密码"];
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    self.scrollView.contentSize = CGSizeMake(320, kContentBoundsHeight+1);

    [self.scrollView addSubview:self.phoneTextField];
    [self.scrollView addSubview:self.oldTextField];
    [self.scrollView addSubview:self.newTextField];
    [self.scrollView addSubview:self.confirmTextField];
    [self.scrollView addSubview:self.confirmButton];
    
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PubTextField *)phoneTextField
{
    if (!_phoneTextField) {
        __unsafe_unretained ModifyPWDViewController *safeSelf = self;
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 15, 304, 40) indexTitle:@"帐号" placeHolder:@"请输入手机号/邮箱" pubTextFieldStyle:PubTextFieldStyleTop];
        _phoneTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _phoneTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.oldTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _phoneTextField;
}

- (PubTextField *)oldTextField
{
    if (!_oldTextField) {
        __unsafe_unretained ModifyPWDViewController *safeSelf = self;
        _oldTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 62, 304, 40) indexTitle:@"旧密码" placeHolder:@"6-16位的字母、数字组成" pubTextFieldStyle:PubTextFieldStyleTop];
        _oldTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        [_oldTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.newTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _oldTextField;
}

- (PubTextField *)newTextField
{
    if (!_newTextField) {
        __unsafe_unretained ModifyPWDViewController *safeSelf = self;
        _newTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 109, 304, 40) indexTitle:@"新密码" placeHolder:@"6-16位的字母、数字组成" pubTextFieldStyle:PubTextFieldStyleBottom];
        _newTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        [_newTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.confirmTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _newTextField;
}

- (PubTextField *)confirmTextField
{
    if (!_confirmTextField) {
        __unsafe_unretained ModifyPWDViewController *safeSelf = self;
        _confirmTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 157, 304, 40) indexTitle:@"再确认" placeHolder:@"6-16位的字母、数字组成" pubTextFieldStyle:PubTextFieldStyleTop];
        _confirmTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        [_confirmTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_confirmTextField resignFirstResponder];
            return YES;
        }];
    }
    return _confirmTextField;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(8.0f, 210.0f, 304.0f, 40.0f);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        UIImage *image = [[UIImage imageNamed:@"button_login_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [_confirmButton setBackgroundImage:image forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

- (IBAction)confirmButtonAction:(id)sender
{
    [self.confirmTextField resignFirstResponder];
    [self requestServerForPWD];
}


- (BOOL)checkTextField
{
    if (![IdentifierValidator isValid:IdentifierTypePhone value:_phoneTextField.pubTextField.text] &&
        ![IdentifierValidator isValid:IdentifierTypeEmail value:_phoneTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号/邮箱"];
        [_phoneTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_phoneTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_oldTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
        [_oldTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_oldTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_newTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
        [_newTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_newTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_confirmTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
        [_confirmTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_confirmTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    if (![_confirmTextField.pubTextField.text isEqualToString:_newTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不匹配"];
        [_confirmTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_confirmTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    return YES;
}

- (void)requestServerForPWD
{
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    [self.confirmButton setEnabled:NO];
    __unsafe_unretained ModifyPWDViewController *safeSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        [SVProgressHUD showSuccessWithStatus:@"密码修改成功。\n"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        ErrorResponse *response = [[[ErrorResponse alloc] initWithJsonString:content] autorelease];
        [SVProgressHUD showErrorWithStatus:response.msg];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    UpdatePasswordRequest *request = [[[UpdatePasswordRequest alloc] init] autorelease];
    request.email    = _phoneTextField.pubTextField.text;
    request.password = _oldTextField.pubTextField.text;
    request.theNewPassword = _newTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock];
}
@end
