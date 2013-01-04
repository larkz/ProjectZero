//
//  MakePrescriptionViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/3/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakePrescriptionViewController : UIViewController{
    
    
}


@property (strong, nonatomic) NSString * drugName;
@property (strong, nonatomic) NSString * description;


@property (weak, nonatomic) IBOutlet UITextField * drugNameField;
@property (weak, nonatomic) IBOutlet UITextView * descriptionView;

@property (weak, nonatomic) NSString * userID;

- (IBAction)pressMakePresc:(id)sender;

@end
