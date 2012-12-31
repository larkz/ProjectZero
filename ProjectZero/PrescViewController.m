//
//  PrescViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/27/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "PrescViewController.h"
#import "PrescQRViewController.h"
#import "PrescTableCell.h"
#import "UserVariables.h"

#define dataQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define dataDefault [NSURL URLWithString:@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUser/?user_id=1"]

@interface PrescViewController ()


@end

@implementation PrescViewController

@synthesize prescList;
@synthesize userID;
@synthesize dataURL;
@synthesize selectedDrug;



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.prescList count];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"PrescQRSegue"])
	{
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PrescQRViewController *destViewController = (PrescQRViewController*)segue.destinationViewController;
        
        //destViewController.drugName.text = @"TESt";
        
        

        
      [[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"];
        
        
        //[[segue destinationViewController] setDrugName:[[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"]];

        destViewController.drugName = [[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"];
        
        //destViewController.drugName = [[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"];
        
        //[[segue destinationViewController] setDrugName:[[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"]];
    
        NSLog(@"Selected Row asdf: %@",[[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"]) ;
        NSLog(@"Selected Row asdf: %@", [segue.destinationViewController drugName]  );
        
        
	}
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedDrug = [[self.prescList objectAtIndex:indexPath.row] objectForKey:@"drug_name"];
    //NSLog(@"Selected Row: %@", self.selectedDrug);
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
    
    return cell;
}


- (void)viewDidLoad
{
    
    
   self.dataURL =  @"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUser/?user_id=";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    
    self.userID =[ userDefaults objectForKey:@"userID"];
    NSLog(@"User ID Presc %@", self.userID);
    
    
    [NSURL URLWithString:[self.dataURL stringByAppendingString:self.userID]];
    
    NSLog(@"access URL %@",  [self.dataURL stringByAppendingString:self.userID]);
    
    
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:[self.dataURL stringByAppendingString:self.userID]]];

    NSError* error;
    self.prescList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
