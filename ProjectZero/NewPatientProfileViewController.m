//
//  NewPatientProfileViewController.m
//  ProjectZero
//
//  Created by Larkin on 12/31/12.
//  Copyright (c) 2012 Larkin. All rights reserved.
//

#import "NewPatientProfileViewController.h"
#import "PatientProfileViewController.h"

@interface NewPatientProfileViewController ()

@end

@implementation NewPatientProfileViewController


@synthesize firstName;
@synthesize lastName;
@synthesize year;
@synthesize month;
@synthesize day;
@synthesize password;
@synthesize healthCardNum;
@synthesize regURL;

@synthesize yearArray;

- (void)viewDidLoad
{
    
    [self.datePicker setDataSource: self];
    [self.datePicker setDelegate: self];
    
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;

    self.password.delegate = self;
    self.healthCardNum.delegate = self;
    
    //Datepicker
    
    self.datePicker.hidden = YES;
    
    
    
    self.yearArray = [[NSMutableArray alloc] init];
    for (int i =2012; i>1900; i--){
        
        //NSLog(@"number i:%@", [NSString stringWithFormat:@"%d", i]);
        [yearArray addObject: [NSString stringWithFormat:@"%d", i]];
        
    }
    

    //NSLog(@"Year Array:%@", self.yearArray );
    
    self.monthArray = [[NSMutableArray alloc] init];
    for (int i =1; i<13; i++){
        
        //NSLog(@"number i:%@", [NSString stringWithFormat:@"%d", i]);
        [self.monthArray addObject: [NSString stringWithFormat:@"%d", i]];
        
    }
    
    self.dayArray = [[NSMutableArray alloc] init];
    for (int i =1; i<32; i++){
        
        //NSLog(@"number i:%@", [NSString stringWithFormat:@"%d", i]);
        [self.dayArray addObject: [NSString stringWithFormat:@"%d", i]];
        
    }
    

//    
//    [self.datePicker addTarget:self
//               action:@selector(dateChange:)
//     forControlEvents:UIControlEventValueChanged];
    
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

//- (BOOL)checkZeroTuple:(NSArray * )A{
//    
//    int i;
//    for(i = 0; i<[A count]; i++){
//        if(( [A objectAtIndex:i] + [A objectAtIndex:(i+1)] + [A objectAtIndex:(i+2)]) ==0){
//            
//            
//            
//        }
//        
//        
//    }
//    
//    
//}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.yearArray count];
    }
    if (component == 1){
        
        return [self.monthArray count];
    }
    return [self.dayArray count];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3; // or 2 or more
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //For one component (column)
    //return [oneColumnList objectAtIndex:row];
    
    //For mutiple columns
    if (component == 0) {
        return [self.yearArray objectAtIndex:row];
        
    }
    if (component ==1){
        return [self.monthArray objectAtIndex:row];
    }
    
    return [self.dayArray objectAtIndex:row];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        self.year =[self.yearArray objectAtIndex:row];
        return;
    }
    if (component == 1) {
        
        self.month =[self.monthArray objectAtIndex:row];
        return;
    }
    self.day = [self.dayArray objectAtIndex:row];

}




- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    [textField setReturnKeyType:UIReturnKeyDone];

    
    
//    [UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDuration:0.5];
//	[UIView setAnimationBeginsFromCurrentState:YES];
//	textField.frame = CGRectMake(textField.frame.origin.x, (textField.frame.origin.y - 120.0), textField.frame.size.width, textField.frame.size.height);
//	[UIView commitAnimations];
    
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"toProfileSegue"]){
        
        PatientProfileViewController *destViewController = (PatientProfileViewController*)segue.destinationViewController;
        
        
        self.regURL = [[[[[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addUser/?first_name="
                                stringByAppendingString:self.firstName.text] stringByAppendingString:@"&last_name="]
                              stringByAppendingString:self.lastName.text]
                             stringByAppendingString:@"&password="]
                            stringByAppendingString:self.password.text]
                           stringByAppendingString:@"&account_type_id=2"]
                          stringByAppendingString:@"&ohip=" ]
                         stringByAppendingString:self.healthCardNum.text]
                        stringByAppendingString:@"&birthday="]
                       stringByAppendingString:self.birthday.text];
        
        NSData* verData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.regURL]];
        
        NSError * error;
        
        [[NSJSONSerialization JSONObjectWithData:verData options:kNilOptions error:&error] objectAtIndex:0];
        
        
        
        NSURL *validUserUrl = [NSURL URLWithString:[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/getUserFromOHIP/?ohip=" stringByAppendingString:self.healthCardNum.text]];
        
        verData = [NSData dataWithContentsOfURL:validUserUrl];
        
        NSDictionary * verDict = [[NSJSONSerialization JSONObjectWithData:verData options:kNilOptions error:&error] objectAtIndex:0];
        
        destViewController.tempPatientID = [verDict objectForKey:@"id"];
        NSLog(@"Got patiend ID after registration: %@", destViewController.tempPatientID);
        
        
        
        
        
        
        
        //destViewController.firstName = self.firstName.text;
        //destViewController.lastName = self.lastName.text;
        //destViewController.healthCard = self.healthCardNum.text;
        //destViewController.regPass = self.password.text;
        //destViewController.birthday = [self.birthday.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
//        NSLog(@"self.firstName class :: %@", [self.firstName class]);
//        NSLog(@"test:: %@", [[self.year.text stringByAppendingString: self.month.text] stringByAppendingString: self.day.text]);
//        
//        
//        NSArray *myStrings = [[NSArray alloc] initWithObjects: self.year.text, self.month.text, self.day.text, nil];
//        NSString *joinedString = [myStrings componentsJoinedByString:@"-"];
//        NSLog(@"joined string :: %@", joinedString); 
//        destViewController.birthday = joinedString;
        
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    
    [textField resignFirstResponder];
    
    return YES;
}



- (IBAction)pressCreate:(id)sender
{
    
    
    
    
    if ( ![self.firstName.text isEqual:@"" ] && ![self.lastName.text isEqual:@""] && ![self.healthCardNum.text isEqual:@""] && ![self.password.text isEqual:@""]){
    
    
        [self performSegueWithIdentifier:@"toProfileSegue" sender:self];
        
    } else {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unfilled Fields"
                                                        message:@"Please fill out all fields."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
    
//    self.regURL = [[[[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addUser/?first_name=" stringByAppendingString:self.firstName.text] stringByAppendingString:@"&last_name="] stringByAppendingString:self.lastName.text]
//                   stringByAppendingString:@"&password=" ]
//                   stringByAppendingString:@"&account_type_id=2"]
//                    stringByAppendingString:@"&ohip=" ]
//                   stringByAppendingString:self.healthCardNum.text]
//                    stringByAppendingString:@"&birthday="]
//                   stringByAppendingString:birthdayText];
//    
//    
//    NSLog(@"ref URL :%@", self.regURL);
//    
//    
//    
//     NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.regURL]];
//    
//    //NSError* error;
//    //[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"JSON Serialization:: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    
}

- (IBAction)pressSelect:(id)sender{
    
    
    
    if ([self.selectBDay.titleLabel.text isEqualToString:@"Select Birthday:"]){
        
        NSLog(@"IsEqualtoSelect");
        
        self.datePicker.hidden = NO;
        
        [self.selectBDay setTitle:@"OK" forState:UIControlStateNormal];
        
    }
    else if([self.selectBDay.titleLabel.text isEqualToString:@"OK"]){
        
        self.datePicker.hidden = YES;
        [self.selectBDay setTitle:@"Select Birthday:" forState:UIControlStateNormal];
        
        NSArray *myStrings = [[NSArray alloc] initWithObjects: self.year, self.month, self.day, nil];
        
        self.birthday.text = [myStrings componentsJoinedByString:@"-"];
        
        
        
        NSLog(@"joined string :: %@", self.birthday);
    }
    
    
    
//            NSArray *myStrings = [[NSArray alloc] initWithObjects: self.year, self.month, self.day, nil];
//    
//            self.birthday.text = [myStrings componentsJoinedByString:@"-"];
//    
//            NSLog(@"joined string :: %@", self.birthday);
    
    
    
    
    
    
    
    
}


-(IBAction)changeDate:(id)sender {
	
    
    //NSDate * selected = [self.datePicker date];
	//NSString * date = [selected description];
    //self.birthday.text = date;
    
    
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
