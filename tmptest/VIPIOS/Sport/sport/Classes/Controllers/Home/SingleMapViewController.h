//
//  SingleMapViewController.h
//  sport
//
//  Created by allen.wang on 7/4/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "BaseTitleViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface SingleMapViewController : BaseTitleViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, assign) CLLocationCoordinate2D center;
@property (nonatomic, copy)   NSString               *gymnasiumName,*address;

- (void) showPosition;

@end
