//
//  CheckUpdate.h
//  PrettyUtility
//
//  Created by allen.wang on 5/16/14.
//  Copyright (c) 2014 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckUpdateDelegate <NSObject>

@optional

- (void)currentVersionHasNewest;

@end

@interface CheckUpdate : NSObject <UIAlertViewDelegate>
@property (assign, nonatomic) id <CheckUpdateDelegate>  delegate;

+ (CheckUpdate *)shareInstance;

- (id) appID:(NSString *) appID;

- (id) checkUpdate;

- (id) goToAppStore;

@end