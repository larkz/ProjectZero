//
//  MakePrescriptionViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/3/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakePrescriptionViewController : UIViewController <UITextFieldDelegate>{
    
    
}


@property (strong, nonatomic) NSString * drugName;
@property (strong, nonatomic) NSString * description;


@property (weak, nonatomic) IBOutlet UITextField * drugNameField;
@property (weak, nonatomic) IBOutlet UITextView * descriptionView;

@property (weak, nonatomic) NSString * userID;
@property (weak, nonatomic) NSString * doctorID;
@property (weak, nonatomic) NSString * addPrescURL;

@property (weak, nonatomic) UIImage * QRImage;

- (IBAction)pressMakePresc:(id)sender;

@end
