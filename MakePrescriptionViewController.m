//
//  MakePrescriptionViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/3/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "MakePrescriptionViewController.h"
#import "PrescQRViewController.h"

@interface MakePrescriptionViewController ()

@end

@implementation MakePrescriptionViewController

@synthesize drugName;
@synthesize description;

@synthesize drugNameField;
@synthesize descriptionView;

@synthesize userID;
@synthesize doctorID;

@synthesize addPrescURL;
@synthesize QRImage;


- (void)viewDidLoad
{
    
    //For now
    self.doctorID = @"1";
    //for now
    
    self.drugNameField.delegate = self;
    self.drugNameField.delegate = self;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"QRImage: %@", self.QRImage);
    
    if ([segue.identifier isEqualToString:@"PrescQRSegue"]){
        
        
        
        self.drugName = self.drugNameField.text;
        self.description = self.descriptionView.text;
        
        
        NSLog(@"display drug %@",self.drugName);
        NSLog(@"Display Desc %@", self.description);
        
        
        //http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=1&doctor_id=3&drug=advil&note=HELLO&refills=5
        
        
        
        self.addPrescURL = [[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=" stringByAppendingString: self.userID] stringByAppendingString:@"&doctor_id="] stringByAppendingString:self.doctorID] stringByAppendingString:@"&drug=" ]  stringByAppendingString: self.drugName];
        
        NSLog(@"display addPrescURL: %@", self.addPrescURL);
        
        // NSError* error;
        //NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.addPrescURL]];
        
        
        //self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.addPrescURL]]];

        
        
        
        
        PrescQRViewController *destViewController = (PrescQRViewController*)segue.destinationViewController;
        //destViewController.QRImage = self.QRImage;
        
        destViewController.drugName = self.drugName;
        destViewController.imageURL = self.addPrescURL;
        
        
        NSLog(@"QRImage: %@", self.QRImage);
        
        
    }
        
        
}


- (IBAction)pressMakePresc:(id)sender;
{
    
    
//    //For now
//    self.doctorID = @"1";
//    //for now
//    
//    
//    self.drugNameField.delegate = self;
//    self.drugNameField.delegate = self;
//    
//    self.drugName = self.drugNameField.text;
//    self.description = self.descriptionView.text;
//    
//    
//    NSLog(@"display drug %@",self.drugName);
//    NSLog(@"Display Desc %@", self.description);
//    
//    
////http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=1&doctor_id=3&drug=advil&note=HELLO&refills=5
//
//    
//    
//    self.addPrescURL = [[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=" stringByAppendingString: self.userID] stringByAppendingString:@"&doctor_id="] stringByAppendingString:self.doctorID] stringByAppendingString:@"&drug=" ]  stringByAppendingString: self.drugName];
//    
//    NSLog(@"display addPrescURL: %@", self.addPrescURL);
//    
//   // NSError* error;
//    //NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.addPrescURL]];
//    
//    
//    self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.addPrescURL]]];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    
    return YES;
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
