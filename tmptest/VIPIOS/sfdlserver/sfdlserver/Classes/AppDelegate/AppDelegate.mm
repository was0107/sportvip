//
//  AppDelegate.m
//  sport
//
//  Created by allen.wang on 4/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "ProductRequest.h"
#import "ProductResponse.h"

NSString *updateURL = nil;


@interface AppDelegate()<UIAlertViewDelegate>
@property (nonatomic, retain) ServerLoginViewController *rootController;

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
    self.rootController = [[[ServerLoginViewController alloc] init] autorelease];
    UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:self.rootController] autorelease];
    controller.navigationBar.backgroundColor = kButtonNormalColor;
    [controller setNavigationBarHidden:NO];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    [self moniterJpush];
    // Required
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    // Required
    [APService setupWithOption:launchOptions];
    
    if ([UserDefaultsManager userName].length > 0) {
        [APService setTags:[NSSet setWithObject:@"IOS"] alias:[UserDefaultsManager userName]];
    }
    
    return YES;
}


- (void) checkVersion
{
    idBlock successedBlock = ^(id content){
        DEBUGLOG(@"success conent %@", content);
        CheckVersionResponse *response = [[CheckVersionResponse alloc] initWithJsonString:content];
        if ([response isNeedToTip]) {
            updateURL = response.download_url;
            UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Update" message:@"Detecte a new version" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Upgrade", nil] autorelease];
            [alertView show];
        };
    };
    
    idBlock failedBlock = ^(id content){
        DEBUGLOG(@"failed content %@", content);
    };
    
    idBlock errBlock = ^(id content){
        DEBUGLOG(@"error content %@", content);
    };
    CheckVersionRequest *request = [[[CheckVersionRequest alloc] init] autorelease];
    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:successedBlock onFailed:failedBlock onError:errBlock];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateURL]];
    }
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
}


- (void) moniterJpush
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
}


//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif

#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"user info = %@ title = %@ content= %@", userInfo, title, content);
}

@end
