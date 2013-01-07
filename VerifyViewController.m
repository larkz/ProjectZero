//
//  VerifyViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/6/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "VerifyViewController.h"
#import "PatientProfileViewController.h"
#import "PatListViewController.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController
@synthesize backButton;
@synthesize navigationController;

@synthesize drugName;
@synthesize drugNameLabel;
@synthesize description;
@synthesize descriptionLabel;


- (IBAction)pressBack

{
    
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    
    
    //PatientProfileViewController *destVC = [[PatientProfileViewController alloc] init];
    
     //[self performSegueWithIdentifier:@"toProfileFromVerifySegue" sender:self];
    
    //PatientProfileViewController *destVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PatProfVC"];

    
    //self.pushViewController:destVC animated:YES];



}





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
    
    
    self.descriptionLabel.text =  self.description;
    self.drugNameLabel.text = self.drugName;
    
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
