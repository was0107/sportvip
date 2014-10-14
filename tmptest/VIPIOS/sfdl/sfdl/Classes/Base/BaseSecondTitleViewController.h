//
//  BaseSecondTitleViewController.h
//  sfdl
//
//  Created by micker on 6/5/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIKeyboardAvoidingScrollView.h"

@interface BaseSecondTitleViewController : BaseTableViewController
@property (nonatomic, retain) UILabel *secondTitleLabel;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView *scrollView;


@end
