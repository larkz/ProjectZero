//
//  PatListViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PatListViewController.h"
#import "UserTableCell.h"
#import "PatientProfileViewController.h"

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
    
   static NSString *UserTableCellIdentifier = @"UserTableCell";
   
   UserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:UserTableCellIdentifier];
    
    if (cell == nil) {
        cell = [[UserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserTableCellIdentifier];
        
        NSLog(@"allocated cell");
    }

    if ( [[self.patList objectAtIndex:indexPath.row]  objectForKey:@"first_name"] != [NSNull null] && [[self.patList objectAtIndex:indexPath.row]  objectForKey:@"last_name"] != [NSNull null] ){
        cell.name.text = [[[[self.patList objectAtIndex:indexPath.row] objectForKey:@"first_name"] stringByAppendingString:@" " ]  stringByAppendingString:[[self.patList objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
    }
    
    //cell.name.text = [[self.patList objectAtIndex:indexPath.row] objectForKey:@"first_name"]; //stringByAppendingString:[[self.patList objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
    
    
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"toProfileSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PatientProfileViewController *destViewController = (PatientProfileViewController*)segue.destinationViewController;

        destViewController.firstName = [[self.patList objectAtIndex:indexPath.row] objectForKey:@"first_name"];
        destViewController.lastName = [[self.patList objectAtIndex:indexPath.row] objectForKey:@"last_name"];
        
        destViewController.userID = [[self.patList objectAtIndex:indexPath.row] objectForKey:@"id"];
        
    }
    
    
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
