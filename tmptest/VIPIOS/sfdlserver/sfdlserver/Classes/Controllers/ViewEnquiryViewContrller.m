//
//  ViewEnquiryViewContrller.m
//  sfdl
//
//  Created by boguang on 14-7-28.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "ViewEnquiryViewContrller.h"
#import "ProductRequest.h"
#import "ProductResponse.h"
#import "CreateObject.h"
#import "UIKeyboardAvoidingScrollView.h"

@interface ViewEnquiryViewContrller()<UITextViewDelegate>
@property (nonatomic, retain) ViewEnquiryRequest           *request;
@property (nonatomic, retain) ViewEnquiryResponse          *response;
@property (nonatomic, retain) UITextView                   *commentView;
@property (nonatomic, retain) UIButton                     *submitButton;
@property (nonatomic, retain) UIView                       *footerView;
@property (nonatomic, retain) UILabel                      *titleLabel;
@property (nonatomic, retain) UILabel                      *timeLabel;
@property (nonatomic, retain) UILabel                      *contentLabel;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView *scrollView;

@end

@implementation ViewEnquiryViewContrller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView = [[[UIKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0,  0, 320.0, kContentBoundsHeight)] autorelease];
    self.scrollView.backgroundColor = kClearColor;
    self.scrollView.contentSize = CGSizeMake(320, kContentBoundsHeight);
    CGRect rect = CGRectMake(0, 40, 320.0, kContentBoundsHeight-40);
    rect.origin.y = rect.size.height - 44 - 44 - 20;
    rect.size.height = 140;
    self.footerView.frame = rect;
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.timeLabel];
    [self.scrollView addSubview:self.contentLabel];
    [self.scrollView addSubview:self.footerView];
    [self.view addSubview:self.scrollView];
    [self sendRequestToServer];

}

- (UILabel *) titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 24)];
        _titleLabel.textColor  = [UIColor getColor:kCellLeftColor];
        _titleLabel.backgroundColor = kClearColor;
        _titleLabel.font = HTFONTSIZE(kSystemFontSize17);
    }
    return _titleLabel;
}

- (UILabel *) timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 300, 24)];
        _timeLabel.textColor  = [UIColor getColor:kCellLeftColor];
        _timeLabel.backgroundColor = kClearColor;
        _timeLabel.font = HTFONTSIZE(kSystemFontSize17);
    }
    return _timeLabel;
}

- (UILabel *) contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 300, 100)];
        _contentLabel.textColor  = [UIColor getColor:kCellLeftColor];
        _contentLabel.backgroundColor = kClearColor;
        _contentLabel.font = HTFONTSIZE(kSystemFontSize17);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setItem:(EnquiryItem *)item
{
    if (_item != item) {
        [_item release];
        _item  = [item retain];
        
        self.titleLabel.text = self.item.title;
        self.timeLabel.text = self.item.sendTime;
        self.contentLabel.text = self.item.content;
    }
}

- (UITextView *) commentView
{
    if (!_commentView) {
        _commentView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10+24, 300, 60)];
        _commentView.layer.cornerRadius = 2.0f;
        _commentView.returnKeyType  = UIReturnKeyDone;
        _commentView.delegate = self;
        _commentView.layer.borderColor = [kBlueColor CGColor];
        _commentView.layer.borderWidth = 1.0f;
    }
    return _commentView ;
}

- (UIButton *) submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _submitButton.frame = CGRectMake(10, 75+24, 80, 30);
        [CreateObject addTargetEfection:_submitButton];
        [_submitButton setTitle:@"submit" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (UIView *) footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 130)];
        UILabel *tipLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 4, 300, 20)] autorelease];
        tipLabel1.text = @"Remark:";
        tipLabel1.font = HTFONTSIZE(kFontSize14);
        [_footerView addSubview:tipLabel1];
        [_footerView addSubview:self.commentView];
        [_footerView addSubview:self.submitButton];
        _footerView.backgroundColor = kClearColor;
    }
    return _footerView;
}

- (IBAction)submitButtonAction:(id)sender
{
    if ([self.commentView.text length] == 0) {
        [SVProgressHUD showSuccessWithStatus:@"Remark不能为空"];
        return;
    }
    [self.commentView resignFirstResponder];
    __block typeof(self) blockSelf = self;
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        blockSelf.commentView.text = @"";
        [SVProgressHUD showSuccessWithStatus:@"回复成功!"];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    ReplyEnquiryRequest *replyRequest = [[[ReplyEnquiryRequest alloc] init] autorelease];
    replyRequest.username = [UserDefaultsManager userName];
    replyRequest.enquiryId = self.item.enquiryId;
    replyRequest.title = self.item.title;
    replyRequest.content = self.commentView.text;
    [WASBaseServiceFace serviceWithMethod:[replyRequest URLString] body:[replyRequest toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) {
        [self.commentView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.commentView resignFirstResponder];
}


- (void)sendRequestToServer
{
    __block typeof(self) safeSelf = self;
    
    idBlock succBlock = ^(id content){
        DEBUGLOG(@"succ content %@", content);
        safeSelf.response = [[[ViewEnquiryResponse alloc] initWithJsonString:content] autorelease];
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
        [[[[ErrorResponse alloc] initWithJsonString:content] autorelease] show];
    };
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    if (!self.request) {
        self.request = [[[ViewEnquiryRequest alloc] init] autorelease];
    }
    self.request.username = [UserDefaultsManager userName];
    self.request.enquiryId = self.item.enquiryId;
    [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:errBlock];
}


@end
