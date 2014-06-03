//
//  UIView+Shake.h
//  comb5mios
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShakeAddition)

- (void)shakeStatus:(BOOL)enabled;
- (void)shakeForCount:(NSInteger)count;

@end
