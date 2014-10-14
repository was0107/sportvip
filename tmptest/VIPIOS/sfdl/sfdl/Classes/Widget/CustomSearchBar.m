//
//  CustomSearchBar.m
//  sfdl
//
//  Created by micker on 6/5/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "CustomSearchBar.h"

@interface CustomSearchBar()<UITextFieldDelegate>


@end

@implementation CustomSearchBar
@synthesize searchField= _searchField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _searchField = [[UITextField alloc] initWithFrame:CGRectMake(44, 4, 270, 44)];
        _searchField.placeholder = @"Search Product";
        _searchField.borderStyle = UITextBorderStyleNone;
        _searchField.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _searchField.font = SYSTEMFONT(kSystemFontSize15);
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.backgroundColor = kClearColor;
        _searchField.delegate = self;
        
        CALayer *iconbg = [CALayer layer];
        iconbg.frame = CGRectMake(8, 8, 304, 36);
        iconbg.borderColor = [kGrayColor CGColor];
        iconbg.backgroundColor = [kWhiteColor CGColor];
        iconbg.cornerRadius = 2.0f;
        iconbg.borderWidth = 2.0f;
        [self.layer addSublayer:iconbg];
        
        UIImageView *icon = [[[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 24, 24)] autorelease];;
        [icon setImage:[UIImage imageNamed:@"ic_search_icon"]];
        icon.backgroundColor = kClearColor;
        [self addSubview:_searchField];
        [self  addSubview:icon];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_searchField);
    TT_RELEASE_SAFELY(_completeBlok);
    [super dealloc];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *newString = [textField text];
    if (self.completeBlok) {
        self.completeBlok(newString);
    }
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [textField resignFirstResponder];

    return YES;
}


@end



@implementation CustomSearchBarEx



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = kOrangeColor;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 233, 46)];
        bgView.backgroundColor = kWhiteColor;
        [self addSubview:bgView];
        
        
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 220, 40)];
        _label1.textColor = kBlackColor;
        _label1.text = @"We're now providing comprehensive stable and timely solutions for Electricity ...";
        _label1.numberOfLines = 2;
        _label1.font = HTFONTSIZE(kFontSize12);
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(240, 30, 70, 20)];
        _label2.textColor = kWhiteColor;
        _label2.backgroundColor = kClearColor;
        _label2.text = @"Send Email";
        _label2.numberOfLines = 2;
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.font = HTFONTSIZE(kFontSize12);
        
        UIImageView *icon = [[[UIImageView alloc] initWithFrame:CGRectMake(265, 5, 24, 24)] autorelease];;
        [icon setImage:[UIImage imageNamed:@"home_email"]];
        icon.backgroundColor = kClearColor;
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:icon];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_label2);
    TT_RELEASE_SAFELY(_label1);
    [super dealloc];
}


@end
