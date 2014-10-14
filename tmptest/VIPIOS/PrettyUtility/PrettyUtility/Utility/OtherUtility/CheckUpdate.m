//
//  CheckUpdate.m
//  PrettyUtility
//
//  Created by micker on 5/16/14.
//  Copyright (c) 2014 B5M. All rights reserved.
//

#import "CheckUpdate.h"


#define kAPPName                [infoDict objectForKey:@"CFBundleDisplayName"]
#define kAPPURL                 @"http://itunes.apple.com/lookup?id="
#define kAPPCommentURLOld       @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@"
#define kAPPCommentURL7         @"itms-apps://itunes.apple.com/app/id%@"


@interface CheckUpdate ()
{
    NSString *_updateURL;
    NSString *_appID;
}

@end


@implementation CheckUpdate

+ (CheckUpdate *)shareInstance
{
    static CheckUpdate *update = nil;
    if (!update)
    {
        update = [[CheckUpdate alloc] init];
    }
    
    return update;
}

- (id) appID:(NSString *) appID
{
    _appID = appID;
    return self;
}

- (id)checkUpdate
{
    if (!_appID) {
        return self;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kAPPURL, _appID];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url ];
    [request setDidFinishSelector:@selector(checkUpdateFinished:)];
    [request setDidFailSelector:@selector(checkUpdateFailed:)];
    [request setDelegate:self];
    [request startAsynchronous];
    return self;
}


- (id) goToAppStore
{
    if (!_appID) {
        return self;
    }
    NSString *str = nil;
    if (IS_IOS_7_OR_GREATER) {
        str = [NSString stringWithFormat: kAPPCommentURLOld,_appID];
    } else {
        str = [NSString stringWithFormat: kAPPCommentURL7,_appID];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    return self;
}

- (void)checkUpdateFinished:(ASIHTTPRequest *)request
{
    if (request.responseStatusCode == 200)
    {
        NSDictionary *infoDict   = [[NSBundle mainBundle]infoDictionary];
        NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
        NSDictionary *jsonData   = request.responseString.JSONValue;
        NSArray      *infoArray  = [jsonData objectForKey:@"results"];
        
        if (infoArray.count >= 1)
        {
            NSDictionary *releaseInfo   = [infoArray objectAtIndex:0];
            NSString     *latestVersion = [releaseInfo objectForKey:@"version"];
            NSString     *releaseNotes  = [releaseInfo objectForKey:@"releaseNotes"];
            NSString     *title         = [NSString stringWithFormat:@"%@%@版本", kAPPName, latestVersion];
            _updateURL = [releaseInfo objectForKey:@"trackViewUrl"];
            
            if ([latestVersion compare:currentVersion] == NSOrderedDescending)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:releaseNotes delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去App Store下载", nil];
                [alertView show];
                [alertView release];
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(currentVersionHasNewest)])
                {
                    [self.delegate currentVersionHasNewest];
                }
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(currentVersionHasNewest)])
            {
                [self.delegate currentVersionHasNewest];
            }
        }
    }
    else
        if ([self.delegate respondsToSelector:@selector(currentVersionHasNewest)])
        {
            [self.delegate currentVersionHasNewest];
        }
}

- (void)checkUpdateFailed:(ASIHTTPRequest *)request
{
    //    NSLog(@"data:%@", request.responseString.JSONValue);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateURL]];
    }
}

@end