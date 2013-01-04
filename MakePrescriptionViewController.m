//
//  MakePrescriptionViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/3/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "MakePrescriptionViewController.h"

@interface MakePrescriptionViewController ()

@end

@implementation MakePrescriptionViewController

@synthesize drugName;
@synthesize description;

@synthesize drugNameField;
@synthesize descriptionView;

@synthesize userID;


- (void)viewDidLoad
{
    
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)pressMakePresc:(id)sender;
{
    
    self.drugName = self.drugNameField.text;
    self.description = self.descriptionView.text;
    
    
    
    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
