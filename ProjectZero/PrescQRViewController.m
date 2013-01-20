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
@synthesize QRImageButton;
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
    
    self.QRbool = @"no";
    
    NSLog(@"BOOL: %@",self.justPresc);
    
    if ([self.justPresc isEqualToString:@"YES"]){
        
        self.buttonTop.hidden = NO;
        self.buttonBot.hidden = YES;
        [self.buttonTop setTitle:@"Back Home" forState:UIControlStateNormal];

        
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"detected account type:%@", [userDefaults objectForKey:@"account_type_id" ]);
    
    //Doctor
    if ([[userDefaults objectForKey:@"account_type_id" ] isEqualToString:@"1"] &&
        self.justPresc == nil){
        
        NSLog(@"detected doctor!");
        //elf.buttonTop.hidden = NO;

        [self.buttonTop setTitle:@"Back Home" forState:UIControlStateNormal];
        [self.buttonBot setTitle:@"Remove Prescription"forState:UIControlStateNormal];
        
    }
    if( [[userDefaults objectForKey:@"account_type_id" ]isEqualToString:@"2"]    ){
        
        NSLog(@"detected patient!");
        
        self.buttonTop.hidden = YES;
        self.buttonBot.hidden = YES;
        
    }
    if([[userDefaults objectForKey:@"account_type_id" ]isEqualToString:@"3"]){
        
        NSLog(@"detected pharmacist!");
        //self.buttonTop.hidden = YES;
        
        [self.buttonTop setTitle:@"Decrease Refill"forState:UIControlStateNormal];
        [self.buttonBot setTitle:@"Remove Prescription"forState:UIControlStateNormal];        
        
    }
    
    
    if (self.imageURL == nil){
        //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.imageURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/retrieveQRCode/?presc_id=" stringByAppendingString:self.prescID];
    }

    
    
    self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.imageURL ]]];

    
    
    [self.largeQRView setImage:self.QRImage];
    
    self.largeQRView.hidden = YES;
    
    
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
        
        self.patientName = [[[[[NSJSONSerialization JSONObjectWithData:patientData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"first_name"] stringByAppendingString:@" " ] stringByAppendingString:[[[NSJSONSerialization JSONObjectWithData:patientData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"last_name"]];
        
        
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
    
    [self.QRImageButton setBackgroundImage:QRImage forState:UIControlStateNormal];
    
    
    [self.QRImageButton setNeedsDisplay];
    
    if (self.QRImage != nil){
    
        self.drugNameTextField.text = self.drugName;
        self.descriptionTextField.text = self.description;
        self.descriptionTextField.editable = NO;
        
        self.doctorNameLabel.text = self.doctorName;
        self.dateLabel.text = self.dateOfIssue;
        self.patientNameLabel.text = self.patientName;
        
        // Convert to NSString
        NSLog(@"Refills class type:%@", [self.refills class] );
        
        if ([self.refills isKindOfClass:[NSString class]]){
            self.refillsLabel.text = self.refills;
        }else{
            
            self.refillsLabel.text = [NSString stringWithFormat:@"%@",self.refills];

        }
        
        
        
        
    }
    
    
    NSLog(@"Text Label: %@", self.drugName );
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
}




- (IBAction)pressBottom:(id)sender{
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if([[userDefaults objectForKey:@"account_type_id" ] isEqualToString:@"1"]){
        
        NSString * removeURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/removePresc/?presc_id=" stringByAppendingString:self.prescID];
        
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:removeURL]];
        NSError* error;
        
        [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0];
        
        [self performSegueWithIdentifier:@"toDoctorHomeSegue" sender:self];
       
        
    }else if ([[userDefaults objectForKey:@"account_type_id" ] isEqualToString:@"3"] ){
        
        NSString * removeURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/removePresc/?presc_id=" stringByAppendingString:self.prescID];
        
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:removeURL]];
        NSError* error;
        
         [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0];
        
        [self performSegueWithIdentifier:@"toPharHome" sender:self];

    }else{
        [self performSegueWithIdentifier:@"toPatHome" sender:self];
    }
    

    
}

- (IBAction)pressTop:(id)sender{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults objectForKey:@"account_type_id" ] isEqualToString:@"1"] ){
        [self performSegueWithIdentifier:@"toDoctorHomeSegue" sender:self];
    }
    
    
    else if ([[userDefaults objectForKey:@"account_type_id" ] isEqualToString:@"3"] ){
        
        if ([self.refillsLabel.text intValue] > 0){
            
            NSString * removeURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/decreasePresc/?presc_id=" stringByAppendingString:self.prescID];
            
            NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:removeURL]];
            NSError* error;
            
            [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0];
            
            
            self.refillsLabel.text = [NSString stringWithFormat:@"%d", [self.refillsLabel.text intValue] - 1 ];
            
            [self.refillsLabel setNeedsDisplay];
            
        }
    }
    
}


- (IBAction)tapQR:(id)sender{
    
    if ([self.QRbool isEqualToString:@"no"]){
        
        NSLog(@"show QR view");
        
        
        self.QRbool = @"yes";
        self.largeQRView.hidden = NO;
        [self.view bringSubviewToFront:self.largeQRView];

        
        
        
    }else if ([self.QRbool isEqualToString:@"yes"]){
        
        NSLog(@"hide QR view");
        
        self.QRbool = @"no";
        self.largeQRView.hidden = YES;
        
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
