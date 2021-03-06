//
//  GlobalConfig.h
//  GoDate
//
//  Created by lei zhang on 13-7-25.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#ifndef globalConfig_h
#define globalConfig_h


#ifndef  AUTO_SHELL_BUILD   //

/*****************************************************
 * 全局参数配置
 * 发布版本时需要配置的主要参数：
 *  1.版本号
 *  2.渠道ID
 *  3.服务器地址
 *****************************************************/

/*
 *  版本号，主要显示在关于页面
 */

#define B5M_VERSION     @"Version 1.0  Build 1"
#define TD_ChannelID    @"AppStore"

#define kAPPID          @"896077200"



/*
 *  服务器配置
 */
//#define kUseSimulateData    0     //打开表示使用测试环境
// 测试环境
#ifdef kUseSimulateData     

//#define kHostDomain         @"http://116.255.202.113:8080/"    // test stage
//#define kHostDomain         @"http://172.16.6.14:8180/sportvip/"    // test stage
#define kHostDomain         @"http://yundongvip.cn/api/"    // test stage


// 正式环境
#else       

#define kHostDomain         @"http://yundongvip.cn/api/"

#endif  

#define kImageHostDomain    @"http://img.b5m.com/image/"


#endif

#endif
