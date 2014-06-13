//
//  YoukuRequest.m
//  b5mei
//
//  Created by allen.wang on 4/25/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "YoukuRequest.h"

@implementation YoukuRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_originURL);
    TT_RELEASE_SAFELY(_videoID);
    [super dealloc];
}

- (void) setOriginURL:(NSString *)originURL
{
    if (_originURL != originURL) {
        [_originURL release];
        _originURL = [originURL copy];
        
        NSRange range1 = [_originURL rangeOfString:@"id_"];
        NSRange range2 = [_originURL rangeOfString:@".html" options:NSBackwardsSearch];
        
        if (range1.length != 0) {
            
            NSString *result = [_originURL substringWithRange:NSMakeRange(range1.location + 3, range2.location - range1.location - 3)];
            NSRange range3 = [result rangeOfString:@"_"];

            if (0 != range3.length) {
                result = [result substringWithRange:NSMakeRange(0,range3.location)];
            }
            [self setVideoID:result];
        }
    }
}

- (NSString *) URLString
{
    return [NSString stringWithFormat:kYoukuHostFoamat, [self videoID]];
}

@end
