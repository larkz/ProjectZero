//
//  PatientListViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PatientListViewController.h"
#import "UserTableCell.h"

#define dataDefault [NSURL URLWithString:@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/fetchUsers"]

@interface PatientListViewController ()

@end

@implementation PatientListViewController

@synthesize patientlist;
@synthesize dataURL;



- (void)viewDidLoad
{
    
    //self.tableView.dataSource = self;
    
    
    self.dataURL =  @"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/fetchUsers";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    
    [NSURL URLWithString:self.dataURL];
    
    NSLog(@"access URL %@",  self.dataURL);
    
    
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataURL]];
    
    NSError* error;
    self.patientlist = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    [super viewDidLoad];
    
    //NSLog(@"PatientList: %@", self.tableView);
    
    //[self.tableView reloadData];
    
	// Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numRowsinSection");

    return [self.patientlist count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellFORROWINDEXPath");
    
    static NSString *UserTableCellIdentifier = @"UserTableCell";
    
    UserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:UserTableCellIdentifier];
    
    if (cell == nil) {
        cell = [[UserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserTableCellIdentifier];
    }
    
    cell.name.text = @"asdf";
    //[[self.patientlist objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    
     NSLog(@"cell: %@", cell);
    
    
    return cell;
    
    
    
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
