//
//  SurroundViewController.h
//  Discount
//
//  Created by allen.wang on 7/1/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "BaseTitleViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface SurroundViewController : BaseTitleViewController<MKMapViewDelegate,CLLocationManagerDelegate>


@property (nonatomic, assign) int comeFrom;
@end
