//
//  PatListViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PatListViewController.h"
#import "UserTableCell.h"

@interface PatListViewController ()

@end

@implementation PatListViewController

@synthesize patList;
@synthesize accessURL;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.patList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"asdf");
   static NSString *UserTableCellIdentifier = @"UserTableCell";
   
   UserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:UserTableCellIdentifier];
    
    if (cell == nil) {
        cell = [[UserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserTableCellIdentifier];
        
        NSLog(@"allocated cell");
    }

    
    cell.name.text = [[self.patList objectAtIndex:indexPath.row] objectForKey:@"name"];;
    
    
    [[self.patList objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}


- (void)viewDidLoad
{
    
    
    self.accessURL =  @"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/fetchUsers";
    
    NSLog(@"access URL %@",  self.accessURL);
    
    
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.accessURL]];
    
    NSError* error;
    self.patList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
