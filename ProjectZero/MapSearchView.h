//
//  MapSearchView.h
//  ProjectZero
//
//  Created by Larkin on 12/26/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapSearchView : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *postalCodeTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *distanceRadiusPicker;

@property (strong, nonatomic) NSMutableArray *distanceList;


@end
