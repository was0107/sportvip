//
//  LeaveMessageViewController.m
//  sfdl
//
//  Created by micker on 6/8/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "LeaveMessageViewController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "PubTextField.h"
#import "CreateObject.h"
#import "ProductRequest.h"

@interface LeaveMessageViewController ()
@property (nonatomic, retain) PubTextField *geneset, *prime, *standby, *cummins, *stamford               , *codePub;
@property (nonatomic, retain) UIButton                *confirmButton;
@property (nonatomic, retain) SendMessageRequest      *request;
@property (nonatomic, retain) VerifyCodeResponse      *verifyCodeResponse;
@property (nonatomic, retain) CheckVerifyCodeResponse *checkCodeResponse;
@property (nonatomic, retain) UIImageView             *codeImageView;

@end

@implementation LeaveMessageViewController


- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_geneset);
    TT_RELEASE_SAFELY(_prime);
    TT_RELEASE_SAFELY(_standby);
    TT_RELEASE_SAFELY(_cummins);
    TT_RELEASE_SAFELY(_stamford);
    TT_RELEASE_SAFELY(_codePub);
    TT_RELEASE_SAFELY(_confirmButton);
    TT_RELEASE_SAFELY(_verifyCodeResponse);
    TT_RELEASE_SAFELY(_checkCodeResponse);
    TT_RELEASE_SAFELY(_codeImageView);
    TT_RELEASE_SAFELY(_request);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.secondTitleLabel.text = @"Leave Message";
    [self setTitleContent:NSLocalizedString(@"LEAVE MESSAGE","LEAVE MESSAGE")];

    [self.scrollView addSubview:self.geneset];
    [self.scrollView addSubview:self.prime];
    [self.scrollView addSubview:self.standby];
    [self.scrollView addSubview:self.cummins];
    [self.scrollView addSubview:self.stamford];
    [self.scrollView addSubview:self.codePub];
    [self.scrollView addSubview:self.codeImageView];
    [self.scrollView addSubview:self.confirmButton];
    [self requestServerForCode];
    [self.scrollView setContentSize:CGSizeMake(320, self.view.bounds.size.height + 1)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) useTablViewToShow
{
    return NO;
}

- (PubTextField *)geneset
{
    if (!_geneset) {
        __unsafe_unretained LeaveMessageViewController *safeSelf = self;
        _geneset = [[PubTextField alloc] initWithFrame:CGRectMake(0, 15, 304, 40) indexTitle:@"Name:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _geneset.pubTextField.returnKeyType = UIReturnKeyNext;
        _geneset.autoLayout = YES;
        _geneset.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_geneset.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.prime becomeFirstResponder];
            return YES;
        }];
    }
    return _geneset;
}


- (PubTextField *)prime
{
    if (!_prime) {
        __unsafe_unretained LeaveMessageViewController *safeSelf = self;
        _prime = [[PubTextField alloc] initWithFrame:CGRectMake(0, 62, 304, 40) indexTitle:@"E-mail:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _prime.pubTextField.returnKeyType = UIReturnKeyNext;
        _prime.autoLayout = YES;
        _prime.pubTextField.keyboardType = UIKeyboardTypeEmailAddress;
        [_prime.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.standby becomeFirstResponder];
            return YES;
        }];
    }
    return _prime;
}

- (PubTextField *)standby
{
    if (!_standby) {
        __unsafe_unretained LeaveMessageViewController *safeSelf = self;
        _standby = [[PubTextField alloc] initWithFrame:CGRectMake(0, 110, 304, 40) indexTitle:@"Company:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _standby.pubTextField.returnKeyType = UIReturnKeyNext;
        _standby.autoLayout = YES;
        _standby.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_standby.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.cummins becomeFirstResponder];
            return YES;
        }];
    }
    return _standby;
}

- (PubTextField *)cummins
{
    if (!_cummins) {
        __unsafe_unretained LeaveMessageViewController *safeSelf = self;
        _cummins = [[PubTextField alloc] initWithFrame:CGRectMake(0, 160, 304, 40) indexTitle:@"Tel:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _cummins.pubTextField.returnKeyType = UIReturnKeyNext;
        _cummins.autoLayout = YES;
        _cummins.pubTextField.keyboardType = UIKeyboardTypePhonePad;
        [_cummins.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.stamford becomeFirstResponder];
            return YES;
        }];
    }
    return _cummins;
}

- (PubTextField *)stamford
{
    if (!_stamford) {
        __unsafe_unretained LeaveMessageViewController *safeSelf = self;
        _stamford = [[PubTextField alloc] initWithFrame:CGRectMake(0, 208, 304, 100) indexTitle:@"Message:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _stamford.pubTextField.returnKeyType = UIReturnKeyNext;
        _stamford.autoLayout = YES;
        _stamford.indexLabel.frame = CGRectMake(8, 0, 304, 20);
        _stamford.pubTextField.frame = CGRectMake(8, 20, 304, 80);
        _stamford.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_stamford.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.codePub becomeFirstResponder];
            return YES;
        }];
    }
    return _stamford;
}


- (PubTextField *)codePub
{
    if (!_codePub) {
        __unsafe_unretained LeaveMessageViewController *safeSelf = self;
        _codePub = [[PubTextField alloc] initWithFrame:CGRectMake(10, 315, 120, 30) indexTitle:@"" placeHolder:@"Code" pubTextFieldStyle:PubTextFieldStyleTop];
        _codePub.pubTextField.frame = CGRectMake(0, 5, 100, 30);
        _codePub.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_codePub.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.codePub resignFirstResponder];
            [safeSelf confirmButtonAction:nil];
            return YES;
        }];
    }
    return _codePub;
}


- (UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(125,  320, 100, 30)];
        _codeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeAction:)] autorelease];
        [_codeImageView addGestureRecognizer:recognizer];
        _codeImageView.layer.borderColor = [kBlueColor CGColor];
        _codeImageView.layer.borderWidth = 1.0f;
        _codeImageView.layer.cornerRadius = 2.0f;
    }
    return _codeImageView;
}


- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(8.0f, 370.0f, 110.0f, 40.0f);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"Submit" forState:UIControlStateNormal];
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
    [self.view resignFirstResponder];
    [self sendRequestToServer];
}

- (void) loadCodeImageView:(VerifyCodeResponse *) response
{
    [self.codeImageView setImageWithURL:[NSURL URLWithString:response.imageUrl] placeholderImage:[UIImage imageNamed:kImageDefault]];
}

- (void)requestServerForCode
{
    __unsafe_unretained LeaveMessageViewController *safeSelf = self;
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
    __unsafe_unretained LeaveMessageViewController *safeSelf = self;
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.checkCodeResponse = [[[CheckVerifyCodeResponse   alloc] initWithJsonString:content] autorelease];
        if ([safeSelf.checkCodeResponse isChecked]) {
            [safeSelf sendRequestToServer];
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
        [safeSelf sendRequestToServer];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [SVProgressHUD showErrorWithStatus:@"检验失败!"];
        [safeSelf sendRequestToServer];
    };
    
    CheckVerifyCodeRequest *codeRequest = [[[CheckVerifyCodeRequest alloc] init] autorelease];
    codeRequest.verifyCode = self.codePub.pubTextField.text;
    [WASBaseServiceFace serviceWithMethod:[codeRequest URLString] body:[codeRequest toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}


- (void) sendRequestToServer
{
    if (![self.checkCodeResponse isChecked]) {
        [self requestServerToCheckCode];
        return;
    }

    [SVProgressHUD showWithStatus:@"正在提交..."];
    __unsafe_unretained LeaveMessageViewController *blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);        [SVProgressHUD showSuccessWithStatus:@"提交失败！"];

    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);        [SVProgressHUD showSuccessWithStatus:@"提交失败！"];

    };
    if (!_request) {
        self.request = [[[SendMessageRequest alloc] init] autorelease];
    }

    self.request.from = self.geneset.pubTextField.text;
    self.request.email = self.prime.pubTextField.text;;
    self.request.fromCompany = self.standby.pubTextField.text;;
    self.request.tel = self.cummins.pubTextField.text;;
    self.request.message = self.stamford.pubTextField.text;
    
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}


@end
