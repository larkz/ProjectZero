//
//  PharmaHomeViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/4/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//


#import "PharmaHomeViewController.h"


@interface PharmaHomeViewController ()


@end


@implementation PharmaHomeViewController


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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"3" forKey:@"account_type_id"];
    [userDefaults synchronize];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) verify:(id)sender
{
    // Use this to decode from Camera
    ZBarReaderViewController * reader = [ZBarReaderViewController new];
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;

    // Use this to decode from Image Library
    //ZBarReaderController * reader = [ZBarReaderController new];
    
    reader.readerDelegate = self;
    
    ZBarImageScanner * scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:reader animated:YES completion:nil];
    
}



- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol = nil;
    for (symbol in results) {
        
        NSString * result = symbol.data;
        
        NSLog(result);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QR Code Scanned"
                                                        message:result
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

        
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



@end