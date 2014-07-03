//
//  FrameDefines.h
//  GoDate
//
//  Created by lei zhang on 13-7-25.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//


#ifndef  Gwm_FrameDefines_h
#define  Gwm_FrameDefines_h

#define kImageStartAt 10.0f


#define kNavigationBarHeight    44
#define kFilterViewWidth        187
#define kTopCellHeight          104
#define kBoundsHeight           (kHeightIncrease + 480)
#define kContentBoundsHeight    (kBoundsHeight - 20 - 44)

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
//#define kContentFrame           CGRectMake(0,0,320,kContentBoundsHeight)
//#define kContentWithBarFrame    CGRectMake(0,44,320,kContentBoundsHeight)
//#define kContentWithTwoBarFrame CGRectMake(0,44,320,kContentBoundsHeight-44)

#define kFullFrame CGRectMake(0, 0, 320.0, kBoundsHeight - 20)
#define kMenuContentFrame CGRectMake(0, (IS_IOS_7_OR_GREATER) ? 20 : 0, 320.0, kContentBoundsHeight)
#define kContentFrame CGRectMake(0, 0, 320.0, kContentBoundsHeight)
#define kContentNoBtmFrame CGRectMake(0, (IS_IOS_7_OR_GREATER) ? 20 : 0, 320.0, kContentBoundsHeight)
#define kContentWithSearchBarFrame CGRectMake(0, 44, 320.0, kContentBoundsHeight-44)
#define kContentWithTabBarFrame  CGRectMake(0, 0, 320.0, kContentBoundsHeight-44)

#define kHeaderLeftFrame        CGRectMake(5, 7, 49, 29)
#define kHeaderLeftFrame1       CGRectMake(5, 7, 49, 29)
#define kHeaderRightFrame       CGRectMake(270, 5, 40, 40)
#define kHeaderRightFrame1      CGRectMake(270, 7, 58, 29)
#define kHeaderRightFrame2      CGRectMake(270, 7, 70, 33)

//关于
#define kAboutLogoFrame         CGRectMake(102, 14+kHeightIncrease/2, 115, 115)
#define kAboutLabelOneFrame        CGRectMake(0, 130+kHeightIncrease/2, 320, 20)
#define kAboutLabelTwoFrame      CGRectMake(0, 260+kHeightIncrease, 320, 300)

#define kToolBarFrame           CGRectMake(0,kBoundsHeight-20-40,320,44)

//投票
#define kVoteViewBackgroundFrame    CGRectMake(0, 0, kScreenWidth ,kScreenHeight - 20)
#define kVoteViewContainerFrame     CGRectMake(10, (kScreenHeight - 400)/2, 300, 300)

#endif