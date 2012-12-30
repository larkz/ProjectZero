//
//  PrescViewController.h
//  ProjectZero
//
//  Created by Larkin on 12/27/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVariables.h"


@interface PrescViewController : UIViewController{
    
    NSMutableArray *prescList;
    NSString *userID;
    NSString *dataURL;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSMutableArray *prescList;

@property (retain, nonatomic) NSString *userID;
@property (retain, nonatomic) NSString *dataURL;



@end
