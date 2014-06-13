//
//  YoukuResponseItem.m
//  b5mei
//
//  Created by allen.wang on 4/25/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "YoukuResponseItem.h"

@implementation YoukuResponseItem

- (void) dealloc
{
    TT_RELEASE_SAFELY(_url);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        self.size       = [[dictionary objectForKey:@"size"] integerValue];
        self.seconds    = [[dictionary objectForKey:@"seconds"] integerValue];
        self.url        = [dictionary objectForKey:@"url"];
    }
    return self;
}


@end
