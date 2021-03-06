//
//  RootViewControllerEx.h
//  sfdl
//
//  Created by micker on 14-9-6.
//  Copyright (c) 2014年 micker. All rights reserved.
//

#import "AKTabBarController.h"
#import "LoginRequest.h"
#import "LoginResponse.h"

@interface RootViewControllerEx : AKTabBarController<AKTabBarController,UIAlertViewDelegate>

@property (nonatomic,assign)NSInteger currentFrom;

@property (nonatomic, retain) AboutUsResponse *aboutResponse;

- (id)initWithTabBarHeight:(NSUInteger)height;

- (void)sendRequestToGetCompanyServer;


@end
