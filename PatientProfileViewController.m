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
@synthesize regPass;


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
    NSLog(@"DID LOAD SCREEN!");
    NSLog(@"tempPatientID:: %@", self.tempPatientID);
    
    NSLog(@"account Type ID: %@",[userDefaults objectForKey:@"account_type_id"]  );
    
    if ([[userDefaults objectForKey:@"account_type_id"] isEqualToString:@"1"]){

    
        NSLog(@"first name class: %@",[[userDefaults objectForKey:@"first_name"] class] );
        NSLog(@"%@ %@ %@ %@", self.firstName, self.lastName, self.healthCard, self.birthday);
    
        if(self.tempPatientID == nil){
    
    
            self.regURL = [[[[[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addUser/?first_name="
                                    stringByAppendingString:self.firstName] stringByAppendingString:@"&last_name="]
                                  stringByAppendingString:self.lastName]
                        stringByAppendingString:@"&password="]
                        stringByAppendingString:self.regPass]
                       stringByAppendingString:@"&account_type_id=2"]
                      stringByAppendingString:@"&ohip=" ]
                     stringByAppendingString:self.healthCard]
                    stringByAppendingString:@"&birthday="]
                   stringByAppendingString:self.birthday];
            
            NSData* verData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.regURL]];
            
            NSError * error;
            
            [[NSJSONSerialization JSONObjectWithData:verData options:kNilOptions error:&error] objectAtIndex:0];
        
            
            
            NSURL *validUserUrl = [NSURL URLWithString:[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserFromOHIP/?ohip=" stringByAppendingString:self.healthCard]];
            
            verData = [NSData dataWithContentsOfURL:validUserUrl];
            
            NSDictionary * verDict = [[NSJSONSerialization JSONObjectWithData:verData options:kNilOptions error:&error] objectAtIndex:0];
            
            self.tempPatientID = [verDict objectForKey:@"id"];
            NSLog(@"Got patiend ID after registration: %@", self.tempPatientID);
            
            
        }
    
        NSLog(@"ref URL :%@", self.regURL);
    
    
    }else if ([[userDefaults objectForKey:@"account_type_id"] isEqualToString:@"3"]){
        {
            self.prescButton.hidden = YES;
            self.patDesc.editable = NO;
        
        }
    
    }else if ([[userDefaults objectForKey:@"account_type_id"] isEqualToString: @"2"]){
        
        self.tempPatientID = [userDefaults objectForKey:@"userID"];
        NSLog(@"Patient Profile URL %@!", self.tempPatientID);
        
        self.prescButton.hidden = YES;
        self.patDesc.editable = NO;


    }
    
    
    if (self.tempPatientID != nil){
        NSURL *validUserUrl = [NSURL URLWithString:[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserByID/?user_id=" stringByAppendingString:self.tempPatientID]];
        
        NSData* verData = [NSData dataWithContentsOfURL:validUserUrl];
        
        NSError * error;
        
        NSDictionary * verDict = [[NSJSONSerialization JSONObjectWithData:verData options:kNilOptions error:&error] objectAtIndex:0];
        
        
        self.firstName = [verDict objectForKey:@"first_name"];
        self.lastName = [verDict objectForKey:@"last_name"];
        self.healthCard =  [verDict objectForKey:@"OHIP"];
        self.birthday = [verDict objectForKey:@"birthday"];
        
        if ([verDict objectForKey:@"description"] != nil){
        
            self.patDesc.text = [verDict objectForKey:@"description"];
        }
    
    }

    NSLog(@"%@ %@ %@ %@", self.firstName, self.lastName, self.healthCard, self.birthday);
    self.firstNameField.text = self.firstName;
    self.lastNameField.text =  self.lastName;

    
    if (self.birthday){
        
        NSLog(@"Birthday non-nil class:%@", [self.birthday class]);
        self.birthday = @"unknown";
        self.birthdayField.text = @"Unknown Birthday";
    
    }else{
        self.birthdayField.text = self.birthday;
    }
    
    self.healthCardField.text = self.healthCard;
    
    self.doneButton.hidden = YES;
    
    self.patDesc.delegate = self;
    NSLog(@"DID FINISH LOAD SCREEN!");
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    
        
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    self.patDesc.frame = CGRectMake(self.patDesc.frame.origin.x, (self.patDesc.frame.origin.y - 50.0), self.patDesc.frame.size.width, self.patDesc.frame.size.height);
    
    [textView setFrame:CGRectMake(20, 20, 280, 120)];
    [textView setReturnKeyType:UIReturnKeyDefault];

    self.doneButton.hidden = NO;
    [UIView commitAnimations];
    
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    self.patDesc.frame = CGRectMake(self.patDesc.frame.origin.x, (self.patDesc.frame.origin.y + 50.0), self.patDesc.frame.size.width, self.patDesc.frame.size.height);
    
    [textView setFrame:CGRectMake(20, 140, 280, 170)];
    
    self.doneButton.hidden = YES;
    [UIView commitAnimations];
    
    
    NSString *urlReady = [self.patDesc.text
                          stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Description for conversion to URL %@", urlReady);
    NSString *patDescStr = [[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addUserDescription/?user_id="
                              stringByAppendingString:self.tempPatientID]
                             stringByAppendingString:@"&description=" ]
                            stringByAppendingString:urlReady];
    
    
    
    NSURL *patDescURL = [NSURL URLWithString:patDescStr];
    
    NSData* data = [NSData dataWithContentsOfURL:patDescURL];
    NSError* error;
    [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0];
    

}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    if ([self.patDesc.text isEqualToString:@"Enter Patient Description"]){
        textView.text = @"";
        
    }
    return YES;
}

- (IBAction)pressDone:(id)sender{
    
    
    [self.patDesc resignFirstResponder];
    self.doneButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
