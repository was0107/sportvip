//
//  AppDelegate.h
//  sport
//
//  Created by allen.wang on 4/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <Pinterest/Pinterest.h>
#import "AGViewDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) AGViewDelegate *viewDelegate;

@end
