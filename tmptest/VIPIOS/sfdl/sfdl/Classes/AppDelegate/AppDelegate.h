//
//  AppDelegate.h
//  sport
//
//  Created by micker on 4/15/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewControllerEx.H"
#import <ShareSDK/ShareSDK.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <Pinterest/Pinterest.h>
#import "AGViewDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) AGViewDelegate *viewDelegate;
@property (nonatomic, retain) RootViewControllerEx *rootController;

+ (AppDelegate *)sharedAppDelegate;

@end
