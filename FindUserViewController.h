//
//  FindUserViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/4/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindUserViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *orLabelTop;
@property (strong, nonatomic) IBOutlet UILabel *orLabeBot;


@property (strong, nonatomic) IBOutlet UITextField * patientID;

@property (strong, nonatomic) IBOutlet UITextField * firstName;
@property (strong, nonatomic) IBOutlet UITextField * lastName;

@property (strong, nonatomic) IBOutlet UIButton * seeAllPatients;
@property (strong, nonatomic) IBOutlet UIButton * searchByOHIP;
@property (strong, nonatomic) IBOutlet UIButton * searchByName;

@property (nonatomic, assign) BOOL didFinishName;


- (IBAction)seeAllPats:(id)sender;
- (IBAction)searchOHIP:(id)sender;
- (IBAction)serchByName:(id)sender;


@end
