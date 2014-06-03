//
//  RootViewController.h
//  sport
//
//  Created by allen.wang on 5/15/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "AKTabBarController.h"

@interface RootViewController : AKTabBarController<AKTabBarController,UIAlertViewDelegate>

@property (nonatomic,assign)NSInteger currentFrom;

- (id)initWithTabBarHeight:(NSUInteger)height;
@end
