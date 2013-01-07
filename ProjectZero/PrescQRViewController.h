//
//  PrescQRViewController.h
//  ProjectZero
//
//  Created by Larkin on 12/30/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrescViewController.h"


@interface PrescQRViewController : UIViewController{
    
    UILabel * drugNameTextField;
    NSString *drugName;
    
    
}

@property (strong, nonatomic) IBOutlet UILabel *drugNameTextField;
@property (strong, nonatomic) NSString *drugName;

@property (strong, nonatomic) IBOutlet UIImageView *QRImageView;

@property (strong, nonatomic) IBOutlet UILabel *descriptionTextField;
@property (strong, nonatomic) NSString *description;

@property (strong, nonatomic) NSString * prescID;



- (IBAction)verifyPresc:(id)sender;


@property (strong, nonatomic) UIImage *QRImage;
@property (strong, nonatomic) NSString * imageURL;





@end
