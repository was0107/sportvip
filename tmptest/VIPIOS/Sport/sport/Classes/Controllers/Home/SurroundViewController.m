//
//  SurroundViewController.m
//  Discount
//
//  Created by allen.wang on 7/1/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "SurroundViewController.h"
#import "YardViewController.h"
#import "MapLocation.h"
#import "PaggingRequest.h"
#import "PaggingResponse.h"

@interface SurroundViewController ()
@property (nonatomic,retain) MKMapView* mapView;
@property (nonatomic,retain) MapLocation *currentAnnotation;
@property (nonatomic, retain) GymnasiumsRequest *request;
@property (nonatomic, retain) GymnasiumsResponse *response;

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
    if (!self.request) {
        self.request = [[[GymnasiumsRequest alloc] init] autorelease];
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

- (IBAction)showCurrentAction:(id)sender
{
    if (_mapView.userLocation) {
        [_mapView setCenterCoordinate:_mapView.userLocation.location.coordinate animated:YES];
//        _mapView.showsUserLocation = NO;
        [self resetRegion];
        self.request.longitude = _mapView.userLocation.location.coordinate.longitude;
        self.request.latitude= _mapView.userLocation.location.coordinate.latitude;
        [self sendRequestToServer];
    }
    [SVProgressHUD dismiss];
}

- (id) resetRegion
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_mapView.userLocation.location.coordinate, 50000, 50000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    return self;
}

- (void) setResponse:(GymnasiumsResponse *)response
{
    if (_response != response) {
        [_response release];
        _response = [response retain];
    }
    
    [_mapView removeAnnotations:[_mapView annotations]];
    double minLat = 90,minLng = 180,maxLat = -90,maxLng = -180;
    
    for (int i = 0 ; i < _response.arrayCount ; i++)
    {
        
        GymnasiumItem *item = [_response.result objectAtIndex:i];
        MapLocation *location = [[[MapLocation alloc] init] autorelease];
        location.coordinate = CLLocationCoordinate2DMake(item.longtitude,item.lantitude);
        location.theTitle =item.name;
        location.theSubTitle = item.address;
        location.content = item;
        
//        
//        location.coordinate = CLLocationCoordinate2DMake([item.storeLatitude floatValue],[item.storeLongitude floatValue]);
//        location.theTitle = item.storeName;
//        location.theSubTitle = item.storeAddress;
//        location.content = item;
//        
        [self.mapView addAnnotation:location];
        if (location.coordinate.latitude > maxLat) {
            maxLat = location.coordinate.latitude;
        }
        if (location.coordinate.longitude>maxLng) {
            maxLng = location.coordinate.longitude;
        }
        if (location.coordinate.latitude<minLat) {
            minLat = location.coordinate.latitude;
        }
        if (location.coordinate.longitude<minLng) {
            minLng = location.coordinate.longitude;
        }
    }
    
    if (_response.arrayCount == 0) {
        return;
    }
    
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake((minLat+maxLat)/2, (minLng+maxLng)/2), MKCoordinateSpanMake((maxLat-minLat)+0.01, (maxLng-minLng)+0.01)) animated:YES];
    
}


-(void)sendRequestToServer
{
    __block SurroundViewController *blockSelf = self;
    [_request firstPage];
    idBlock succBlock = ^(id content){
        blockSelf.response = [[[GymnasiumsResponse alloc] initWithJsonString:content] autorelease];
    };
    
    idBlock failedBlock = ^(id content){
        if ([_request isFristPage]) {
            blockSelf.response = nil;
        }
    };
    [WASBaseServiceFace serviceWithMethod:[_request URLString] body:[_request toJsonString] onSuc:succBlock onFailed:failedBlock onError:failedBlock];
}



#pragma mark =
#pragma mark MKMapViewDelegate

#pragma mark CLLocationManagerDelegate Methods


- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    [SVProgressHUD showWithOnlyStatus:@"正在定位..." duration:30];
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
//    _mapView.showsUserLocation = NO;
//    [SVProgressHUD showErrorWithStatus:@""];

}

#pragma mark - mapView回调
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D cord = [mapView convertPoint:mapView.center toCoordinateFromView:mapView];
    self.request.latitude = cord.latitude;
    self.request.longitude = cord.longitude;
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
    MapLocation *location = (MapLocation *)view.annotation;
    [mapView deselectAnnotation:location animated:YES];
    if ([view.annotation isKindOfClass:[MapLocation class]]) {
        YardViewController * detailViewController = [[[YardViewController alloc]init]autorelease];
        detailViewController.item = location.content;
        [detailViewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


@end
