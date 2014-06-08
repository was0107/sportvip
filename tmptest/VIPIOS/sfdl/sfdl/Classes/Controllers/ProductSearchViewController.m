//
//  ProductSearchViewController.m
//  sfdl
//
//  Created by allen.wang on 6/8/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "ProductSearchViewController.h"
#import "PubTextField.h"
#import "CreateObject.h"

@interface ProductSearchViewController ()
@property (nonatomic, retain) PubTextField *geneset, *prime, *standby, *cummins, *stamford;
@property (nonatomic, retain) UIButton     *confirmButton;

@end

@implementation ProductSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.secondTitleLabel.text = @"Product Search";
    [self.scrollView addSubview:self.geneset];
    [self.scrollView addSubview:self.prime];
    [self.scrollView addSubview:self.standby];
    [self.scrollView addSubview:self.cummins];
    [self.scrollView addSubview:self.stamford];
    [self.scrollView addSubview:self.confirmButton];
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

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_geneset);
    TT_RELEASE_SAFELY(_prime);
    TT_RELEASE_SAFELY(_stamford);
    TT_RELEASE_SAFELY(_cummins);
    TT_RELEASE_SAFELY(_standby);
    TT_RELEASE_SAFELY(_confirmButton);
    [super reduceMemory];
}


- (PubTextField *)geneset
{
    if (!_geneset) {
        __unsafe_unretained ProductSearchViewController *safeSelf = self;
        _geneset = [[PubTextField alloc] initWithFrame:CGRectMake(0, 15, 304, 40) indexTitle:@"GenSets Model:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
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
        __unsafe_unretained ProductSearchViewController *safeSelf = self;
        _prime = [[PubTextField alloc] initWithFrame:CGRectMake(0, 62, 304, 40) indexTitle:@"Prime Power:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _prime.pubTextField.returnKeyType = UIReturnKeyNext;
        _prime.autoLayout = YES;
        _prime.pubTextField.keyboardType = UIKeyboardTypeDefault;
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
        __unsafe_unretained ProductSearchViewController *safeSelf = self;
        _standby = [[PubTextField alloc] initWithFrame:CGRectMake(0, 110, 304, 40) indexTitle:@"Standby Power:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
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
        __unsafe_unretained ProductSearchViewController *safeSelf = self;
        _cummins = [[PubTextField alloc] initWithFrame:CGRectMake(0, 160, 304, 40) indexTitle:@"Cummins Engine:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _cummins.pubTextField.returnKeyType = UIReturnKeyNext;
        _cummins.autoLayout = YES;
        _cummins.pubTextField.keyboardType = UIKeyboardTypeDefault;
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
        __unsafe_unretained ProductSearchViewController *safeSelf = self;
        _stamford = [[PubTextField alloc] initWithFrame:CGRectMake(0, 208, 304, 40) indexTitle:@"Stanfird Alternator:" placeHolder:@"" pubTextFieldStyle:PubTextFieldStyleTop];
        _stamford.pubTextField.returnKeyType = UIReturnKeyDone;
        _stamford.autoLayout = YES;
        _stamford.pubTextField.keyboardType = UIKeyboardTypeDefault;
        [_stamford.pubTextField onShouldReturn:^(UITextField *textField){
            [safeSelf.stamford resignFirstResponder];
            [safeSelf confirmButtonAction:nil];
            return YES;
        }];
    }
    return _stamford;
}


- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _confirmButton.frame = CGRectMake(8.0f, 260.0f, 104.0f, 40.0f);
        _confirmButton.backgroundColor = kLightGrayColor;
        [_confirmButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [CreateObject addTargetEfection:_confirmButton];
        [_confirmButton setTitle:@"Submit" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}


- (IBAction)confirmButtonAction:(id)sender
{
    [self.view resignFirstResponder];
}

@end
