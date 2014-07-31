//
//  BaseSecondTitleViewController.h
//  sfdl
//
//  Created by allen.wang on 6/5/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIKeyboardAvoidingScrollView.h"

@interface BaseSecondTitleViewController : BaseTableViewController
@property (nonatomic, retain) UILabel *secondTitleLabel;
@property (nonatomic, retain) UIKeyboardAvoidingScrollView *scrollView;


@end
