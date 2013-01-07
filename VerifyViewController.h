//
//  VerifyViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/6/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientProfileViewController.h"
#import "PatListViewController.h"



@interface VerifyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem * backButton;
@property (strong, nonatomic) IBOutlet UINavigationBar * navigationController;

@property (strong, nonatomic) IBOutlet UILabel * drugNameLabel;
@property (strong, nonatomic) IBOutlet UILabel * descriptionLabel;


@property (strong, nonatomic) NSString *drugName;
@property (strong, nonatomic) NSString *description;


- (IBAction)pressBack;




@end
