//
//  MapLocation.h
//  Discount
//
//  Created by allen.wang on 7/1/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapLocation : NSObject <MKAnnotation, NSCoding> {
    NSString *streetAddress;
    NSString *city;
    NSString *state;
    NSString *zip;
    
    CLLocationCoordinate2D coordinate;
}
@property (nonatomic, copy) NSString *streetAddress;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *zip;

@property (nonatomic, copy) NSString *theTitle;
@property (nonatomic, copy) NSString *theSubTitle;

@property (nonatomic, assign) id content;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@end