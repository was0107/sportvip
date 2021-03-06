//
//  UserDefaultsManager.h
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultsKeys.h"

@interface UserDefaultsManager : NSObject

+ (void)saveUserGender:(NSString *)gender;
+ (NSString *)userGender;
+(BOOL) isFirstUse;

/**
 * @brief  获取用户信息
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (NSString *) userId;
+ (void)saveUserId:(NSString *)userId;

+ (NSString *)token;
+ (void)savetoken:(NSString *)token;

+ (NSString *) userName;
+ (void)saveUserName:(NSString *)userName;
+ (void)clearUserId;

+(NSString *)userEmail;
+ (void)saveUserEmail:(NSString *)userEmail;

+ (NSString *) userIcon;
+ (void)saveUserIcon:(NSString *)userIcon;


+ (void)saveUserBirthDay:(long)birthDay;


/**
 * @brief  获取保存在本地的设备id
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSString
 * @note
 */
+ (NSString *) deviceID;

+ (void) saveDeviceID:(NSString *)did;

/**
 * @brief  获取用户收入
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (NSString*)shortDateString;

//push token
+ (void) SavePushID:(NSString *)pushID;
+ (NSString *) pushID;

+ (NSInteger) pushIDChanged;
+ (NSString *) theLastChangedCity;


/**
 * @brief  2G/3G省流量模式 -- default 0 关闭
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */

+ (void)saveNetTrafficMode:(NSInteger)flag;


/**
 * @brief  设置与获取。切换到3G模式下，是否需要提醒 -- default 1 提醒
 *
 * @param [in]　N/A
 * @param [out]　N/A
 * @return　NSInteger
 * @note
 */
+ (void) storeNetWorkChangedTipStatus:(NSUInteger)status;
+ (NSUInteger) netWorkChangedTipStatus;

+ (void) saveLang:(NSString *)lang;
+ (NSString *) currentLang;


+ (void) saveCompanyId:(NSString *)lang;
+ (NSString *) currentCompanyId;

+ (void) saveKey:(NSString *)key;
+ (NSString *) currentKey;

@end
