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

@synthesize patientLogin;
@synthesize userID;
@synthesize password;

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
    
    if (textField == userID){
        self.userIDStr = textField.text;
    }
    
    if (textField == password){
        self.passwordStr = textField.text;
    }
    
    
    [textField resignFirstResponder];

    return YES;
}



- (IBAction)pressPatientLogin:(id)sender
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userID.text forKey:@"userID"];
    [userDefaults setObject:password.text forKey:@"password"];
    [userDefaults synchronize];
    
    
    NSLog(@"Login Pressed!");
    NSLog(@"contained fields: ID %@ Pass %@", [userDefaults objectForKey:@"userID"], [userDefaults objectForKey:@"password"]);
    
}

- (void)viewDidLoad
{
    
    
    //self.loginURL = [[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/login/?user=" stringByAppendingString:self.userIDStr] stringByAppendingString: @"&password="] stringByAppendingString: self.passwordStr];
    
    
    password.delegate = self; // ADD THIS LINE
    [self.view addSubview:password];
    
    userID.delegate = self; // ADD THIS LINE
    [self.view addSubview:userID];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.

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
