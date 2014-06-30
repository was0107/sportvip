//
//  ForgetPWDViewController.m
//  b5mei
//
//  Created by allen.wang on 4/21/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ForgetPWDViewController.h"

#import "UITextField+DelegateBlocks.h"
#import "PubTextField.h"
#import "ListResponseBase.h"
#import "LoginRequest.h"


@interface ForgetPWDViewController ()

@property (nonatomic, retain) UIButton *resetPwdButton;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) PubTextField *mailTextField;
@end

@implementation ForgetPWDViewController

- (void) reduceMemory {
    TT_RELEASE_SAFELY(_resetPwdButton);
    TT_RELEASE_SAFELY(_backButton);
    TT_RELEASE_SAFELY(_mailTextField);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:@"忘记密码"];
    self.trackViewId = @"忘记密码页面";
    self.navigationController.navigationBarHidden = NO;
    if (IS_IOS_7_OR_GREATER) {
        UIView *bgView = [[[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 45)] autorelease];
        bgView.backgroundColor = kWhiteColor;
        [self.view addSubview:bgView];
    }
    
    [self.view addSubview:[self mailTextField]];
    [self.view addSubview:[self resetPwdButton]];
    self.mailTextField.pubTextField.text = [UserDefaultsManager userEmail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)resetPwdButton
{
    if (!_resetPwdButton) {
        _resetPwdButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _resetPwdButton.frame = CGRectMake(80.0f, 80.0f, 160.0f, 45.0f);
        [_resetPwdButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        UIImage *image = [[UIImage imageNamed:@"button_login_normal"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [_resetPwdButton setBackgroundImage:image forState:UIControlStateNormal];
        [_resetPwdButton setTitle:@"获取密码" forState:UIControlStateNormal];
        [_resetPwdButton addTarget:self action:@selector(resetPwdButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _resetPwdButton;
}


- (PubTextField *)mailTextField
{
    if (!_mailTextField) {
        __unsafe_unretained ForgetPWDViewController *safeSelf = self;
        _mailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(10, 10, 300, 45) indexTitle:@"邮箱" placeHolder:@"请输入邮箱" pubTextFieldStyle:PubTextFieldStyleOne];
        _mailTextField.pubTextField.text = [UserDefaultsManager userHttpAccount];
        [_mailTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf requestServerForPWD];
            return YES;
        }];
    }
    return _mailTextField;
}

- (BOOL)checkTextField
{
    if (![IdentifierValidator isValid:IdentifierTypeEmail value:_mailTextField.pubTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱格式."];
        return NO;
    }
    return YES;
}

- (void)resetPwdButtonPressed:(id)sender
{
    [self requestServerForPWD];
}

- (void)requestServerForPWD
{
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    [self.resetPwdButton setEnabled:NO];
    __unsafe_unretained ForgetPWDViewController *safeSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        [SVProgressHUD showSuccessWithStatus:@"新密码已经发送到您的邮箱。\n"];
        [safeSelf.resetPwdButton setEnabled:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        ErrorResponse *response = [[[ErrorResponse alloc] initWithJsonString:content] autorelease];
        [SVProgressHUD showErrorWithStatus:response.msg];
        [safeSelf.resetPwdButton setEnabled:YES];
    };
    
    ForgetPasswordRequest *request = [[[ForgetPasswordRequest alloc] init] autorelease];
    request.email = _mailTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock];
}
@end
