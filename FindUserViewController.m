//
//  FindUserViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/4/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "FindUserViewController.h"

@interface FindUserViewController ()

@end

@implementation FindUserViewController

@synthesize patientID;
@synthesize firstName;
@synthesize lastName;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //NSLog(@"textFieldShouldEndEditing");
    
    
    return YES;
    
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {

    NSLog(@"textFieldDidBeginEditing");

    
    if (textField == self.lastName){
    
    self.patientID.hidden = YES;
    self.seeAllPatients.hidden = YES;    
        
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
        
    self.lastName.frame = CGRectMake(self.lastName.frame.origin.x, (self.lastName.frame.origin.y - 170.0), self.lastName.frame.size.width, self.lastName.frame.size.height);
        
    self.searchByName.frame = CGRectMake(self.searchByName.frame.origin.x, (self.searchByName.frame.origin.y - 130.0), self.searchByName.frame.size.width, self.searchByName.frame.size.height);
        
        
	[UIView commitAnimations];
        
    }
    
    
    
    if (textField == self.firstName){
        
        self.patientID.hidden = YES;
        self.seeAllPatients.hidden = YES;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        self.firstName.frame = CGRectMake(self.firstName.frame.origin.x, (self.firstName.frame.origin.y - 130.0), self.firstName.frame.size.width, self.firstName.frame.size.height);
        
        self.searchByName.frame = CGRectMake(self.searchByName.frame.origin.x, (self.searchByName.frame.origin.y - 130.0), self.searchByName.frame.size.width, self.searchByName.frame.size.height);
        
        
        [UIView commitAnimations];
        
    }

    
    
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");

    self.patientID.hidden = NO;
    self.seeAllPatients.hidden = NO;

}



- (void)viewDidLoad
{
    self.patientID.delegate = self;
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
