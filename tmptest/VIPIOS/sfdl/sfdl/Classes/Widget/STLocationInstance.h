//
//  STLocationInstance.h
//  Discount
//
//  Created by Apple on 13-6-20.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface STLocationInstance : NSObject<CLLocationManagerDelegate>

@property (nonatomic,retain) CLLocationManager *locationManager;

@property(nonatomic,retain)CLLocation *checkinLocation;

@property(nonatomic,copy)  NSString *city;

@property(nonatomic,copy)  idBlock cityBlock;
@property(nonatomic,copy)  idBlock placeBlock;



+(STLocationInstance *)sharedInstance;

-(void)setupLocationManger;


@end
