//
//  NewPatientProfileViewController.h
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPatientProfileViewController : UIViewController<UITextFieldDelegate>{
    
    
    IBOutlet UIPickerView *datePicker;

    
    
}

@property (strong,nonatomic) IBOutlet UIPickerView *datePicker;


@property (strong,nonatomic) IBOutlet UIButton * selectBDay;
@property (strong, nonatomic) IBOutlet UILabel *birthday;

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;

@property (weak, nonatomic)  NSString *year;
@property (weak, nonatomic)  NSString *month;
@property (weak, nonatomic)  NSString *day;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *healthCardNum;


@property (strong, nonatomic) NSString *regURL;


@property (strong, nonatomic) NSMutableArray * yearArray;
@property (strong, nonatomic) NSMutableArray * monthArray;
@property (strong, nonatomic) NSMutableArray * dayArray;



- (IBAction)pressSelect:(id)sender;
- (IBAction)pressCreate:(id)sender;
-(IBAction)changeDate:(id)sender;
@end
