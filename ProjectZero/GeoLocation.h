//
//  GeoLocation.h
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol GeoLocationDelegate <NSObject>

- (void)locationServicesState:(BOOL)state;

@end

@interface GeoLocation : NSObject <CLLocationManagerDelegate> {
    
    CLLocationManager *locationManager;
    __weak id delegate;
}

- (void)updateCurrentLocationManager;

@property (nonatomic, weak) id <GeoLocationDelegate> delegate;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property BOOL didUpdate;

@end