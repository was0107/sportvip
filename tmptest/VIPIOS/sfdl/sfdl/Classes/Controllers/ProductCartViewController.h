//
//  ProductCartViewController.h
//  sfdl
//
//  Created by micker on 6/26/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "BaseSecondTitleViewController.h"
#import "ProductCart.h"

@interface ProductCartViewController : BaseSecondTitleViewController  <UITextViewDelegate>

@property (nonatomic, retain) UITextView *commentView;
@property (nonatomic, retain) UIButton   *submitButton,*goBackShoppingButton;
@property (nonatomic, retain) UIView     *footerView;
@property (nonatomic, retain) UILabel    *tipLabel;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView            *scrollView;

@end
