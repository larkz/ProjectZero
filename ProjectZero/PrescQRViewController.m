//
//  PrescQRViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/30/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PrescQRViewController.h"
#import "PrescViewController.h"


@interface PrescQRViewController ()

@end

@implementation PrescQRViewController

@synthesize drugName;
@synthesize drugNameTextField;




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
    
    //self.drugName.text = @"text";
    self.drugNameTextField.text = self.drugName;
    NSLog(@"Text Label: %@", self.drugName );
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
