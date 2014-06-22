//
//  AppDelegate.m
//  sport
//
//  Created by allen.wang on 4/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "STLocationInstance.h"
#import "iRate.h"

@interface AppDelegate()
@property (nonatomic, retain) RootViewController *rootController;

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    if (IS_IOS_7_OR_GREATER) {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	    [application setStatusBarStyle:UIStatusBarStyleDefault];
    } else
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    }
    self.rootController = [[[RootViewController alloc] init] autorelease];
    UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:self.rootController] autorelease];
    controller.navigationBar.backgroundColor = kButtonNormalColor;

//    [UINavigationBar appearance].barTintColor = kButtonNormalColor;
//    controller.navigationBar.barTintColor = kButtonNormalColor;
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [controller setNavigationBarHidden:NO];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        self.window.rootViewController = controller;
    }
    else
    {
        self.window.rootViewController = controller;
    }
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_rootController);
    TT_RELEASE_SAFELY(_window);
    [super dealloc];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
