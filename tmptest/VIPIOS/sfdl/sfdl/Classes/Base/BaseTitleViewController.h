//
//  BaseTitleViewController.h
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButton+extend.h"
#import "KxMenu.h"
#import "CreateObject.h"
#import "AppDelegate.h"

@interface BaseTitleViewController : BaseViewController
@property (nonatomic, retain, readonly) UIView   *titleView;
@property (nonatomic, retain, readonly) UIButton *leftButton;
@property (nonatomic, retain, readonly) UIButton *rightButton;
@property (nonatomic, retain,         ) UILabel  *customTitleLable;


- (id) showLeft;

- (id) showRight;

- (id) hideRight;

- (IBAction) leftButtonAction:(id)sender;

- (IBAction) rightButtonAction:(id)sender;

- (void) setTitleContent:(NSString *) title;

- (UIView *) createTextField:(NSString *) title placeHolder:(NSString *)place tag:(NSInteger)tag column:(NSInteger)column height:(CGFloat)height delegate:(id)delegate;

- (void) enableRightButton:(BOOL) flag;

@end



@interface ShareTitleViewController : BaseTitleViewController
@property (nonatomic, retain) UIView          *rightView;

@end