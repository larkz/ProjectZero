//
//  PatListViewController.h
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatListViewController : UIViewController{
    
    
    NSMutableArray *patList;
    NSString *accessURL;
    
    
}



@property (nonatomic, retain) IBOutlet UITableView *tableView;


@property (nonatomic, retain) NSMutableArray *patList;
@property (nonatomic, retain) NSString *accessURL;


@end
