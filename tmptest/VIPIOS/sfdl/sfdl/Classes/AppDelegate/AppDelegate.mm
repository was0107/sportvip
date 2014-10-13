//
//  AppDelegate.m
//  sport
//
//  Created by allen.wang on 4/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AppDelegate.h"
#import "ProductRequest.h"
#import "ProductResponse.h"

NSString *updateURL = nil;


@interface AppDelegate()<UIAlertViewDelegate>

@end


@implementation AppDelegate
- (id)init
{
    if(self = [super init])
    {
        _viewDelegate = [[AGViewDelegate alloc] init];
    }
    return self;
}


+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate*) [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ShareSDK registerApp:@"221de9be5bbc"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    [self configShareKeys];
    if (IS_IOS_7_OR_GREATER) {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	    [application setStatusBarStyle:UIStatusBarStyleDefault];
    } else
    {
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    }
    
    self.rootController = [[[RootViewControllerEx alloc] initWithTabBarHeight:45.0f] autorelease];
    UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:self.rootController] autorelease];
    controller.view.backgroundColor = [UIColor getColor:@"EBEAF1"];
    [controller setNavigationBarHidden:NO animated:NO];
//    [UINavigationBar appearance].barTintColor = kButtonNormalColor;
//    controller.navigationBar.barTintColor = kButtonNormalColor;
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [controller setToolbarHidden:YES animated:NO];
    self.window.rootViewController = self.rootController;
//    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) configShareKeys
{
    //添加Facebook应用  注册网址 https://developers.facebook.com
    [ShareSDK connectFacebookWithAppKey:@"107704292745179"
                              appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    
    
    
    //添加Twitter应用  注册网址  https://dev.twitter.com
    [ShareSDK connectTwitterWithConsumerKey:@"MZzQDNKt0lE8c2BL0lIu0empm"
                             consumerSecret:@"LJTUCaIfkkReZkTEUrXU2nZFh90UGUz6qvmhfnzNnfqp6MdsNu"
                                redirectUri:@"http://www.sharesdk.cn"];
    
    
    //添加LinkedIn应用  注册网址 https://www.linkedin.com/secure/developer
    [ShareSDK connectLinkedInWithApiKey:@"75s8cjmc1lmj04"
                              secretKey:@"nbUZLf0Mtk9XMlKL"
                            redirectUri:@"http://sharesdk.cn"];
    
    /**
     连接Google+应用以使用相关功能，此应用需要引用GooglePlusConnection.framework、GooglePlus.framework和GoogleOpenSource.framework库
     https://code.google.com/apis/console上注册应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectGooglePlusWithClientId:@"232554794995.apps.googleusercontent.com"
                               clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                                redirectUri:@"http://localhost"
                                  signInCls:[GPPSignIn class]
                                   shareCls:[GPPShare class]];
    
    /**
     连接Pinterest应用以使用相关功能，此应用需要引用Pinterest.framework库
     http://developers.pinterest.com/上注册应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectPinterestWithClientId:@"1432928"
                              pinterestCls:[Pinterest class]];
    
    
    /**
     链接Flickr,此平台需要引用FlickrConnection.framework框架。
     http://www.flickr.com/services/apps/create/上注册应用，并将相关信息填写以下字段。
     **/
    [ShareSDK connectFlickrWithApiKey:@"33d833ee6b6fca49943363282dd313dd"
                            apiSecret:@"3a2c5b42a8fbb8bb"];

    
    
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
    TT_RELEASE_SAFELY(_viewDelegate);
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
