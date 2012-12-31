//
//  NewPatientProfileViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "NewPatientProfileViewController.h"

@interface NewPatientProfileViewController ()

@end

@implementation NewPatientProfileViewController


@synthesize firstName;
@synthesize lastName;
@synthesize year;
@synthesize month;
@synthesize day;
@synthesize address;
@synthesize healthCardNum;


- (void)viewDidLoad
{
    
    
    
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
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
