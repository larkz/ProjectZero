//
//  MyAnnotation.m
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
    return self;
}

@end
