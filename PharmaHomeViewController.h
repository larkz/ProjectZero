//
//  PharmaHomeViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/4/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingObjC/ZXingObjC.h"

@interface PharmaHomeViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController * imgPicker;
}

-(IBAction)verify:(id)sender;


@property (nonatomic, retain) UIImagePickerController * imgPicker;

@end
