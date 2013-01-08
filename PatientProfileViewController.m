//
//  PatientProfileViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/2/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "PatientProfileViewController.h"
#import "MakePrescriptionViewController.h"
#import "PrescViewController.h"

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

@synthesize prescButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"toNewPrescSegue"])
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        
        MakePrescriptionViewController *destViewController = (MakePrescriptionViewController*)segue.destinationViewController;
        
        destViewController.patientID = self.tempPatientID;
        destViewController.doctorID = [userDefaults objectForKey:@"userID"];
    
    }
    
    else if ([segue.identifier isEqualToString:@"toViewPrescSegue"]){
        
        
        PrescViewController * destViewController = (PrescViewController *)segue.destinationViewController;
        destViewController.userID = self.tempPatientID;

        
    }
    
    
    
    
    
    
}


- (void)viewDidLoad
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    
    //self.firstName = [userDefaults objectForKey:@"first_name"];
    //self.lastNameField = [userDefaults objectForKey:@"last_name"];
    
    NSLog(@"first name class: %@",[[userDefaults objectForKey:@"first_name"] class] );
    
    
    self.firstNameField.text = self.firstName;
    self.lastNameField.text =  self.lastName;
    self.birthdayField.text = self.birthday;
    self.healthCardField.text = self.healthCard;
    
    NSLog(@"tempPatientID:: %@", self.tempPatientID);
    
    NSLog(@"account Type ID: %@",[userDefaults objectForKey:@"account_type_id"]  );
    
    if ([userDefaults objectForKey:@"account_type_id"] == @"3")
    {
        self.prescButton.hidden = YES;
        
    }
    
    //[userDefaults setObject:self.userID forKey:@"userID"];
    //[userDefaults synchronize];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
