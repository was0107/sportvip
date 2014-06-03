//
//  MapLocation.m
//  Discount
//
//  Created by allen.wang on 7/1/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "MapLocation.h"

@implementation MapLocation
@synthesize theTitle,theSubTitle,streetAddress,city,state,zip,coordinate,content;

- (NSString *)title {
    if (self.theTitle) {
        return self.theTitle;
    }
    return @"您的位置!";
}
- (NSString *)subtitle {
    if (self.theSubTitle) {
        return self.theSubTitle;
    }
    NSMutableString *ret = [NSMutableString string];
    if (streetAddress)
        [ret appendString:streetAddress];
    if (streetAddress && (city || state || zip))
        [ret appendString:@" • "];
    if (city)
        [ret appendString:city];
    if (city && state)
        [ret appendString:@", "];
    if (state)
        [ret appendString:state];
    if (zip)
        [ret appendFormat:@", %@", zip];
    
    return ret;
}

#pragma mark -
- (void)dealloc {
    [theTitle release];
    [theSubTitle release];
    [streetAddress release];
    [city release];
    [state release];
    [zip release];
    [super dealloc];
}
#pragma mark -
#pragma mark NSCoding Methods
- (void) encodeWithCoder: (NSCoder *)encoder {
    [encoder encodeObject: [self theTitle] forKey: @"theTitle"];
    [encoder encodeObject: [self theSubTitle] forKey: @"theSubTitle"];
    [encoder encodeObject: [self streetAddress] forKey: @"streetAddress"];
    [encoder encodeObject: [self city] forKey: @"city"];
    [encoder encodeObject: [self state] forKey: @"state"];
    [encoder encodeObject: [self zip] forKey: @"zip"];
}
- (id) initWithCoder: (NSCoder *)decoder  {
    if (self = [super init]) {
        [self setTheTitle: [decoder decodeObjectForKey: @"theTitle"]];
        [self setTheSubTitle: [decoder decodeObjectForKey: @"theSubTitle"]];
        [self setStreetAddress: [decoder decodeObjectForKey: @"streetAddress"]];
        [self setCity: [decoder decodeObjectForKey: @"city"]];
        [self setState: [decoder decodeObjectForKey: @"state"]];
        [self setZip: [decoder decodeObjectForKey: @"zip"]];
    }
    return self;
}
@end
