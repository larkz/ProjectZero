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

@synthesize imgPicker;

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
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = YES;
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // Use this instead to get picture from camera
    //self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)verify:(id)sender
{
    [self presentViewController:imgPicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * QRCode = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CGImageRef imageToDecode = [QRCode CGImage];
    ZXLuminanceSource * source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap * bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    NSError * error = nil;
    ZXDecodeHints * hints = [ZXDecodeHints hints];
    ZXMultiFormatReader * reader = [ZXMultiFormatReader reader];
    ZXResult * result = [reader decode:bitmap hints:hints error:&error];
    
    if (result) {
        // the decoded string is stored in contents
        NSString * contents = result.text;
        NSLog(contents);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end