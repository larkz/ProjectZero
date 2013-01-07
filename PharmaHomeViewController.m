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
    
    // Access the uncropped image from info dictionary
    //UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Save image
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    
//    
//    UIImage * QRCode = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    NSLog(@"Show QRCode Image: %@", QRCode);
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    CGImageRef imageToDecode = [QRCode CGImage];
//    ZXLuminanceSource * source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
//    ZXBinaryBitmap * bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
//    NSError * error = nil;
//    ZXDecodeHints * hints = [ZXDecodeHints hints];
//    ZXMultiFormatReader * reader = [ZXMultiFormatReader reader];
//    ZXResult * result = [reader decode:bitmap hints:hints error:&error];
//    
//    
//    NSString * contents = result.text;
//    NSLog(@"show contents:%@", contents);
//    
//    
//    if (result) {
//        // the decoded string is stored in contents
//        NSString * contents = result.text;
//        NSLog(contents);
//    }
//
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGImageRef imageToDecode = image.CGImage;  // Given a CGImage in which we are looking for barcodes
    
    ZXLuminanceSource* source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap* bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError* error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints* hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader* reader = [ZXMultiFormatReader reader];
    ZXResult* result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString* contents = result.text;
        
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;
        NSLog(contents);
        
    } else {
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
        
        NSLog(@"reading error occured!");
    }
    
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    else // All is well
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"Image saved to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    [alert show];
    //[alert release];
}















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end