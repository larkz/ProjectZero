//
//  LoginViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/30/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize login;
@synthesize OHIPNum;
@synthesize password;
@synthesize loginURL;
@synthesize fetchIDURL;
@synthesize fetchIDDict;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //NSLog(@"textFieldShouldEndEditing");
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    
    if (textField == password){
        self.passwordStr = textField.text;
    }
    
    [textField resignFirstResponder];

    return YES;
}



- (IBAction)pressLogin:(id)sender
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.fetchIDURL = [@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserFromOHIP/?ohip=" stringByAppendingString:self.OHIPNum.text];
        
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.fetchIDURL]];
    
    NSError* error;

   self.fetchIDDict = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0];

    NSLog(@"fetchID URL %@", self.fetchIDURL);
    NSLog(@"fetchID type %@", self.fetchIDDict);
    
    
    
    [userDefaults setObject:password.text forKey:@"password"];
    [userDefaults synchronize];
    
    
    if ([self.password.text isEqualToString:[self.fetchIDDict objectForKey:@"password"]] ){
    
    
        if ( [[self.fetchIDDict objectForKey:@"account_type_id"] isEqualToString:@"1"]){
        
        [self performSegueWithIdentifier:@"toDoctorSegue" sender:self];

        }
    
        else if ( [[self.fetchIDDict objectForKey:@"account_type_id"] isEqualToString:@"2"]){
        
            [ self performSegueWithIdentifier:@"toPatientSegue" sender:self];
        
        }
    
        else if ( [[self.fetchIDDict objectForKey:@"account_type_id"] isEqualToString:@"3"]){
        
            [self performSegueWithIdentifier:@"toPharmaSegue" sender:self];
        
        }
    
    }
    
    else {
        
        NSLog(@"Incorrect User or Password");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Unsuccessful"
                                                        message:@"Incorrect User or Password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }


    NSLog(@"Login Pressed!");
    
    
    NSLog(@"contained fields: ID %@ Pass %@", [userDefaults objectForKey:@"userID"], [userDefaults objectForKey:@"password"]);
    
}




- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self postNotificationWithString:@"Portrait"];
    }
    else {
        [self postNotificationWithString:@"Landscape"];
    }
}





- (void)viewDidLoad
{
    
    //self.loginURL = [[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/login/?user=" stringByAppendingString:self.userIDStr] stringByAppendingString: @"&password="] stringByAppendingString: self.passwordStr];
    
    password.delegate = self; // ADD THIS LINE
    [self.view addSubview:password];
    
    OHIPNum.delegate = self; // ADD THIS LINE
    [self.view addSubview:OHIPNum];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}


- (IBAction)pressRegister:(id)sender{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Feature"
                                                    message:@"Will be Implemented Later"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"Pressed Register!");
    
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
