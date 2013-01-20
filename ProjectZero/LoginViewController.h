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

- (void)postNotificationWithString:(NSString *)orientation;
- (void)useNotificationWithString:(NSNotification*)notification;


@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UITextField *OHIPNum;
@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) NSString * userIDStr;
@property (strong, nonatomic) NSString * passwordStr;
@property (strong, nonatomic) NSString * loginURL;

@property (strong, nonatomic) NSString * fetchIDURL;

@property (strong, nonatomic) NSMutableDictionary * fetchIDDict;

- (IBAction)pressLogin:(id)sender;
- (IBAction)pressRegister:(id)sender;


@end
