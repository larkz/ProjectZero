//
//  PrescViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/27/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PrescViewController.h"
#import "PrescTableCell.h"
#import "UserVariables.h"

#define dataQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define dataURL [NSURL URLWithString:@"http://localhost:8888/index.php/QRCodeGen/getUser/?user_id=1"]

@interface PrescViewController ()


@end

@implementation PrescViewController

@synthesize prescList;


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
    return [self.prescList count];
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
    
    cell.drugName.text = [[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"];
    cell.date.text = @"Date";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    
}




- (void)viewDidLoad
{
    NSData* data = [NSData dataWithContentsOfURL:
                    dataURL];
    
    NSError* error;
    
    self.prescList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"%@", [self.prescList objectAtIndex:1] );
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
