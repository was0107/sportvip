//
//  LaunchTransition.m
//  GoDate
//
//  Created by Eason on 8/14/13.
//  Copyright (c) 2013 www.b5m.com. All rights reserved.
//

#import "LaunchTransition.h"
#import "UIImageView+(ASI).h"
#import "AppDelegate.h"

@interface LaunchTransition ()
//@property(nonatomic, assign) NSInteger locationtimes;
@end

@implementation LaunchTransition


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
}

- (id)initWithViewController:(UIViewController *)controller transition:(UIModalTransitionStyle)transition
{
    self = [super init];
    if (self) {
        [controller setModalTransitionStyle:transition];
        [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(timerFireMethod:) userInfo:controller repeats:NO];
        }
    return self;
}

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition {
	return [self initWithViewController:controller animation:transition delay:2.0];
}

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition delay:(NSTimeInterval)seconds {
	self = [super init];
	
	if (self) {
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_iphone4"]] autorelease];
//        imageView.frame = self.view.bounds;
        imageView.frame = CGRectMake(0, self.view.bounds.origin.y - 20, self.view.bounds.size.width, self.view.bounds.size.height+20);
        imageView.alpha = 0.4f;
        NSString *picture = [UserDefaultsManager guidePicture];
        if (!picture) {
            imageView.image = [UIImage imageNamed:@"loading_iphone4"];
        } else {
            [imageView  setImageWithURL:[NSURL URLWithString:picture] placeholderImage:[UIImage imageNamed:@"loading_iphone4"] success:nil failure:nil];
        }
        [self.view addSubview:imageView];
        [UIView animateWithDuration:0.2f animations:^{
            imageView.alpha = 1.0f;
        }];
		[controller setModalTransitionStyle:transition];
        
        [self sendHttpLoginRequest];
        [self sendToGetGuidePicture];
		[NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(timerFireMethod:) userInfo:controller repeats:NO];
	}
	
	return self;
}

- (void)timerFireMethod:(NSTimer *)theTimer {
	[self presentModalViewController:[theTimer userInfo] animated:YES];
    [theTimer invalidate];
    
}

- (void)sendHttpLoginRequest
{
//    __unsafe_unretained LaunchTransition *safeSelf = self;
//    
//    idBlock succBlock = ^(id content){
//        DEBUGLOG(@"transition succ content %@", content);
//        UserInfoResponse *response = [[[UserInfoResponse alloc] initWithJsonString:content] autorelease];
//        [[UserInfoManager shareIstance] setUserInfoResponse:response];
//        [UserDefaultsManager saveUserId:response.userId];
//        [UserDefaultsManager savetoken:response.token];
//        [[CustomLocationManger shareInstance]location];
//        [safeSelf sendXmppLoginRequest];
//        
////        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerFireMethod:) userInfo:controller repeats:NO];
//    };
//    
//    idBlock failedBlock = ^(id content){
//        DEBUGLOG(@"transition failed content %@", content);
//        [SVProgressHUD showErrorWithStatus:@"账号或密码错误, 请重新登录!"];
//        UserInterFaceController *guideController = [APPDELEGATE guideController];
//        UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:(UIViewController *)guideController] autorelease];
//        navController.navigationBarHidden = YES;
//        [[APPDELEGATE window] setRootViewController:navController];
//    };
//    
//    LoginRequest *request = [[[LoginRequest alloc] init] autorelease];
//    request.email = [UserDefaultsManager userHttpAccount];
//    request.password = [SSKeychain passwordForService:kKeyChainServiceName account:[UserDefaultsManager userAccount]];
//    [WASBaseServiceFace serviceWithMethod:[request URLString]
//                                     body:[request toJsonString]
//                                    onSuc:succBlock
//                                 onFailed:failedBlock];
}

- (void)sendXmppLoginRequest
{
    DEBUGLOG(@"transition login xmpp");
//    [AccountManager loginTigase];
}


- (void) sendToGetGuidePicture
{
//    idBlock succBlock = ^(id content){
//        DEBUGLOG(@"GuidePictur succ content %@", content);
//        GuidePictureResponse *response = [[[GuidePictureResponse alloc] initWithJsonString:content] autorelease];
//        [UserDefaultsManager saveGuidePicture:response.picture.imgUrl];
//    };
//    
//    idBlock failedBlock = ^(id content){
//        DEBUGLOG(@"GuidePictur failed content %@", content);
//    };
//    
//    GuidePictureRequest *request = [[[GuidePictureRequest alloc] init] autorelease];
//    [WASBaseServiceFace serviceWithMethod:[request URLString] body:[request toJsonString] onSuc:succBlock onFailed:failedBlock];
}

@end
