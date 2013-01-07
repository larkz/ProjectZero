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
    
    
    
    if (self.imageURL == nil){
        //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        self.imageURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/retrieveQRCode/?presc_id=" stringByAppendingString:self.prescID];
    }

    
    
    self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.imageURL ]]];

    
    
    NSData * data = [ NSData dataWithContentsOfURL:[NSURL URLWithString: [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/scanCode/?presc_id=" stringByAppendingString:self.prescID] ]];
    
    NSError *error;
    self.drugName = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"drug"];

    NSLog(@"drugName:%@  ||  prescID:%@ || URL:%@", self.drugName, self.prescID, [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/scanCode/?presc_id=" stringByAppendingString:self.prescID] );
    
    self.description = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"note"];
    
    self.refills = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"refills"];
    
    self.doctorID = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"doctor_id"];
    
    
    NSData * doctorData = [ NSData dataWithContentsOfURL:[NSURL URLWithString: [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserByID/?user_id=" stringByAppendingString:self.doctorID] ]];
    
    self.doctorName = [[[[[NSJSONSerialization JSONObjectWithData:doctorData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"first_name"] stringByAppendingString:@" " ] stringByAppendingString:[[[NSJSONSerialization JSONObjectWithData:doctorData options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"last_name"]];
    
    
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
    
    
    self.drugNameTextField.text = self.drugName;
    self.descriptionTextField.text = self.description;
    self.refillsLabel.text = self.refills;
    self.doctorNameLabel.text = self.doctorName;
    self.dateLabel.text = self.dateOfIssue;
    
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
