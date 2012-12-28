//
//  SetPrescription.h
//  ProjectZero
//
//  Created by Stephen Diadamo on 2012-12-28.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPrescription : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *drugName;
@property (weak, nonatomic) IBOutlet UITextField *patientID;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end
