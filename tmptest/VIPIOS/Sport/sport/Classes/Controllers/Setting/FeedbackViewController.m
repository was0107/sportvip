//
//  FeedbackViewController.m
//  b5mei
//
//  Created by allen.wang on 4/17/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "FeedbackViewController.h"
#import "PlaceHolderTextView.h"
#import "FeedbackRequest.h"
#import "UIButton+extend.h"
#import "UIView+extend.h"
#import "CustomAnimation.h"


#define kFeedbackContentFrame       CGRectMake(20, 15, 280, 170)
#define kFeedbackWordsNumFrame      CGRectMake(265, 160, 30, 20)
#define kMaxFeedbackNumbers         200

@interface FeedbackViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, retain) PlaceHolderTextView   *contentTextView;
@property (nonatomic, retain) UILabel               *wordsNumbers;

@end

@implementation FeedbackViewController

@synthesize contentTextView = _contentTextView;
@synthesize wordsNumbers = _wordsNumbers;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = CGRectMake(10, 10, 300, 180);
    UIImageView *topImageView = [[[UIImageView alloc] initWithFrame: rect] autorelease];
    topImageView.backgroundColor = kWhiteColor;
//    topImageView.image = [[UIImage imageNamed:@"input_bg_complete"]stretchableImageWithLeftCapWidth:20 topCapHeight:10];
    [self.view addSubview:topImageView];
    [self.view addSubview:self.contentTextView];
    [self.view addSubview:self.wordsNumbers];
    [[self showRight] enableBackGesture];
    [self.rightButton setTitle:@"提交" forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_contentTextView);
    TT_RELEASE_SAFELY(_wordsNumbers);
    [super reduceMemory];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_contentTextView becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)rightButtonAction:(id)sender
{
    [_contentTextView resignFirstResponder];
    [self sendRequestToServer];
}

- (void) sendRequestToServer
{
    if (![self validateInput]) {
        return;
    }
    __block FeedbackViewController *blockSelf = self;
//    idBlock successedBlock = ^(id content)
//    {
//        // 提交成功
//        [SVProgressHUD showSuccessWithStatus:kTipFeedbackCommitSuccString];
//        [blockSelf.navigationController popViewControllerAnimated:YES];
//    };
//    
//    idBlock failedBlock = ^(id content)
//    {
//        [SVProgressHUD showErrorWithStatus:kTipFeedbackFaildString];
//    };
//    
//    FeedBackRequest *request = [[[FeedBackRequest alloc] init] autorelease];
//    request.userId = [UserDefaultsManager userId];
//    request.description = _contentTextView.text;
//    [WASBaseServiceFace serviceWithMethod:[request URLString]
//                                     body:[request toJsonString]
//                                    onSuc:successedBlock
//                                 onFailed:failedBlock
//                                  onError:failedBlock];
    
}

- (BOOL) validateInput
{
    if (!self.contentTextView.text || self.contentTextView.text.length == 0) {
        [CustomAnimation shakeAnimation:self.contentTextView duration:0.2 vigour:0.01 number:5  direction:1];
        return NO;
    }
    
    return YES;
}

#pragma mark - init
//
//- (UIButton *) rightButton
//{
//    UIButton *rightButton = [super rightButton];
//    if (rightButton) {
//        [rightButton setFrame: CGRectMake(260, 6, 55, 32)];
//        [rightButton setBackgroundImage:[UIImage imageNamed:@"sugest_submit_button"] forState:UIControlStateNormal];
//        [rightButton setTitle:@"提交" forState:UIControlStateNormal];
//        [[rightButton titleLabel] setFont:HTFONTSIZE(kFontSize18)];
//        [rightButton.titleLabel setShadowOffset:CGSizeMake(0, -1)];
//        [rightButton.titleLabel setShadowColor:kBlackColor];
//    }
//    
//    return rightButton;
//}


- (PlaceHolderTextView *) contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[PlaceHolderTextView alloc] initWithFrame:kFeedbackContentFrame];
        _contentTextView.placeholder = kFeedbackStringPlaceholder;
        _contentTextView.font = HTFONTSIZE(kFontSize16);
        _contentTextView.returnKeyType = UIReturnKeyDone;
        _contentTextView.layer.borderColor = kClearColor.CGColor;
        _contentTextView.layer.borderWidth = 1.0;
        _contentTextView.layer.cornerRadius = 5.0;
        _contentTextView.backgroundColor = kClearColor;
        _contentTextView.delegate = self;
        
    }
    return _contentTextView;
}

- (UILabel *) wordsNumbers
{
    if (!_wordsNumbers) {
        _wordsNumbers = [[UILabel alloc] initWithFrame:kFeedbackWordsNumFrame];
        _wordsNumbers.text = kIntToString(kMaxFeedbackNumbers);
        _wordsNumbers.backgroundColor = kClearColor;
        _wordsNumbers.textColor = [UIColor grayColor];
        _wordsNumbers.textAlignment = UITextAlignmentCenter;
        
    }
    return _wordsNumbers;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendRequestToServer];
    
    return YES;
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendRequestToServer];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    int textLength = textView.text.length;
    if (textLength <= kMaxFeedbackNumbers) {
        int remainLength = kMaxFeedbackNumbers - textLength;
        _wordsNumbers.text = kIntToString(remainLength);
    }else{
        textView.text = [textView.text substringToIndex:kMaxFeedbackNumbers];
        _wordsNumbers.text = kIntToString(0);
    }
}


@end
