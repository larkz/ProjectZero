//
//  MapSearchView.m
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "MapSearchView.h"

@interface MapSearchView ()


@end

@implementation MapSearchView

@synthesize postalCodeTextField;
@synthesize distanceRadiusPicker;
@synthesize distanceList;


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)distanceRadiusPicker {

    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)distanceRadiusPicker numberOfRowsInComponent:(NSInteger)component {
    
    return distanceList.count;
}




- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [distanceList objectAtIndex:row];
}


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

    
    distanceList = [[NSMutableArray alloc] init];
    
    [distanceList addObject:@"5 km"];
    [distanceList addObject:@"10 km"];
    [distanceList addObject:@"20 km"];
    [distanceList addObject:@"50 km"];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"distanceList: %@", distanceList);

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
