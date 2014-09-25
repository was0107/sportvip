//
//  InquiryFormViewController.m
//  sfdl
//
//  Created by boguang on 14-9-22.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "InquiryFormViewController.h"
#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "ProductRequest.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "UIKeyboardAvoidingScrollView.h"
#import "CreateObject.h"
#import "UIImageView+WebCache.h"

@interface InquiryFormViewController ()
@property (nonatomic, retain) ProductItem             *currentItem;
@property (nonatomic, retain) PubTextField            *emailTextField;
@property (nonatomic, retain) PubTextField            *toTextField;
@property (nonatomic, retain) PubTextField            *subjectTextField;
@property (nonatomic, retain) PubTextField            *messageTextField;
@property (nonatomic, retain) PubTextField            *pictureTextField;
@property (nonatomic, retain) PubTextField            *codeTextField;
@property (nonatomic, retain) UIButton                *confirmButton;
@property (nonatomic, retain) UIImageView             *codeImageView, *productImageView;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;

@property (nonatomic, retain) RegiseterRequest        *request;
@property (nonatomic, retain) RegisterResponse        *response;
@property (nonatomic, retain) VerifyCodeResponse      *verifyCodeResponse;
@property (nonatomic, retain) CheckVerifyCodeResponse *checkCodeResponse;
@end

@implementation InquiryFormViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_emailTextField);
    TT_RELEASE_SAFELY(_toTextField);
    TT_RELEASE_SAFELY(_subjectTextField);
    TT_RELEASE_SAFELY(_messageTextField);
    TT_RELEASE_SAFELY(_pictureTextField);
    TT_RELEASE_SAFELY(_codeImageView);
    TT_RELEASE_SAFELY(_codeTextField);
    TT_RELEASE_SAFELY(_confirmButton);
    TT_RELEASE_SAFELY(_productImageView);
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
    [[self showType] showRight];
    [self setTitleContent:@"INQUIRY FORM"];
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendRequestToGetCompanyServer) name:@"sendRequestToGetCompanyServer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inquiryFormNotification:) name:@"INQUIRYFORM" object:nil];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.toTextField];
    [self.scrollView addSubview:self.subjectTextField];
    [self.scrollView addSubview:self.messageTextField];
    [self.scrollView addSubview:self.pictureTextField];
    [self.scrollView addSubview:self.codeTextField];
    [self.scrollView addSubview:self.confirmButton];
    
#ifdef kUseSimulateData
    self.emailTextField.pubTextField.text = @"hr@163.com";
//    self.pwdTextField.pubTextField.text = @"111111";
//    self.titleTextField.pubTextField.text = @"111111";
#endif
    
    
    [self.scrollView setContentSize:CGSizeMake(320, 50 + 13 * kPubTextFieldHeight2  + kImageStartAt)];
    [self.view addSubview:self.scrollView];
//    self.emailTextField.pubTextField.text = [UserDefaultsManager userEmail];
    [self requestServerForCode];
    [self sendRequestToGetCompanyServer];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sendRequestToGetCompanyServer];
}

- (void) inquiryFormNotification:(NSNotification *) notification
{
    self.currentItem = notification.object;
    if (self.currentItem) {
//        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:YES];
        [self.scrollView scrollsToTop];
        self.subjectTextField.pubTextField.text = self.currentItem.productName;
        [self.productImageView setImageWithURL:[NSURL URLWithString:self.currentItem.productImg] placeholderImage:[UIImage imageNamed:@""]];
    }
}

- (void)sendRequestToGetCompanyServer
{
    if ([[self.toTextField.pubTextField text] length] != 0) {
        return;
    }
    __unsafe_unretained typeof(self) safeSelf = self;
    if ([[[AppDelegate sharedAppDelegate] rootController] aboutResponse]) {
        safeSelf.toTextField.pubTextView.text = [[[[AppDelegate sharedAppDelegate] rootController] aboutResponse] email];
        return;
    }
    [[[AppDelegate sharedAppDelegate] rootController] sendRequestToGetCompanyServer];
}


- (NSString *)tabImageName
{
    return @"email_black";
}

- (NSString *)tabSelectedImageName
{
    return @"email_white";
}

- (PubTextField *)emailTextField
{
    if (!_emailTextField) {
        __unsafe_unretained typeof(self) safeSelf = self;
        _emailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 0* kPubTextFieldHeight2  + kImageStartAt , 320, kPubTextFieldHeight) indexTitle:@"E-mail:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
//        _emailTextField.autoLayout = YES;
        _emailTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _emailTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _emailTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_emailTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.toTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _emailTextField;
}

- (PubTextField *)toTextField
{
    if (!_toTextField) {
        __unsafe_unretained typeof(self) safeSelf = self;
        _toTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 1* kPubTextFieldHeight2  + kImageStartAt , 320, 1.5*kPubTextFieldHeight) indexTitle:@"To:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        //        _toTextField.autoLayout = YES;
        _toTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _toTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _toTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_toTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.subjectTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _toTextField;
}

- (PubTextField *)subjectTextField
{
    if (!_subjectTextField) {
        __unsafe_unretained typeof(self) safeSelf = self;
        _subjectTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 2.5* kPubTextFieldHeight2  + kImageStartAt , 320, kPubTextFieldHeight) indexTitle:@"Subject:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        //        _subjectTextField.autoLayout = YES;
        _subjectTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _subjectTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _subjectTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_subjectTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.messageTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _subjectTextField;
}

- (PubTextField *)messageTextField
{
    if (!_messageTextField) {
        __unsafe_unretained typeof(self) safeSelf = self;
        _messageTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 3.5* kPubTextFieldHeight2  + kImageStartAt , 320, 3*kPubTextFieldHeight) indexTitle:@"Message:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        //        _messageTextField.autoLayout = YES;
        _messageTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _messageTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _messageTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_messageTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.codeTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _messageTextField;
}


- (PubTextField *)pictureTextField
{
    if (!_pictureTextField) {
        _pictureTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 6.5 * kPubTextFieldHeight2  + kImageStartAt-2, 320, 3*kPubTextFieldHeight) indexTitle:@"Picture:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleBottom];
        //        _pictureTextField.autoLayout = YES;
        _pictureTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _pictureTextField.pubTextField.enabled = NO;
        _pictureTextField.pubTextView.editable = NO;
        [_pictureTextField addSubview:[self productImageView]];
        _pictureTextField.pubTextField.returnKeyType = UIReturnKeyNext;
        _pictureTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_pictureTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [_codeTextField becomeFirstResponder];
            return YES;
        }];
    }
    return _pictureTextField;
}


- (PubTextField *)codeTextField
{
    if (!_codeTextField) {
        __unsafe_unretained typeof(self) safeSelf = self;
        _codeTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 9.5 * kPubTextFieldHeight2  + kImageStartAt-4, 320, kPubTextFieldHeight) indexTitle:@"Code:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleBottom];
        _codeTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _codeTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.pubTextField.frame = CGRectMake(90, 5, 100, 30);
        _codeTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_codeTextField addSubview:[self codeImageView]];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(208, 0, 2, kPubTextFieldHeight);
        layer.backgroundColor = [[UIColor getColor:@"EBEAF1"] CGColor];
        [_codeTextField.layer addSublayer:layer];
        
        [_codeTextField.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.codeTextField resignFirstResponder];
            return YES;
        }];
    }
    return _codeTextField;
}

- (UIImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(91,  10, 100, 100)];
        _productImageView.backgroundColor = [UIColor getColor:@"EBEAF1"];
    }
    return _productImageView;
}

- (UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(210,  0, 110, kPubTextFieldHeight)];
        _codeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeAction:)] autorelease];
        [_codeImageView addGestureRecognizer:recognizer];
    }
    return _codeImageView;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(0.0f, 25 + 10.5 * kPubTextFieldHeight2  + kImageStartAt, 320.0f, 40.0f);
        _confirmButton.backgroundColor = kClearColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"SEND" forState:UIControlStateNormal];
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
    [self resignFirstResponder];
    [self requestServerForRegister:sender];
}

- (BOOL)checkTextField
{
    if (![self.checkCodeResponse isChecked]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正常的验证码信息"];
        [_codeTextField.pubTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}

- (void) loadCodeImageView:(VerifyCodeResponse *) response
{
    NSString *keyString = [NSString stringWithFormat:@"%@&1=%d",response.imageUrl, (NSUInteger)(arc4random() % NSUIntegerMax)];
    [self.codeImageView setImageWithURL:[NSURL URLWithString:keyString] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)requestServerForCode
{
    __unsafe_unretained typeof(self) safeSelf = self;
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
    [SVProgressHUD showWithStatus:@"正在检验..."];
       __unsafe_unretained typeof(self) safeSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.checkCodeResponse = [[[CheckVerifyCodeResponse   alloc] initWithJsonString:content] autorelease];
        if ([safeSelf.checkCodeResponse isChecked]) {
            [safeSelf requestServerForRegister:nil];
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
    };

    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
        [safeSelf requestServerForRegister:nil];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
        [safeSelf requestServerForRegister:nil];
    };

    CheckVerifyCodeRequest *codeRequest = [[[CheckVerifyCodeRequest alloc] init] autorelease];
    codeRequest.verifyCode = self.codeTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[codeRequest URLString] body:[codeRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}

- (void)requestServerForRegister:(id)sender
{
    [self.view endEditing:YES];
    if (![self.checkCodeResponse isChecked]) {
        [self requestServerToCheckCode];
        return;
    }
    if (![self checkTextField]) {
        DEBUGLOG(@"check failed.");
        return;
    }
    [self.confirmButton setEnabled:NO];
    __unsafe_unretained typeof(self) safeSelf = self;
    [SVProgressHUD showWithStatus:@"正在提交订单..."];
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        [SVProgressHUD showSuccessWithStatus:@"提交订单成功!"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"提交订单失败"];
        [safeSelf.confirmButton setEnabled:YES];
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
        [safeSelf.confirmButton setEnabled:YES];
    };
    CreateOrderRequest *createOrderRequest = [[[CreateOrderRequest alloc] init] autorelease];
    createOrderRequest.username = [UserDefaultsManager userName];
    createOrderRequest.title = [self.subjectTextField.pubTextField text];
    createOrderRequest.content = self.messageTextField.pubTextView.text.length == 0 ? @"": self.messageTextField.pubTextView.text;
    createOrderRequest.productList = self.currentItem ? self.currentItem.productId : @"";
    createOrderRequest.quantityList = @"";
    createOrderRequest.email = self.emailTextField.pubTextField.text;
    createOrderRequest.verifyCode = self.codeTextField.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[createOrderRequest URLString] body:[createOrderRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

@end
