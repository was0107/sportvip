//
//  LaunchTransition.h
//  GoDate
//
//  Created by Eason on 8/14/13.
//  Copyright (c) 2013 www.b5m.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchTransition : UIViewController

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition;

- (id)initWithViewController:(UIViewController *)controller animation:(UIModalTransitionStyle)transition delay:(NSTimeInterval)seconds;

- (id)initWithViewController:(UIViewController *)controller transition:(UIModalTransitionStyle)transition;

@end
