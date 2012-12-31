//
//  UserTableCell.h
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableCell : UITableViewCell

{
    IBOutlet UILabel *name;
    IBOutlet UILabel *subDesc;
    IBOutlet UIImageView *pic;
}

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *subDesc;

@property (strong, nonatomic) IBOutlet UIImageView *pic;


@end
