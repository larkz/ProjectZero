//
//  PrescTableCell.h
//  ProjectZero
//
//  Created by Larkin on 12/27/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescTableCell : UITableViewCell


{
    IBOutlet UITextField *drugName;
    IBOutlet UITextField *date;
    IBOutlet UITextField *pic;
}

@property (weak, nonatomic) IBOutlet UITextField *drugName;
@property (weak, nonatomic) IBOutlet UITextField *date;

@property (weak, nonatomic) IBOutlet UIImageView *pic;




@end
