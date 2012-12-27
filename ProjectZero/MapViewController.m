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

@synthesize mapView;

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
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview: mapView];
    [NSThread detachNewThreadSelector:@selector(displayMap) toTarget:self withObject:nil];
    
}

-(void)displayMap
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    
    CLLocationCoordinate2D location;
    
    location.latitude = 43.64842 ;
    location.longitude = -79.40235;
    
    region.span=span;
    region.center=location;
    
    MyAnnotation * annotation = [[MyAnnotation alloc] initWithCoordinate:location];
    
    [mapView addAnnotation:annotation];
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    
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