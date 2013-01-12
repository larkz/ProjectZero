//
//  PatientProfileViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/2/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientProfileViewController : UIViewController{
    
    NSString * firstName;
    NSString * lastName;
    NSString * birthday;
    NSString * healthCard;
    
    NSString * userID;
    NSString * prescID;
    UIButton * prescButton;
    
    
}


@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * lastName;
@property (strong, nonatomic) NSString * birthday;
@property (strong, nonatomic) NSString * healthCard;
@property (strong, nonatomic) NSString * prescID;

@property (strong, nonatomic) NSString * regPass;


@property IBOutlet UIButton * prescButton;


@property (strong, nonatomic) IBOutlet UILabel * firstNameField;
@property (strong, nonatomic) IBOutlet UILabel * lastNameField;
@property (strong, nonatomic) IBOutlet UILabel * birthdayField;
@property (strong, nonatomic) IBOutlet UILabel * healthCardField;
@property (strong, nonatomic) IBOutlet UIImageView * profPic;

@property (strong, nonatomic) NSString * tempPatientID;

@property (strong, nonatomic) NSString * regURL;


@end
