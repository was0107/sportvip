//
//  ListPaggingRequestBase.m
//  b5mappsejieios
//
//  Created by micker on 12/27/12.
//  Copyright (c) 2012 micker. All rights reserved.
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
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:@"page",@"rows", nil];
    [array addObjectsFromArray: [super keyArrays]];
    return array;
}

- (NSMutableArray *) valueArrays
{
    NSMutableArray *array =  [NSMutableArray arrayWithObjects:kIntToString(self.pageno),kIntToString(self.pagesize), nil];
    [array addObjectsFromArray: [super valueArrays]];
    return array;

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