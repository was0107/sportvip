//
//  RootViewControllerEx.h
//  sfdl
//
//  Created by boguang on 14-9-6.
//  Copyright (c) 2014年 allen.wang. All rights reserved.
//

#import "AKTabBarController.h"

@interface RootViewControllerEx : AKTabBarController<AKTabBarController,UIAlertViewDelegate>

@property (nonatomic,assign)NSInteger currentFrom;

- (id)initWithTabBarHeight:(NSUInteger)height;

@end
