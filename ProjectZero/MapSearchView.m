//
//  MapSearchView.m
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "MapSearchView.h"
#import "MapViewController.h"

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


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
 
    
    self.radius = [self.distanceList objectAtIndex:row];
    
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
    self.navigationItem.title = @"Locate Pharmacy";

    
    distanceList = [[NSMutableArray alloc] init];
    
    [distanceList addObject:@"1 km"];
    [distanceList addObject:@"2 km"];
    [distanceList addObject:@"5 km"];
    [distanceList addObject:@"10 km"];
    [distanceList addObject:@"20 km"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"toMapSegue"]){
        
        MapViewController *destViewController = (MapViewController*)segue.destinationViewController;

        destViewController.radiusStr = self.radius;
        
//        if ([self.radius isEqualToString:@"1 km"]){
//         
//            NSLog(@"Distance Egual to 1 km");
//            destViewController.radius = 1;
//            
//        }else if ([self.radius isEqualToString:@"2 km"]){
//            
//            destViewController.radius = 2;
//            
//        }else if ([self.radius isEqualToString:@"5 km"]){
//            
//            destViewController.radius = 5;
//        }
//        else if ([self.radius isEqualToString:@"10 km"])
//        {
//                
//            destViewController.radius = 10;
//            
//                
//        }else if ([self.radius isEqualToString:@"20 km"])
//        {
//            
//            destViewController.radius = 20;
//            
//        }
        
    }
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
