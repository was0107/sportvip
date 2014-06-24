//
//  CustomSearchBar.m
//  sfdl
//
//  Created by allen.wang on 6/5/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
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
        _searchField.placeholder = @"搜索";
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
        iconbg.borderColor = kGrayColor;
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
