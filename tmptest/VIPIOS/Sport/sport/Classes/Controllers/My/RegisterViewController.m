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

@interface RegisterViewController ()
@property (nonatomic, retain) PubTextField *nameTextField;
@property (nonatomic, retain) PubTextField *sexTextField;
@property (nonatomic, retain) PubTextField *birthTextField;
@property (nonatomic, retain) PubTextField *phoneTextField;
@property (nonatomic, retain) PubTextField *emailTextField;
@property (nonatomic, retain) PubTextField *pwdTextField;
@property (nonatomic, retain) UIButton     *confirmButton;
@property (nonatomic, retain) UIScrollView *scrollView;

@end

@implementation RegisterViewController

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
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    self.scrollView.contentSize = CGSizeMake(320, kContentBoundsHeight+1);
    [self.scrollView addSubview:self.nameTextField];
    [self.scrollView addSubview:self.sexTextField];
    [self.scrollView addSubview:self.birthTextField];
    [self.scrollView addSubview:self.phoneTextField];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.confirmButton];
    [self.view addSubview:self.scrollView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (PubTextField *)nameTextField
{
    if (!_nameTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _nameTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 15 , 304, kPubTextFieldHeight) indexTitle:@"姓名" placeHolder:@"(必填)" pubTextFieldStyle:PubTextFieldStyleTop];
        _nameTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _nameTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_nameTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _nameTextField;
}

- (PubTextField *)sexTextField
{
    if (!_sexTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _sexTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 15 + 1 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"性别" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _sexTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _sexTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_sexTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _sexTextField;
}

- (PubTextField *)birthTextField
{
    if (!_birthTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _birthTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8,15 + 2 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"生日" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _birthTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _birthTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_birthTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _birthTextField;
}


- (PubTextField *)phoneTextField
{
    if (!_phoneTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 30 + 3 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"联系电话" placeHolder:@"(必填)" pubTextFieldStyle:PubTextFieldStyleTop];
        _phoneTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _phoneTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _phoneTextField;
}

- (PubTextField *)emailTextField
{
    if (!_emailTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _emailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8,  30 + 4 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"邮箱" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _emailTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _emailTextField.pubTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_emailTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _emailTextField;
}


- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(8.0f,  45 + 5 * kPubTextFieldHeight2, 304, kPubTextFieldHeight);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        UIImage *image = [[UIImage imageNamed:@"button_login_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [_confirmButton setBackgroundImage:image forState:UIControlStateNormal];
        [_confirmButton setTitle:@"注册" forState:UIControlStateNormal];
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
    if (![IdentifierValidator isValid:IdentifierTypeEmail value:_phoneTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        [_phoneTextField becomeFirstResponder];
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
