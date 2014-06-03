//
//  STLocationInstance.m
//  Discount
//
//  Created by Apple on 13-6-20.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "STLocationInstance.h"
#import "NSString+extend.h"

static STLocationInstance * sharedInstance = nil;

@implementation STLocationInstance

@synthesize locationManager;
@synthesize checkinLocation;
@synthesize city;
@synthesize cityBlock;
@synthesize placeBlock;

+(STLocationInstance *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(id)init
{
    if ((self = [super init]))
    {
        [self setupLocationManger];
    }
    return self;
}

-(id)retain
{
    return self;
}

-(unsigned)retainCount
{
    return UINT_MAX;
}

-(oneway void)release
{
}

-(id)autorelease
{
    return self;
}

#pragma mark - CoreLocation

-(void)setupLocationManger
{
    if (!self.locationManager) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    }
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 200;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        [self error];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您未开启定位服务!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}

- (void) error
{
    if (self.cityBlock) {
        self.cityBlock(nil);
    } else if (self.placeBlock) {
        self.placeBlock(nil);
    }
    self.cityBlock = nil;
    self.placeBlock = nil;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if ([[[UIDevice currentDevice] systemVersion] hasPrefix:@"4"]
        ||[[[UIDevice currentDevice] systemVersion] hasPrefix:@"5"])
    {
        self.checkinLocation = newLocation;
        [self updateLocation:self.checkinLocation];
    }
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations
{
    if (![[[UIDevice currentDevice] systemVersion] hasPrefix:@"4"] && ![[[UIDevice currentDevice] systemVersion] hasPrefix:@"5"]) {
        if ([locations count] > 0) {
            self.checkinLocation = [locations lastObject];
           [self updateLocation:self.checkinLocation];
        }
    }
}

-(void)updateLocation:(CLLocation *)newLocation
{
    [self startedReverseGeoder];
}

- (void)startedReverseGeoder
{
    __block STLocationInstance *blockSelf = self;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.checkinLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if ([placemarks count] >0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            if (placemark) {
                NSString *theCity = placemark.locality;
                if (!theCity) {
                    theCity = placemark.administrativeArea;
                }
                blockSelf.city = theCity;
                if (blockSelf.cityBlock) {
                    blockSelf.cityBlock([blockSelf.city cityName]);
                    blockSelf.cityBlock = nil;
                } else if (blockSelf.placeBlock) {
                    blockSelf.placeBlock(placemark);
                    blockSelf.placeBlock = nil;
                }
            }
            [blockSelf.locationManager stopUpdatingLocation];
        }
        [blockSelf error];
    }];
    
    [geocoder release];
}


@end
