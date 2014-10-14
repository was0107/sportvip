//
//  B5M_Constant.h
//  comb5mios
//
//  Created by Jarry Zhu on 12-5-15.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#ifndef comb5mios_B5M_Constant_h
#define comb5mios_B5M_Constant_h

// 判断是否iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kHeightIncrease  (iPhone5 ? 88 : 0)

//判断是否是IOS7系统
//#define IS_IOS_7_OR_GREATER  (NO)
#define IS_IOS_7_OR_GREATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//#define VIEW_Y_START   (0)
#define VIEW_Y_START   ((IS_IOS_7_OR_GREATER ) ? 20 : 0)

#define TABLE_VIEW_SEPEARATE(X)  {\
if (IS_IOS_7_OR_GREATER) { \
X.separatorStyle = UITableViewCellSeparatorStyleSingleLine;\
X.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);\
}}

//#define TABLE_VIEW_SEPEARATE(X) {\
//if (IS_IOS_7_OR_GREATER) { \
//    X.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"register_line_icon"]];\
//    X.separatorStyle = UITableViewCellSeparatorStyleSingleLine;\
//    X.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0);\
//}}

#define TABLE_VIEW_HEADERVIEW(X)   IS_IOS_7_OR_GREATER ? [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, X)] autorelease] : nil

//
// ARC on iOS 4 and 5
//
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0 && !defined (GM_DONT_USE_ARC_WEAK_FEATURE)

#define b5m_weak   weak
#define __b5m_weak __weak
#define b5m_nil(x)

#else

#define b5m_weak   unsafe_unretained
#define __b5m_weak __unsafe_unretained
#define b5m_nil(x) x = nil

#endif


#endif
