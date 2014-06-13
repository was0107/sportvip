//
//  YoukuResponse.m
//  b5mei
//
//  Created by allen.wang on 4/25/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "YoukuResponse.h"

@implementation YoukuResponse

- (void) dealloc
{
    TT_RELEASE_SAFELY(_img);
    TT_RELEASE_SAFELY(_img_hd);
    TT_RELEASE_SAFELY(_format);
    TT_RELEASE_SAFELY(_desc);
    TT_RELEASE_SAFELY(_result);
    TT_RELEASE_SAFELY(_title);
    TT_RELEASE_SAFELY(_videoid);
    [super dealloc];
}

- (NSString *) URLString
{
    return [NSString stringWithFormat:kYoukuVideoFormat, [self videoid], [self format]];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        NSDictionary *rootDictionary = [dictionary objectForKey:@"results"];
        
        self.img = [rootDictionary objectForKey:@"img"];
        self.img_hd = [rootDictionary objectForKey:@"img_hd"];
        self.desc = [rootDictionary objectForKey:@"desc"];
        self.title = [rootDictionary objectForKey:@"title"];
        self.videoid = [rootDictionary objectForKey:@"videoid"];
        
        self.result = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        
        
        NSArray *array = [rootDictionary objectForKey:@"format"];
        
        NSMutableString *formatString = [NSMutableString string];
        
        for (int i = 0 ; i < [array count] ; i++) {
            NSUInteger index = [[array objectAtIndex:i] integerValue];
            [formatString appendString:[NSString stringWithFormat:@"%d,",index]];
        }
        
        if ([formatString length] > 0) {
            self.format = [formatString substringToIndex:([formatString length] -1)];
        } else {
            self.format = @"";
        }
    }
    return self;
}

- (id) initWithJsonStringEx:(NSString *)jsonString
{
    SBJSON *json = [[[SBJSON alloc]init] autorelease];
    NSDictionary *dictionary = [json fragmentWithString:jsonString error:nil];
    NSDictionary *rootDictionary = [dictionary objectForKey:@"results"];
    NSArray *videoArray = [rootDictionary allValues];
    for (int i = 0 , total = [videoArray count]; i < total; i++) {
        
        NSArray *array = [videoArray objectAtIndex:i];
        
        for (int j = 0 , totalj = [array count]; j < totalj; j++) {
            NSDictionary *itemDictionary = [array objectAtIndex:j];
            [self.result addObject:[[[YoukuResponseItem alloc] initWithDictionary:itemDictionary] autorelease]];
        }
    }
    
    self.result = (NSMutableArray *)[self.result sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        YoukuResponseItem *item1 = (YoukuResponseItem *) obj1;
        YoukuResponseItem *item2 = (YoukuResponseItem *) obj2;
        
        if ([item1 size] > [item2 size]) {
            return NSOrderedDescending;
        }
        if ([item1 size] < [item2 size]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
        
    }];
    
    return self;
}


@end
