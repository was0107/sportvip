//
//  BaseViewController.h
//  Discount
//
//  Created by allen.wang on 5/27/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "UIColor+extend.h"

@interface BaseViewController : UIViewController
@property (nonatomic, copy)     NSString    *trackViewId;

- (void) reduceMemory;

- (id) setButtonImage:(UIButton *) button normal:(NSString *) Image higlited:(NSString *)selectImage;

- (id) setButtonBackground:(UIButton *) button normal:(NSString *) bgImage higlited:(NSString *)bgSelectImage;

- (NSString *) currentCity;

- (NSString *) currentUserId;

- (BOOL) didUserLogined;

- (void) currentCityChanged;

- (BOOL) enableExtendLayout;

- (NSString *)trimWhitespaceAndNewlineCharacter:(NSString *)rawString;

-(BOOL)isValidateEmail:(NSString *)email;

- (int) checkYear:(int) year month:(int) month;

- (void) enableBackGesture;

@end
