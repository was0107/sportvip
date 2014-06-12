//
//  ListRequestBase.m
//  b5mappsejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListRequestBase.h"
#import "UIDevice+extend.h"
#import "UserDefaultsManager.h"

@implementation ListRequestBase

- (BOOL) checkArray:(NSMutableArray *) array
{
    if (array && [array count] > 0) {
        return YES;
    }
    return NO;
}

- (BOOL) checkString:(NSString *) string
{
    if (string && [string length] > 0) {
        return YES;
    }
    return NO;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_comapnyId);
    TT_RELEASE_SAFELY(_lang);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray array];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray array];
}

- (NSString *) toJsonString
{
    self.comapnyId = @"1";
    self.lang = @"zh";
    NSMutableArray *keys = [[[NSMutableArray alloc] initWithArray:[self commonKeysArray]] autorelease];
    NSMutableArray *keysContent = [self keyArrays];
    if (keysContent)
        [keys addObjectsFromArray:keysContent];
    
    NSMutableArray *values = [[[NSMutableArray alloc] initWithArray:[self commonParamsArray]] autorelease];
    NSMutableArray *valueContent = [self valueArrays];
    if (valueContent)
        [values addObjectsFromArray:valueContent];
    
    return [B5MUtility generateJsonWithKeys:keys withValues:values];
}

// Common参数
- (NSArray *) commonKeysArray
{
    return [NSArray arrayWithObjects:@"companyId", @"lang",nil];
//    if ([UserDefaultsManager userGender] < 0) {
//        return [NSArray arrayWithObjects:kDeviceIMEI, kDeviceMOB, kDeviceOS, kDeviceDEV, kDeviceVER,
//                kDeviceCHNL, kDeviceTIME, kDid,nil];//,
//    }
//    return [NSArray arrayWithObjects:kDeviceIMEI, kDeviceMOB, kDeviceOS, kDeviceDEV, kDeviceVER,
//            kDeviceCHNL, kDeviceTIME, kDid,kGender, nil];
}

- (NSArray *) commonParamsArray
{
    return [NSArray arrayWithObjects:self.comapnyId, self.lang , nil];
//
//    UIDevice *device = [UIDevice currentDevice];
//    NSString *time   = device.t;
//    NSString *chnl   = [[NSUserDefaults standardUserDefaults] objectForKey:UDK_CHANNEL_ID];
//    if (!chnl) {
//        chnl = @"";
//    }
//    NSArray *values = nil;
//    if ([UserDefaultsManager userGender] < 0) {
//        values = [NSArray arrayWithObjects:device.imei, device.mob, device.os, device.dev, device.ver,
//                  chnl, time, [UserDefaultsManager deviceID],nil];
//    } else {
//        values = [NSArray arrayWithObjects:device.imei, device.mob, device.os, device.dev, device.ver,
//                  chnl, time, [UserDefaultsManager deviceID],kIntToString([UserDefaultsManager userGender]), nil];
//    }
//    return values;
}

- (NSString *) methodString
{
    return nil;
}

- (NSString *) hostString
{
    return kHostDomain;
}

- (NSString *) URLString
{
    return [NSString stringWithFormat:@"%@%@", [self hostString], [self methodString]];
}
//
//- (NSString *) toJsonString
//{
//    return nil;
//}
//
//- (NSString *) URLString
//{
//    NSString *url = [NSString stringWithFormat:@"%@%@?%@", [self hostString], [self methodString], [self getURLParamsString]];
//    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}
//
//- (NSString *) getURLParamsString
//{
//    NSMutableString *stringCode = [[[NSMutableString alloc] initWithCapacity:12] autorelease];
//    NSMutableArray *keys = [self keyArrays];
//    NSMutableArray *values = [self valueArrays];
//    for (int i = 0 , total = [[self keyArrays] count]; i < total; i++) {
//        [stringCode appendFormat:@"%@=%@&",[keys objectAtIndex:i] , [values objectAtIndex:i]];
//    }
//    [stringCode appendFormat:@"%@=%@",@"1",@"1"];
//    return stringCode;
//}

@end


@implementation ListRequestWithUserIDBase
- (id) init {
    self = [super init];
    if (self) {
        self.userID = [UserDefaultsManager userId];
        self.token = [UserDefaultsManager token];
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_userID);
    TT_RELEASE_SAFELY(_token);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"userId",@"token",nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:self.userID,[UserDefaultsManager token], nil];
}

@end
