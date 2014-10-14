//
//  InquiryDetailViewController.m
//  sfdl
//
//  Created by micker on 14-9-24.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "InquiryDetailViewController.h"

#import "PubTextField.h"
#import "IdentifierValidator.h"
#import "ProductRequest.h"
#import "LoginRequest.h"
#import "LoginResponse.h"
#import "UIKeyboardAvoidingScrollView.h"
#import "CreateObject.h"
#import "UIImageView+WebCache.h"


@interface InquiryDetailViewController ()
@property (nonatomic, retain) PubTextField            *emailTextField;
@property (nonatomic, retain) PubTextField            *toTextField;
@property (nonatomic, retain) PubTextField            *subjectTextField;
@property (nonatomic, retain) PubTextField            *messageTextField;
@property (nonatomic, retain) PubTextField            *pictureTextField;
@property (nonatomic, retain) PubTextField            *codeTextField;
@property (nonatomic, retain) UIImageView             *productImageView;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;


@property (nonatomic, retain) OrderItem             *detailItem;
@property (nonatomic, retain) ViewOrderRequest      *request;
@property (nonatomic, retain) ViewOrderResponse     *response;

@end

@implementation InquiryDetailViewController

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_emailTextField);
    TT_RELEASE_SAFELY(_toTextField);
    TT_RELEASE_SAFELY(_subjectTextField);
    TT_RELEASE_SAFELY(_messageTextField);
    TT_RELEASE_SAFELY(_pictureTextField);
    TT_RELEASE_SAFELY(_codeTextField);
    TT_RELEASE_SAFELY(_productImageView);
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    [super reduceMemory];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleContent:NSLocalizedString(@"INQUIRY DETAIL",@"INQUIRY DETAIL")];
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.toTextField];
    [self.scrollView addSubview:self.subjectTextField];
    [self.scrollView addSubview:self.messageTextField];
//    [self.scrollView addSubview:self.pictureTextField];
    [self.scrollView addSubview:self.codeTextField];
    
    [self.scrollView setContentSize:CGSizeMake(320, 50 + 10 * kPubTextFieldHeight2  + kImageStartAt)];
    [self.view addSubview:self.scrollView];
    
    [self sendRequestToServer];
    // Do any additional setup after loading the view.
}

- (PubTextField *)emailTextField
{
    if (!_emailTextField) {
        __unsafe_unretained typeof(self) safeSelf = self;
        _emailTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 0* kPubTextFieldHeight2  + kImageStartAt , 320, 1.5*kPubTextFieldHeight) indexTitle:@"E-mail:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        //        _emailTextField.autoLayout = YES;
        [_emailTextField setEditable:NO];
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
        _toTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0, 10 + 1.5* kPubTextFieldHeight2  + kImageStartAt , 320, kPubTextFieldHeight) indexTitle:@"To:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        //        _toTextField.autoLayout = YES;
        [_toTextField setEditable:NO];
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
        [_subjectTextField setEditable:NO];
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
        [_messageTextField setEditable:NO];
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
        _pictureTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 6.5 * kPubTextFieldHeight2  + kImageStartAt, 320, 3*kPubTextFieldHeight) indexTitle:@"Picture:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleBottom];
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
        _codeTextField = [[PubTextField alloc] initWithFrame:CGRectMake(0,  10 + 6.5 * kPubTextFieldHeight2  + kImageStartAt - 2, 320, kPubTextFieldHeight) indexTitle:@"Progress:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleBottom];
        [_codeTextField setEditable:NO];
        _codeTextField.indexLabel.textAlignment = NSTextAlignmentRight;
        _codeTextField.pubTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.pubTextField.keyboardType = UIKeyboardTypeDefault;
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

- (void) setDetailItem:(OrderItem *)detailItem
{
    _detailItem = detailItem;
    self.emailTextField.pubTextView.text = [NSString stringWithFormat:@"%@\n%@", _detailItem.enquiryEmail, _detailItem.sendTime];
    self.toTextField.pubTextField.text = _detailItem.toEmail;
    self.subjectTextField.pubTextField.text = _detailItem.title;
    self.messageTextField.pubTextView.text = _detailItem.content;
    self.codeTextField.pubTextField.text = _detailItem.status;
}


- (void) sendRequestToServer
{
    __unsafe_unretained typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.response = [[ViewOrderResponse alloc] initWithJsonString:content];
        blockSelf.detailItem = [blockSelf.response orderItem];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
        [blockSelf.tableView tableViewDidFinishedLoading];
    };
    if (!_request) {
        self.request = [[[ViewOrderRequest alloc] init] autorelease];
    }
    self.request.username = [UserDefaultsManager userName];
    self.request.orderId = self.item.orderId;
    [WASBaseServiceFace serviceWithMethod:[self.request URLString] body:[self.request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}



@end
