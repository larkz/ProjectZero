//
//  NewPatientProfileViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "NewPatientProfileViewController.h"
#import "PatientProfileViewController.h"

@interface NewPatientProfileViewController ()

@end

@implementation NewPatientProfileViewController


@synthesize firstName;
@synthesize lastName;
@synthesize year;
@synthesize month;
@synthesize day;
@synthesize password;
@synthesize healthCardNum;
@synthesize regURL;


- (void)viewDidLoad
{
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.year.delegate = self;
    self.month.delegate = self;
    self.day.delegate =self;
    
    self.password.delegate = self;
    self.healthCardNum.delegate = self;
    
    
    
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}



//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    
//    
//    [UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDuration:0.5];
//	[UIView setAnimationBeginsFromCurrentState:YES];
//	textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y - 120.0), textField.frame.size.width, textField.frame.size.height);
//	[UIView commitAnimations];
//    
//    
//}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"toProfileSegue"]){
        
        PatientProfileViewController *destViewController = (PatientProfileViewController*)segue.destinationViewController;
        
        destViewController.firstName = self.firstName.text;
        destViewController.lastName = self.lastName.text;
        
        NSLog(@"self.firstName class :: %@", [self.firstName class]);
        NSLog(@"test:: %@", [[self.year.text stringByAppendingString: self.month.text] stringByAppendingString: self.day.text]);
        
        
        NSArray *myStrings = [[NSArray alloc] initWithObjects: self.year.text, self.month.text, self.day.text, nil];
        NSString *joinedString = [myStrings componentsJoinedByString:@"-"];
        NSLog(@"joined string :: %@", joinedString);
        destViewController.birthday = joinedString;
        
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    
    [textField resignFirstResponder];
    
    return YES;
}





- (IBAction)pressCreate:(id)sender
{
    
    self.regURL = [[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addUser/?first_name=" stringByAppendingString:self.firstName.text] stringByAppendingString:@"&last_name="] stringByAppendingString:self.lastName.text]
                   stringByAppendingString:@"&password=" ]
                   stringByAppendingString:@"&account_type_id=2"]
                    stringByAppendingString:@"&ohip=" ]
                   stringByAppendingString:self.healthCardNum.text];
    
    NSLog(@"ref URL :%@", self.regURL);
    
    
    
     NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.regURL]];
    
    //NSError* error;
    //[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON Serialization:: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    
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
