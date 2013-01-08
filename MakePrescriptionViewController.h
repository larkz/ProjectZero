//
//  MakePrescriptionViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/3/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakePrescriptionViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    
    UIPickerView *refillPicker;
    NSMutableArray * refillArray;
    
    
}


@property (strong, nonatomic) NSString * drugName;
@property (strong, nonatomic) NSString * description;
@property (strong, nonatomic) NSString * amountRefill;



@property (weak, nonatomic) IBOutlet UITextField * drugNameField;
@property (weak, nonatomic) IBOutlet UITextView * descriptionView;
@property (strong, nonatomic) IBOutlet UIPickerView * refillPicker;

@property (strong, nonatomic) NSMutableArray * refillArray;


@property (weak, nonatomic) NSString * patientID;
@property (weak, nonatomic) NSString * doctorID;
@property (weak, nonatomic) NSString * addPrescURL;

@property (weak, nonatomic) UIImage * QRImage;



@property (strong, nonatomic) IBOutlet UIButton *numRefillButton;


- (IBAction)pressMakePresc:(id)sender;
- (IBAction)pressNumRefill:(id)sender;



@end
