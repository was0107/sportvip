//
//  ModifyArchiveRequest.m
//  GoDate
//
//  Created by allen.wang on 8/14/13.
//  Copyright (c) 2013 www.b5m.com. All rights reserved.
//

#import "ModifyArchiveRequest.h"

@implementation ModifyArchiveRequest

- (void) dealloc
{
    TT_RELEASE_SAFELY(_keys);
    TT_RELEASE_SAFELY(_values);
    [super dealloc];
}

- (NSMutableArray *) keyArrays
{
    NSMutableArray * keys = [super keyArrays];
    if (keys) {
        [keys addObjectsFromArray:self.keys];
    }
    return keys;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray * values = [super valueArrays];
    if (values) {
        [values addObjectsFromArray:self.values];
    }
    return values;
}

-(NSString *)methodString
{
    return @"user/update-archive";
}
@end
