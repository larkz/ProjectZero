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
@synthesize QRImage;
@synthesize QRImageView;
@synthesize imageURL;



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

    
    self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: self.imageURL ]]];
                    
    NSLog(@"Image URL %@", self.imageURL);
    
    self.QRImageView.image = self.QRImage;
    
    [self.QRImageView setNeedsDisplay];
    
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
