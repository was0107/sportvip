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
#import "CustomSelectControl.h"
#import "ZJSwitch.h"
#import "UIKeyboardAvoidingScrollView.h"
#import "CreateObject.h"
#import "CustomAnimation.h"

@interface RegisterViewController ()
@property (nonatomic, retain) PubTextField            *nameTextField;
@property (nonatomic, retain) PubTextField            *sexTextField;
@property (nonatomic, retain) PubTextField            *birthTextField;
@property (nonatomic, retain) PubTextField            *phoneTextField;
@property (nonatomic, retain) PubTextField            *emailTextField;
@property (nonatomic, retain) PubTextField            *pwdTextField;
@property (nonatomic, retain) UIButton                *confirmButton;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;
@property (nonatomic, retain) CustomDatePickerControl * datePicker;
@property (nonatomic ,retain) UIButton                * birthdayButton;
@property (nonatomic,copy   ) NSString                * gender;//状态设置

@property (nonatomic,copy   ) NSString                * nickName;
@property (nonatomic,assign ) double                  birthday;
@property (nonatomic,copy   ) NSString                * phone, *email, *password;
@property (nonatomic, retain) ZJSwitch               *zjWwitch;

@end

@implementation RegisterViewController
{
    int _type;
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_nameTextField);
    TT_RELEASE_SAFELY(_sexTextField);
    TT_RELEASE_SAFELY(_birthTextField);
    TT_RELEASE_SAFELY(_phoneTextField);
    TT_RELEASE_SAFELY(_emailTextField);
    TT_RELEASE_SAFELY(_pwdTextField);
    TT_RELEASE_SAFELY(_confirmButton);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_datePicker);
    TT_RELEASE_SAFELY(_birthTextField);
    TT_RELEASE_SAFELY(_gender);
    TT_RELEASE_SAFELY(_nickName);
    TT_RELEASE_SAFELY(_phone);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_zjWwitch);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitleContent:@"用户注册"];
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    self.scrollView.contentSize = CGSizeMake(320, kContentBoundsHeight+1);
    [self.scrollView addSubview:self.nameTextField];
    [self.scrollView addSubview:self.sexTextField];
    [self.scrollView addSubview:self.zjWwitch];
    [self.scrollView addSubview:self.birthTextField];
    [self.scrollView addSubview:self.birthdayButton];
    [self.scrollView addSubview:self.phoneTextField];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.pwdTextField];
    [self.scrollView addSubview:self.confirmButton];
    [self.view addSubview:self.scrollView];
    
    
    
//#ifdef kUseSimulateData
//    self.nameTextField.pubTextField.text = @"was0107";
//    self.emailTextField.pubTextField.text = @"hr@163.com";
//    self.phoneTextField.pubTextField.text = @"13611111111";
//    self.pwdTextField.pubTextField.text = @"111111";
//#endif
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZJSwitch *) zjWwitch
{
    if (!_zjWwitch) {
        _zjWwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(235,20 + 1 * kPubTextFieldHeight2, 68, kPubTextFieldHeight)];
        _zjWwitch.backgroundColor = [UIColor clearColor];
        _zjWwitch.tintColor = [UIColor orangeColor];
        _zjWwitch.onText = @"男";
        _zjWwitch.offText = @"女";
        _zjWwitch.textFont = [UIFont systemFontOfSize:17];
        [_zjWwitch addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _zjWwitch;
}


- (IBAction)typeButtonAction:(id)sender
{
    _type = (0 == _type) ? 1 : 0;
    self.gender = (0 == _type) ? @"MALE" : @"FEMAL";
}


-(UIButton *)birthdayButton
{
    if (!_birthdayButton) {
        _birthdayButton = [[UIButton alloc]initWithFrame:CGRectMake(208,15 + 2 * kPubTextFieldHeight2, 204, kPubTextFieldHeight)];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * forwardDate = [NSDate dateWithTimeIntervalSinceNow:-18*365*24*60*60];
        
        self.birthday = [forwardDate timeIntervalSince1970];
        NSString *currentDate = [dateFormatter stringFromDate:forwardDate];
        [dateFormatter release];
        
        [_birthdayButton setTitle:currentDate forState:UIControlStateNormal];
        [_birthdayButton setTitleColor:[UIColor getColor:@"666666"] forState:UIControlStateNormal];
        [_birthdayButton setTitleColor:kWhiteColor forState:UIControlStateSelected];
        [_birthdayButton setBackgroundImage:[[UIImage imageNamed:@"input_bg_complete"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateNormal];
        [_birthdayButton.titleLabel setFont:HTFONTSIZE(kFontSize14)];
        [_birthdayButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 90.0)];
        [_birthdayButton addTarget:self action:@selector(birthdaySelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _birthdayButton;
}



-(IBAction)birthdaySelectAction:(id)sender
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = _birthdayButton.titleLabel.text;
    NSDate *date = [dateFormatter dateFromString:currentDateStr];
    if (date) {
        self.datePicker.pickerView.date = date;
        self.birthday = [date timeIntervalSince1970];
    }
    [self.datePicker showContent:YES];
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark UIDatePicker
-(CustomDatePickerControl *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[CustomDatePickerControl alloc]initWithController:self];
        _datePicker.pickerView.backgroundColor = kWhiteColor;
        _datePicker.block = ^(id content) {
            NSDate *date = content;
            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateStr = [dateFormatter stringFromDate:date];
            [_birthdayButton setTitle:currentDateStr forState:UIControlStateNormal];
            DEBUGLOG(@"currentDateStr = %@",currentDateStr);
        };
    }
    return _datePicker;
}

- (PubTextField *)nameTextField
{
    if (!_nameTextField) {
        __unsafe_unretained RegisterViewController *safeSelf = self;
        _nameTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 15 , 304, kPubTextFieldHeight) indexTitle:@"姓名" placeHolder:@"(必填)" pubTextFieldStyle:PubTextFieldStyleTop];
        _nameTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _nameTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
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
        [_sexTextField.pubTextField setEnabled:NO];
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
        [_birthTextField.pubTextField setEnabled:NO];
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
        _phoneTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8, 30 + 3 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"联系电话" placeHolder:@"(必填，可用于登录)" pubTextFieldStyle:PubTextFieldStyleTop];
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
        _emailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8,  30 + 4 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"邮箱" placeHolder:@"(必填，可用于登录)" pubTextFieldStyle:PubTextFieldStyleTop];
        _emailTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _emailTextField.pubTextField.keyboardType = UIKeyboardTypeEmailAddress;
        [_emailTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.pwdTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _emailTextField;
}

- (PubTextField *)pwdTextField
{
    if (!_pwdTextField) {
        __block RegisterViewController *safeSelf = self;
        _pwdTextField = [[PubTextField alloc] initWithFrame:CGRectMake(8,  30 + 5 * kPubTextFieldHeight2, 304, kPubTextFieldHeight) indexTitle:@"密码" placeHolder:@"6-16位的字母和数字组成" pubTextFieldStyle:PubTextFieldStyleBottom];
        _pwdTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _pwdTextField.pubTextField.secureTextEntry = YES;
        _emailTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
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
        _confirmButton.frame = CGRectMake(8.0f,  45 + 6 * kPubTextFieldHeight2, 304, kPubTextFieldHeight);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        UIImage *image = [[UIImage imageNamed:@"button_login_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [_confirmButton setBackgroundImage:image forState:UIControlStateNormal];
        [_confirmButton setTitle:@"注册" forState:UIControlStateNormal];
        [CreateObject addTargetEfection:_confirmButton];
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
    if ([_nameTextField.pubTextField.text length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的名称"];
        [_nameTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_nameTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    if (![IdentifierValidator isValid:IdentifierTypeEmail value:_emailTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱"];
        [_phoneTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_emailTextField duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    if (![IdentifierValidator isValid:IdentifierTypePhone value:_phoneTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        [_phoneTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_phoneTextField duration:0.2 vigour:0.01 number:5  direction:1];

        return NO;
    }
    if (![IdentifierValidator isValid:IdentifierTypePassword value:_pwdTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位的字母、数字组成"];
        [_pwdTextField becomeFirstResponder];
        [CustomAnimation shakeAnimation:_pwdTextField duration:0.2 vigour:0.01 number:5  direction:1];
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
        LoginResponse *response = [[[LoginResponse alloc] initWithJsonString:content] autorelease];
        [UserDefaultsManager saveUserName:response.userItem.nickName];
        [UserDefaultsManager saveUserId:response.userItem.userId];
        [UserDefaultsManager saveUserEmail:response.userItem.email];
        [UserDefaultsManager saveUserTel:response.userItem.phone];
        [UserDefaultsManager saveUserIcon:response.userItem.avatar];
        [UserDefaultsManager saveUserBirthDay:response.userItem.birthday];
        [UserDefaultsManager saveUserGender:response.userItem.gender];
        [SVProgressHUD showSuccessWithStatus:@"注册成功！"];
        [safeSelf.confirmButton setEnabled:YES];
        [safeSelf.navigationController popToRootViewControllerAnimated:YES];
    };

    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
        [SVProgressHUD showErrorWithStatus:@"注册失败"];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"注册失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    self.gender = [self.zjWwitch isOn] ? @"MALE": @"FEMALE";
    self.nickName = self.nameTextField.pubTextField.text;
    self.phone = self.phoneTextField.pubTextField.text;
    self.email = self.emailTextField.pubTextField.text;
    self.password = self.pwdTextField.pubTextField.text;
    UpdateUserInfoRequest *request = [[[UpdateUserInfoRequest alloc] init] autorelease];
    NSMutableArray * keys = [NSMutableArray arrayWithObjects:@"gender",@"avatar",@"nickName",@"birthday",@"phone",@"email",@"password", nil];
    NSMutableArray * values = [NSMutableArray arrayWithObjects:self.gender,@"",self.nickName,[NSNumber numberWithDouble:self.birthday], self.phone,self.email,self.password,nil];
    request.keys = keys;
    request.values = values;
    request.isUpdate = NO;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];

}



@end
