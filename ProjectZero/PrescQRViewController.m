//
//  PrescQRViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/30/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PrescQRViewController.h"
#import "PrescViewController.h"
#import "VerifyViewController.h"


@interface PrescQRViewController ()

@end

@implementation PrescQRViewController

@synthesize drugName;
@synthesize drugNameTextField;
@synthesize QRImage;
@synthesize QRImageView;
@synthesize imageURL;
@synthesize description;
@synthesize descriptionTextField;
@synthesize prescID;

@synthesize buttonTop;
@synthesize buttonBot;



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
    
    
    //self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/generate/?code=Hello"]]];

    //http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUser/?user_id=
    //http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/retrieveQRCode/?user_id=1&drug=DRUG
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"detected account type:%@", [[userDefaults objectForKey:@"account_type_id" ] class]);
    
    
    //Doctor
    if ([[userDefaults objectForKey:@"account_type_id" ] isEqualToString:@"1"]){
        
        NSLog(@"detected doctor!");
        
        [self.buttonTop setTitle:@"Remove Prescription" forState:UIControlStateNormal];  [self.buttonBot setTitle:@"Confirm Prescription"forState:UIControlStateNormal];
        
        
    }
    if( [[userDefaults objectForKey:@"account_type_id" ]isEqualToString:@"2"]    ){
        
        NSLog(@"detected patient!");
        
        self.buttonTop.hidden = YES;
        self.buttonBot.hidden = YES;
        
    }
    if([[userDefaults objectForKey:@"account_type_id" ]isEqualToString:@"3"]){
        
        NSLog(@"detected pharmacist!");
        
        self.buttonTop.hidden = YES;
        [self.buttonBot setTitle:@"Confirm Prescription"forState:UIControlStateNormal];        
        
    }
    
    
    
    
    
    
    if (self.imageURL == nil){
        //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.imageURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/retrieveQRCode/?presc_id=" stringByAppendingString:self.prescID];
    }

    
    
    self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.imageURL ]]];

    
    
    NSData * data = [ NSData dataWithContentsOfURL:[NSURL URLWithString: [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/scanCode/?presc_id=" stringByAppendingString:self.prescID] ]];
    
    NSError *error;
    
    //if (self.drugName != nil){
    self.drugName = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"drug"];
    
    
    
    
    
    
    
    if (self.drugName != nil){
    
    NSLog(@"drugName:%@  ||  prescID:%@ || URL:%@", self.drugName, self.prescID, [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/scanCode/?presc_id=" stringByAppendingString:self.prescID] );
    
    self.description = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"note"];
    
    self.refills = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"refills"];
    
    self.doctorID = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"doctor_id"];
    
        
        
    self.patientID = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"user_id"];
        
    
    NSData * doctorData = [ NSData dataWithContentsOfURL:[NSURL URLWithString: [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserByID/?user_id=" stringByAppendingString:self.doctorID] ]];
        
    NSData * patientData = [ NSData dataWithContentsOfURL:[NSURL URLWithString: [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserByID/?user_id=" stringByAppendingString:self.patientID] ]];
    
    self.doctorName = [[[[[NSJSONSerialization JSONObjectWithData:doctorData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"first_name"] stringByAppendingString:@" " ] stringByAppendingString:[[[NSJSONSerialization JSONObjectWithData:doctorData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"last_name"]];
        
        self.patientName = [[[[[NSJSONSerialization JSONObjectWithData:patientData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"first_name"] stringByAppendingString:@" " ] stringByAppendingString:[[[NSJSONSerialization JSONObjectWithData:doctorData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"last_name"]];
        
        
    }
    
    
    
    if (self.QRImage == nil){
        
        NSLog(@"Error Occured while retrieving image");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Unable to Retrieve QR Image"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    NSLog(@"Image URL %@", self.imageURL);
    
    self.QRImageView.image = self.QRImage;
    [self.QRImageView setNeedsDisplay];
    
    if (self.QRImage != nil){
    
        self.drugNameTextField.text = self.drugName;
        self.descriptionTextField.text = self.description;
        
        self.doctorNameLabel.text = self.doctorName;
        self.dateLabel.text = self.dateOfIssue;
        self.patientNameLabel.text = self.patientName;
        
        // Convert to NSString
        NSLog(@"Refills class type:%@", [self.refills class] );
        
        if ([self.refills isKindOfClass:[NSString class]]){
            self.refillsLabel.text = self.refills;
        }
        
        
        
        
    }
    
    
    NSLog(@"Text Label: %@", self.drugName );
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"toPrescVerifySegue"]){
        
        VerifyViewController *destViewController = (VerifyViewController*)segue.destinationViewController;
        
        destViewController.drugName = self.drugName;
        
        destViewController.description = self.description;
        
    }
    
}








- (IBAction)verifyPresc:(id)sender{
    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
