//
//  FeedBackRequest.m
//  GoDate
//
//  Created by lei zhang on 13-8-8.
//  Copyright (c) 2013年 www.b5m.com. All rights reserved.
//

#import "FeedBackRequest.h"

@implementation FeedBackRequest
@synthesize type = _type;
@synthesize description = _description;

- (id) init {
    self = [super init];
    if (self) {
        self.type = @"操作";
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_type);
    TT_RELEASE_SAFELY(_description);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray * keys = [super keyArrays];
    if (keys) {
        [keys addObject:@"type"];
        [keys addObject:@"content"];
    }
    return keys;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray * values = [super valueArrays];
    if (values) {
        [values addObject:self.type];
        [values addObject:self.description];
    }
    return values;
}

-(NSString *)methodString
{
    return @"user/feedback";
}

@end
