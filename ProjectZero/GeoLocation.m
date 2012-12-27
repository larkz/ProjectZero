//
//  GeoLocation.m
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

//
//  GeoLocation.m
//
//  Created by Larkin on 7/10/12.
//  Copyright (c) 2012 MavenSay Inc. All rights reserved.
//

#import "GeoLocation.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation GeoLocation

@synthesize locationManager;
@synthesize delegate;
@synthesize didUpdate;

- (void)updateCurrentLocationManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // minimum distance (in meters) to travel to update location
    locationManager.distanceFilter = 100;
    // accuracy of the location
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    self.didUpdate = NO;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (self.didUpdate == NO) {
        self.didUpdate = YES;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks, NSError *error){
            if (error)
            {
                NSLog(@"Error occured in reverse Geocoding!");
            }
            CLPlacemark *currentPlacemark = [placemarks objectAtIndex:0];
            
            NSString *currentCity = currentPlacemark.locality;
            NSString *currentCountry = currentPlacemark.country;
            NSNumber *currentLocationLat = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
            NSNumber *currentLocationLon = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
            
            NSLog(@"Location Update:\nCity:%@\nCountry:%@\nLat:%f\nLon:%f", currentCity, currentCountry, [currentLocationLat doubleValue], [currentLocationLon doubleValue]);
            
            [defaults setObject:currentCity forKey:@"currentCity"];
            [defaults setObject:currentCountry forKey:@"currentCountry"];
            [defaults setObject:currentLocationLat forKey:@"currentLocationLatitude"];
            [defaults setObject:currentLocationLon forKey:@"currentLocationLongitude"];
            [defaults synchronize];
            
            [self.delegate locationServicesState:YES];
            
            [locationManager stopUpdatingLocation];
            locationManager = nil;
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([[error domain] isEqualToString: kCLErrorDomain] && [error code] == kCLErrorDenied) {
        // The user denied your app access to location information.
        NSLog(@"Location Services disabled.");
        [self.delegate locationServicesState:NO];
    } else {
        NSLog(@"Location Manager Error Message: %@", error);
    }
    [locationManager stopUpdatingLocation];
}

@end
