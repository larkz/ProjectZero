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
    
    
    NSLog(@"DID LOAD SCREEN!");
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    
    if ([userDefaults objectForKey:@"account_type_id"] == @"2"){
        
        self.prescButton.hidden = YES;
        
    }
    
    
    NSLog(@"first name class: %@",[[userDefaults objectForKey:@"first_name"] class] );

    
    
    NSLog(@"%@ %@ %@ %@", self.firstName, self.lastName, self.healthCard, self.birthday);
    
    if (self.tempPatientID != nil){
        NSURL *validUserUrl = [NSURL URLWithString:[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserByID/?user_id=" stringByAppendingString:self.tempPatientID]];
    
        NSData* verData = [NSData dataWithContentsOfURL:validUserUrl];
        
        NSError * error;
        
        NSDictionary * verDict = [[NSJSONSerialization JSONObjectWithData:verData options:kNilOptions error:&error] objectAtIndex:0];
        
        
        self.firstName = [verDict objectForKey:@"first_name"];
        self.lastName = [verDict objectForKey:@"last_name"];
        self.healthCard =  [verDict objectForKey:@"OHIP"];
        self.birthday = [verDict objectForKey:@"birthday"];

    }
    
    
    NSLog(@"%@ %@ %@ %@", self.firstName, self.lastName, self.healthCard, self.birthday);

    
    
    if(self.tempPatientID == nil){
    
    
    self.regURL = [[[[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addUser/?first_name=" stringByAppendingString:self.firstName] stringByAppendingString:@"&last_name="] stringByAppendingString:self.lastName]
                        stringByAppendingString:@"&password=" ]
                       stringByAppendingString:@"&account_type_id=2"]
                      stringByAppendingString:@"&ohip=" ]
                     stringByAppendingString:self.healthCard]
                    stringByAppendingString:@"&birthday="]
                   stringByAppendingString:self.birthday];
    }
    
    
    
    
    
    
    NSLog(@"ref URL :%@", self.regURL);
    
    
    
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.regURL]];
    
    //NSError* error;
    //[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    if (data != nil){
//    
//    if ( [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] isEqualToString:@"SUCCESS"]){
//    
//            NSLog(@"User Created!");
//        } else{
//        
//            NSLog(@"User Creation failed!");
//
//        }
//    }
    

    if (self.tempPatientID == nil){
        
        NSString *getUserUrl = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserFromOHIP/?ohip=" stringByAppendingString:self.healthCard];
        
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:getUserUrl]];
        
        NSError* error;
        
        NSDictionary * userDict = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0];
        
        self.tempPatientID = [userDict objectForKey:@"id"];
        
        
    }
    
    
    
    NSLog(@"tempPatientID:: %@", self.tempPatientID);
    
    NSLog(@"account Type ID: %@",[userDefaults objectForKey:@"account_type_id"]  );
    
    if ([userDefaults objectForKey:@"account_type_id"] == @"3")
    {
        self.prescButton.hidden = YES;
        
    }
    
    //[userDefaults setObject:self.userID forKey:@"userID"];
    //[userDefaults synchronize];
    
    
    self.firstNameField.text = self.firstName;
    self.lastNameField.text =  self.lastName;
    
    
    if (self.birthday == [NSNull null]){
        
        NSLog(@"Birthday non-nil class:%@", [self.birthday class]);        
        self.birthday = @"Unknown";
    
    }
    self.birthdayField.text = self.birthday;
        
    
    self.healthCardField.text = self.healthCard;
    
    
    NSLog(@"DID FINISH LOAD SCREEN!");

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
