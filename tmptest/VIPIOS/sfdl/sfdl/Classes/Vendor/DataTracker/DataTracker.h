//
//  DataTracker.h
//  comb5mios
//
//  Created by Jarry on 12-10-16.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define kUsingTalkingData
#define kUsingUMeng
//#define kUsingGoogleAnalytics

#pragma mark - import header

#ifdef kUsingUMeng
// UMeng
#import "MobClick.h"        
// Umeng Track Define
#define UMENG_APPKEY        @"51de620356240b2fc0005b77" //NOT USED
#endif

#ifdef kUsingGoogleAnalytics
// GA
//#import "GAI.h"
// GA Track
#define GA_TRACK_APPID      @"UA-44004129-1"

#ifdef DEBUG
#define GA_DISPATCH_PERIOD  5
#else
#define GA_DISPATCH_PERIOD  30
#endif

#endif

#pragma mark - constants define

// page id
#define TD_PAGE_SPLASH              @"启动页面"
#define TD_PAGE_DETAIL_SELF         @"个人主页"
#define TD_PAGE_DETAIL_OTHER        @"他人主页"
#define TD_PAGE_404_PV              @"tao_404_pv"


// event id
#define TD_EVENT_Category                       @"GWMAPP"
// GA

//#define TD_EVENT_INDEX_MAIN_FILTER_HOME_PV      @"特惠游首页"
//#define TD_EVENT_INDEX_MAIN_FILTER_TEN_PV       @"9.9包邮"
//#define TD_EVENT_INDEX_MAIN_FILTER_TWENTY_PV    @"19.9包邮"
//#define TD_EVENT_INDEX_MAIN_FILTER_ABOUT_PV     @"关于首页"


#define TD_EVENT_INDEX_SUB_CATEGORY_ITEM_PV     @"tao_category"
#define TD_EVENT_INDEX_SUB_SORT_ITEM_PV         @"tao_sort"

#define TD_EVENT_INDEX_MAIN_NEXT_PAGE_PV        @"tao_page_pv"
#define TD_EVENT_INDEX_DETAIL_CPS               @"tao_mc"

//#define TD_EVENT_INDEX_DATA_ERROR_PV            @"数据错误"
//#define TD_EVENT_JIFEN_ADD_PV                   @"添加积分"
//#define TD_EVENT_JIFEN_SEARCH_PV                @"查询积分"
//#define TD_EVENT_404_PV                         @"tao_404_pv"


#pragma mark - DataTracker

@interface DataTracker : NSObject

+ (DataTracker *) sharedInstance ;

/**
 * @brief 
 * 
 * @note
 */
- (void) startDataTracker ;

/**
 * @brief
 *
 * @note
 */
- (void) stopDataTracker ;


/**
 * @brief 开始跟踪用户访问页面
 *
 * @note
 */
- (void) beginTrackPage:(NSString *)page ;

/**
 * @brief 结束跟踪用户访问页面
 *
 * @note
 */
- (void) endTrackPage:(NSString *)page ;

/**
 * @brief 自定义事件跟踪统计
 *
 * @note
 */
- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category
              value:(NSInteger)value ;

- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label
           category:(NSString *)category ;

- (void) trackEvent:(NSString *)eventId
          withLabel:(NSString *)label;

- (void) trackEvent:(NSString *)eventId;


- (void) submitTrack ;

@end
