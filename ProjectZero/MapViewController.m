//
//  MapViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView, currentLocation, locationManager, radius;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview: mapView];
    
    [self displayMap];
    //[NSThread detachNewThreadSelector:@selector(displayMap) toTarget:self withObject:nil];
    
}






//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
//
//    self.currentLocation = newLocation;
//    [locationManager stopUpdatingLocation];
////    if(newLocation.horizontalAccuracy <= 100.0f)
////    {
////        [locationManager stopUpdatingLocation];
//        NSLog(@" lon: %f, lat:%f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
////    }
//    [self displayMap];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//
//    if(error.code == kCLErrorDenied) {
//        [locationManager stopUpdatingLocation];
//    } else if(error.code == kCLErrorLocationUnknown) {
//        // retry
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
//                                                        message:[error description]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//}

-(void)displayMap
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    
    CLLocation * temp;
    while ((temp = locationManager.location) == nil) {
        //should not get stuck here on phone
    }
    self.currentLocation = locationManager.location;
    
    NSLog(@" long: %f, lat:%f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
    
    region.span=span;
    region.center=currentLocation.coordinate;
    
    MyAnnotation * annotation = [[MyAnnotation alloc] initWithCoordinate:currentLocation.coordinate];
    
    [mapView addAnnotation:annotation];
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    
    [self addPharmacies];
}

-(void) addPharmacies
{
    // Key for google api: AIzaSyAOf09QMaGZ41ZWcUudxTrftmh-q92uMeU
    
    // Replace this with selected radius in meters
    
    if ([self.radiusStr isEqualToString:@"1 km"]){
        
        NSLog(@"Distance Egual to 1 km");
        self.radius= 1000;
        
    }else if ([self.radiusStr isEqualToString:@"2 km"]){
        
        self.radius= 2000;
        
    }else if ([self.radiusStr isEqualToString:@"5 km"]){
        
        self.radius = 5000;
    }
    else if ([self.radiusStr isEqualToString:@"10 km"])
    {
        
        self.radius = 10000;
        
        
    }else if ([self.radiusStr isEqualToString:@"20 km"])
    {
        
        self.radius= 20000;
        
    } else {
        
        self.radius = 1000;
    }
    
    
    NSLog(@"Indicate Radius: %d", self.radius);
    
    
    
    
    
    NSString * searchURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%lf,%lf&radius=%d&keyword=pharmacy&sensor=true&key=AIzaSyAOf09QMaGZ41ZWcUudxTrftmh-q92uMeU", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, radius];
    
    searchURL =  [searchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* url = [[NSURL alloc] initWithString:searchURL];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    
    NSError * error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    NSArray* results = [dict objectForKey:@"results"];
    
    for (NSDictionary* dic in results) {
        
        CLLocationCoordinate2D storeLocation;
        
        storeLocation.latitude = [[[[dic objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        storeLocation.longitude = [[[[dic objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        
        MyAnnotation * ann = [[MyAnnotation alloc] initWithCoordinate:storeLocation];
        ann.title = [dic objectForKey:@"name"];
        ann.subtitle = [dic objectForKey:@"vicinity"];
        [mapView addAnnotation:ann];
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end