//
//  LoginViewController.h
//  ProjectZero
//
//  Created by Larkin on 12/30/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    
    NSString * userIDStr;
    NSString * passwordStr;
    
}



@property (strong, nonatomic) IBOutlet UIButton *patientLogin;
@property (strong, nonatomic) IBOutlet UITextField *userID;
@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) NSString * userIDStr;
@property (strong, nonatomic) NSString * passwordStr;


- (IBAction)pressPatientLogin:(id)sender;




@end
