//
//  PatientProfileViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/2/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "PatientProfileViewController.h"

@interface PatientProfileViewController ()

@end

@implementation PatientProfileViewController

@synthesize firstNameField;
@synthesize lastNameField;
@synthesize birthdayField;
@synthesize healthCardField;


@synthesize firstName;
@synthesize lastName;
@synthesize birthday;
@synthesize healthCard;


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
    
    self.firstNameField.text = self.firstName;
    self.lastNameField.text =  self.lastName;
    self.birthdayField.text = self.birthday;
    self.healthCardField.text = self.healthCard;
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
