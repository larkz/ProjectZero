//
//  PatientListViewController.h
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTableCell.h"

@interface PatientListViewController : UIViewController{
    
    
    NSMutableArray *patientList;
    NSString * dataURL;
    
}



@property (weak, nonatomic) NSMutableArray * patientlist;
@property (strong, nonatomic) NSString * dataURL;


@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
