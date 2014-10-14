//
//  ProductResponse.m
//  sfdl
//
//  Created by micker on 6/13/14.
//  Copyright (c) 2014 micker. All rights reserved.
//

#import "ProductResponse.h"


/*
 *server
 */

@implementation EnquiryListResponse

- (id) translateItemFrom:(const NSDictionary *) dictionary
{
    return [[[EnquiryItem alloc] initWithDictionary:dictionary] autorelease];
}

- (NSString *) resultKey
{
    return @"enquiryList";
}

@end


@implementation ViewEnquiryResponse

- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.item = [[[EnquiryItem alloc] initWithDictionary:[dictionary objectForKey:@"enquiry"]] autorelease];
    return self;
}

@end

@implementation ReplyEnquiryResponse

@end


@implementation CheckVersionResponse

- (void) dealloc
{
    TT_RELEASE_SAFELY(_version);
    TT_RELEASE_SAFELY(_download_url);
    [super dealloc];
}


- (id) initWithDictionary:(const NSDictionary *) dictionary
{
    self = [super initWithDictionary:dictionary];
    self.version = [dictionary objectForKey:@"version"];
    self.download_url = [dictionary objectForKey:@"download_url"];
    return self;
}


- (BOOL) isNeedToTip
{
    NSString *versionTemp =  [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    if ([self.version length] > 0 && ![versionTemp isEqualToString:self.version]) {
        return YES;
    }
    return NO;
}

@end