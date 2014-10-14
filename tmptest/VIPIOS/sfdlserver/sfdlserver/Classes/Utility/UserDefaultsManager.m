//
//  UserDefaultsManager.m
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
//

#import "UserDefaultsManager.h"
#import "OpenUDID.h"
#import "NSDate+extend.h"

@implementation UserDefaultsManager

//gender = 0:未填,1:男,2:女
+ (void)saveUserGender:(NSString *)gender {
    
    [[NSUserDefaults standardUserDefaults] setObject:gender
                                              forKey:UDK_UserGender];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)userGender {
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserGender];
    if (!gender) {
        return kEmptyString;
    }
    return gender;
}

+ (NSString *)userId
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserID];
    if (!userId) {
        return kEmptyString;
    }
    return userId;
}

+ (void)saveUserId:(NSString *)userId
{
    [[NSUserDefaults standardUserDefaults] setObject:userId
                                              forKey:UDK_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)token
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_Token];
    if (!token) {
        return kEmptyString;
    }
    return token;
}

+ (void)savetoken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token
                                              forKey:UDK_Token];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) userIcon
{
    NSString *userIcon = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserIcon];
    if (!userIcon) {
        return kEmptyString;
    }
    return userIcon;

}

+ (void)saveUserIcon:(NSString *)userIcon
{
//    if (!userIcon || userIcon.length == 0) {
//        return;
//    }
    [[NSUserDefaults standardUserDefaults] setObject:userIcon
                                              forKey:UDK_UserIcon];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)saveUserBirthDay:(long)birthDay
{
    NSNumber *number = [NSNumber numberWithLong:birthDay];
    [[NSUserDefaults standardUserDefaults] setObject:number
                                              forKey:UDK_UserBirthDay];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *) userCoverIcon
{
    NSString *userCoverIcon = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserCoverIcon];
    if (!userCoverIcon) {
        return kEmptyString;
    }
    return userCoverIcon;
}

+ (void)saveUserCoverIcon:(NSString *)userCoverIcon
{
    if (!userCoverIcon || userCoverIcon.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userCoverIcon
                                              forKey:UDK_UserCoverIcon];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearUserId
{
    [[NSUserDefaults standardUserDefaults] setObject:@""
                                              forKey:UDK_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) userType
{
    NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserType];
    if (!userType) {
        return @"b";
    }
    return userType;
}

+ (void)saveUserType:(NSString *)userType
{
    if (!userType || userType.length == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userType
                                              forKey:UDK_UserType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) userName
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserName];
    if (!userName) {
        return kEmptyString;
    }
    return userName;
}

+ (void)saveUserName:(NSString *)userName
{
    if (!userName) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userName
                                              forKey:UDK_UserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)userEmail
{
    NSString *userEmail = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserEmail];
    if (!userEmail) {
        return kEmptyString;
    }
    return userEmail;
}

+ (void)saveUserEmail:(NSString *)userEmail
{
    if (!userEmail) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:userEmail
                                              forKey:UDK_UserEmail];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL) isFirstUse
{
    NSNumber *gender = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_UserGender];
    return !gender ? YES : NO;
}

+ (void) saveDeviceID:(NSString *)did
{
    [[NSUserDefaults standardUserDefaults] setObject:did
                                              forKey:UDK_DeviceID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) deviceID
{
    NSString *did = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_DeviceID];
    if (!did) {
        DEBUGLOG(@"did = %@", [OpenUDID value]);
        did = [OpenUDID value];
        [self saveDeviceID:did];
        return did;
    }
    return did;
}


+ (NSString*)shortDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return currentDateStr;
}


+ (void) SavePushID:(NSString *)pushID
{
    [[NSUserDefaults standardUserDefaults] setObject:pushID
                                              forKey:UDK_PushID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) pushID
{
    NSString *pushID = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_PushID];
    if (!pushID) {
        return kEmptyString;
    }
    return pushID;
}

+ (NSInteger) pushIDChanged {
    NSNumber *netFlag = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_PushID_Change];
    if (!netFlag) {
        return 1;
    } else {
        return [netFlag intValue];
    }
}

+ (void)saveNetTrafficMode:(NSInteger)flag {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:flag]
                                              forKey:UDK_Net_SaveTraffic];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void) storeNetWorkChangedTipStatus:(NSUInteger)status
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedInteger:status]
                                              forKey:UDK_Network_Tip];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger) netWorkChangedTipStatus
{
    NSNumber *netFlag = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_Network_Tip];
    if (!netFlag) {
        return 1;
    } else {
        return [netFlag unsignedIntValue];
    }
}


+ (void) saveLang:(NSString *)lang
{
    [[NSUserDefaults standardUserDefaults] setObject:lang
                                              forKey:@"LANG"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) currentLang
{
    NSString *lang = [[NSUserDefaults standardUserDefaults] objectForKey:@"LANG"];
    if (!lang || [lang length] == 0) {
        return kCompanyLan;
    }
    return lang;
}

+ (void) saveCompanyId:(NSString *)lang
{
    [[NSUserDefaults standardUserDefaults] setObject:lang
                                              forKey:@"COMPANY_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+ (NSString *) currentCompanyId
{
    NSString *lang = [[NSUserDefaults standardUserDefaults] objectForKey:@"COMPANY_ID"];
    if (!lang || [lang length] == 0) {
        return kCompanyId;
    }
    return lang;
}

+ (void) saveKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:key
                                              forKey:@"USER_KEY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *) currentKey
{
    NSString *key = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_KEY"];
    if (!key || [key length] == 0) {
        return @"";
    }
    return key;
}


@end
