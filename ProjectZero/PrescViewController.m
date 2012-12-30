//
//  PrescViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/27/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PrescViewController.h"
#import "PrescTableCell.h"

#import "SBJSON.h"

@interface PrescViewController ()

@end

@implementation PrescViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PrescTableCellIdentifier = @"PrescTableCell";
    
    PrescTableCell *cell = [tableView dequeueReusableCellWithIdentifier:PrescTableCellIdentifier];
    
    if (cell == nil) {
        cell = [[PrescTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PrescTableCellIdentifier];
    }
    
    cell.drugName.text = @"asdf";
    cell.date.text = @"1234";
    
    //cell.textLabel.text =@"Testing";
    
    //    cell.pic.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    
    return cell;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
