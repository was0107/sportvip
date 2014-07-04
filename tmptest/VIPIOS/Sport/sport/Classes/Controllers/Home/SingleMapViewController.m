//
//  SingleMapViewController.m
//  sport
//
//  Created by allen.wang on 7/4/14.
//  Copyright (c) 2014 allen.wang. All rights reserved.
//

#import "SingleMapViewController.h"
#import "MapLocation.h"

@interface SingleMapViewController()

@property (nonatomic,retain) MKMapView* mapView;

@end

@implementation SingleMapViewController
@synthesize mapView           = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    [self showLeft];
    
    
    [self setTitleContent:@"地图"];
    self.trackViewId = @"地图页面";
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_mapView);
    TT_RELEASE_SAFELY(_gymnasiumName);
    TT_RELEASE_SAFELY(_address);
    [super reduceMemory];
}


- (void) showPosition
{
    [_mapView removeAnnotations:[_mapView annotations]];
    MapLocation *location = [[[MapLocation alloc] init] autorelease];
    location.coordinate = self.center;
    location.theTitle = self.gymnasiumName;
    location.theSubTitle = self.address;
    [self.mapView addAnnotation:location];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.center, 5000, 5000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    [self.mapView setExclusiveTouch:YES];
}

- (MKMapView *) mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:kContentFrame];
        _mapView.delegate = self;
        _mapView.showsUserLocation = NO;
    }
    return _mapView;
}



#pragma mark =
#pragma mark MKMapViewDelegate

#pragma mark CLLocationManagerDelegate Methods

#pragma mark - mapView回调
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if(annotationView == nil) {
        annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"] autorelease];
        annotationView.canShowCallout = YES;
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
        annotationView.highlighted = YES;
    }
    
    return annotationView;
}

@end
