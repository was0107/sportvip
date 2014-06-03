//
//  SurroundViewController.m
//  Discount
//
//  Created by allen.wang on 7/1/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "SurroundViewController.h"
#import "MapLocation.h"


@interface SurroundViewController ()
@property (nonatomic,retain) MKMapView* mapView;
@property (nonatomic,retain) MapLocation *currentAnnotation;

@end

@implementation SurroundViewController
@synthesize mapView           = _mapView;
@synthesize currentAnnotation = _currentAnnotation;
@synthesize comeFrom          = _comeFrom;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    [self showLeft];
    
    if (self.comeFrom == 0) {
        [self setTitleContent:@"地图查找"];
        UIImageView *imageview = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_mapCenter"]] autorelease ];
        imageview.center = self.mapView.center;
        imageview.tag = 1000;
        [self.view addSubview:imageview];
    }
}

- (void) reduceMemory
{
    TT_RELEASE_SAFELY(_mapView);
    TT_RELEASE_SAFELY(_currentAnnotation);
    [super reduceMemory];
}


- (MKMapView *) mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:kContentFrame];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}


-(void)sendRequestToServer
{
   
}


- (IBAction)showCurrentAction:(id)sender
{
    if (_mapView.userLocation) {
       
        [_mapView setCenterCoordinate:_mapView.userLocation.location.coordinate animated:YES];
        _mapView.showsUserLocation = NO;
        [self resetRegion];
    }
}

- (id) resetRegion
{
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.location.coordinate, _request.distance, _request.distance);
//    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
//    [_mapView setRegion:adjustedRegion animated:YES];
    return self;
}


#pragma mark =
#pragma mark MKMapViewDelegate

#pragma mark CLLocationManagerDelegate Methods


- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{

}

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    [self showCurrentAction:nil];

}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self showCurrentAction:nil];

}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    _mapView.showsUserLocation = NO;

}

#pragma mark - mapView回调
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
//    CLLocationCoordinate2D cord = [mapView convertPoint:mapView.center toCoordinateFromView:mapView];
//    self.request.latitude = cord.latitude;
//    self.request.longitude = cord.longitude;
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
        UIButton *rightCalloutBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = rightCalloutBtn;
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
//    MapLocation *location = (MapLocation *)view.annotation;
//    [mapView deselectAnnotation:location animated:YES];
//    if (self.item) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    FoodDetailViewController * detailViewController = [[[FoodDetailViewController alloc]init]autorelease];
//    detailViewController.storeItem = location.content;
//    [detailViewController setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
