//
//  ListPaggingRequestBase.m
//  b5mappsejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@implementation ListPaggingRequestBase
@synthesize pageno      = _pageno;
@synthesize pagesize    = _pagesize;

- (id) init {
    self = [super init];
    if (self) {
        self.pageno     = 1;
        self.pagesize   = 24;
    }
    return self;
}

- (NSMutableArray *) keyArrays
{
    return [NSMutableArray arrayWithObjects:@"page",@"pageSize", nil];
}

- (NSMutableArray *) valueArrays
{
    return [NSMutableArray arrayWithObjects:kIntToString(self.pageno),kIntToString(self.pagesize), nil];
}

- (id) nextPage
{
    self.pageno += 1;
    return self;
}

- (id) firstPage
{
    self.pageno = 1;
    return self;
}

- (BOOL) isFristPage
{
    return self.pageno == 1;
}


@end


@implementation ListPaggingRequestWithUserIDBase

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
    NSMutableArray *array = [super keyArrays];
    [array addObject:@"userId"];
    [array addObject:@"token"];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array = [super valueArrays];
    [array addObject:self.userID];
    [array addObject:[UserDefaultsManager token]];
    return array;
}

@end