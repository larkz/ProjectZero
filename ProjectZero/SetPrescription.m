//
//  SetPrescription.m
//  ProjectZero
//
//  Created by Stephen Diadamo on 2012-12-28.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "SetPrescription.h"

@interface SetPrescription ()

@end

@implementation SetPrescription

@synthesize drugName;
@synthesize patientID;
@synthesize submit;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButton:(id)sender{
    NSString *pID = patientID.text;
    NSString *drug = drugName.text;
    NSString *docID = @"5";
    
    NSString *get = [NSString stringWithFormat:@"http://localhost:8888/index.php/QRCodeGen/addNewPrescription/?user_id=%@&doctor_id=%@&drug=%@", pID, docID, drug];

    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:get]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    NSURLResponse* response = nil;
    // Unused variable data. This can be removed but I'll leave it for reference for something
    // that returns data.
    NSData* data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:nil];
}


@end
