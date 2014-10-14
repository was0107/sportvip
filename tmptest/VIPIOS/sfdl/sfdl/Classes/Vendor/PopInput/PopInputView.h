//
//  PopInputView.h
//  sfdl
//
//  Created by micker on 14-9-23.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopInputView : UIView
@property (nonatomic, assign) UIViewController *controller;
@property (nonatomic, assign) BOOL isShowing;
- (void)show;
- (void)dismiss;


@end
