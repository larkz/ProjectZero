//
//  PharmaHomeViewController.h
//  ProjectZero
//
//  Created by Larkin on 1/4/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "ZBarSDK.h"


@interface PharmaHomeViewController : UIViewController <ZBarReaderDelegate>

{
    
    NSString * scanPrescID;

}


@property (nonatomic, retain) NSString * scanPrescID;


-(IBAction)test:(id)sender;
-(IBAction)verify:(id)sender;



@end
