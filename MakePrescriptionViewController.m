//
//  MakePrescriptionViewController.m
//  ProjectZero
//
//  Created by Larkin on 1/3/13.
//  Copyright (c) 2013 Larkin. All rights reserved.
//

#import "MakePrescriptionViewController.h"
#import "PrescQRViewController.h"

@interface MakePrescriptionViewController ()

@end

@implementation MakePrescriptionViewController

@synthesize drugName;
@synthesize description;

@synthesize drugNameField;
@synthesize descriptionView;

@synthesize patientID;
@synthesize doctorID;

@synthesize addPrescURL;
@synthesize QRImage;
@synthesize refillPicker;
@synthesize refillArray;

@synthesize numRefillButton;

@synthesize amountRefill;

- (void)viewDidLoad
{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    self.dateLabel.text = [@"Date: " stringByAppendingString:dateString];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    //For now
    self.doctorID = [userDefaults objectForKey:@"userID"];
    //for now
    self.amountRefill = @"0";
    
    
    if (self.doctorID == nil){
        
        self.doctorID = @"1";
        
    }

    
    [descriptionView setScrollEnabled:YES];
    [descriptionView setUserInteractionEnabled:YES];
    
    self.drugNameField.delegate = self;
    self.descriptionView.delegate = self;
    
    [descriptionView setText:@"Include notes on doseage, description etc"];
    [descriptionView setTextColor:[UIColor lightGrayColor]];
    
    
    self.refillArray = [[NSMutableArray alloc] init];
    [refillArray addObject:@"0"];
    [refillArray addObject:@"1"];
    [refillArray addObject:@"2"];
    [refillArray addObject:@"3"];
    [refillArray addObject:@"4"];
    [refillArray addObject:@"5"];
    
    NSLog(@"Refill Array:%@", refillArray);
    
    
    
    
    [refillPicker setDataSource: self];
    [refillPicker setDelegate: self];
    [refillPicker setFrame: CGRectMake(30, 50.0, 50, 200.0)];
    refillPicker.showsSelectionIndicator = YES;
    [refillPicker selectRow:2 inComponent:0 animated:YES];
    [self.view addSubview: refillPicker];
    
    
    self.numRefillButton.hidden = NO;
    self.doneButton.hidden = YES;
    self.refillPicker.hidden = YES;
    
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)distanceRadiusPicker numberOfRowsInComponent:(NSInteger)component {
    
    return self.refillArray.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [refillArray objectAtIndex: row];
}



- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (descriptionView.textColor == [UIColor lightGrayColor]) {
        descriptionView.text = @"";
        descriptionView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    
    self.descriptionView.frame = CGRectMake(self.descriptionView.frame.origin.x, (self.descriptionView.frame.origin.y - 50.0), self.descriptionView.frame.size.width, self.descriptionView.frame.size.height);
    
    [textView setFrame:CGRectMake(20, 70, 280, 120)];
    
    
    
    self.doneButton.hidden = NO;
    self.numRefillButton.hidden = YES;
    self.amountRefillLabel.hidden = YES;
    self.dateLabel.hidden = YES;
    self.drugNameField.hidden = YES;

    [UIView commitAnimations];
    
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    self.descriptionView.frame = CGRectMake(self.descriptionView.frame.origin.x, (self.descriptionView.frame.origin.y + 50.0), self.descriptionView.frame.size.width, self.descriptionView.frame.size.height);
    
    [textView setFrame:CGRectMake(20, 100, 280, 220)];
    
    
    self.doneButton.hidden = YES;
    self.numRefillButton.hidden = NO;
    self.amountRefillLabel.hidden = NO;
    self.dateLabel.hidden = NO;
    self.drugNameField.hidden = NO;
    
    [UIView commitAnimations];

    
}


- (void) textViewDidChange:(UITextView *)textView
{
    if(descriptionView.text.length == 0){
        descriptionView.textColor = [UIColor lightGrayColor];
        descriptionView.text = @"Include notes on doseage, description etc";
        [descriptionView resignFirstResponder];
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"QRImage: %@", self.QRImage);
    
    if ([segue.identifier isEqualToString:@"PrescQRSegue"]){
        
        NSLog(@"enter segue PrescQRSegue");
                
        self.drugName = self.drugNameField.text;
        self.description = self.descriptionView.text;
        
        self.description = [[self.description componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
        
        self.description = [self.description stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        self.description = [self.description stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceCharacterSet]];
        
        self.drugName = [self.drugName stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        NSLog(@"Display all fields to append:%@ %@ %@ %@ %@",self.patientID, self.doctorID, self.drugName, self.description, self.amountRefill);
        NSLog(@"Display Desc %@", self.description);
                
        self.addPrescURL = [[[[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id="
                                    stringByAppendingString: self.patientID] stringByAppendingString:@"&doctor_id="] stringByAppendingString:self.doctorID] stringByAppendingString:@"&drug=" ]  stringByAppendingString: self.drugName] stringByAppendingString:@"&note="] stringByAppendingString:self.description] stringByAppendingString:@"&refills="] stringByAppendingString:self.amountRefill];
        
        NSLog(@"display addPrescURL: %@", self.addPrescURL);
        
        NSData * data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.addPrescURL]];
        
        
        NSError* error;
        
        NSString *prescID = [[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectAtIndex:0] objectForKey:@"presc_id"];
        
        
        PrescQRViewController *destViewController = (PrescQRViewController*)segue.destinationViewController;
        
        
        destViewController.QRImage = self.QRImage;
        destViewController.prescID = prescID;
        destViewController.description = self.description;
        destViewController.justPresc = @"YES";
        
        
        NSLog(@"Make Presc success!!");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:[[@"Prescription for " stringByAppendingString:self.drugName ]
                                                                 stringByAppendingString:@" approved!" ]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        
        [alert show];
    }
        
        
}


- (IBAction)pressDone:(id)sender{
    [descriptionView resignFirstResponder];
}


- (IBAction)pressMakePresc:(id)sender;
{
    
    
//    //For now
//    self.doctorID = @"1";
//    //for now
//    
//    
//    self.drugNameField.delegate = self;
//    self.drugNameField.delegate = self;
//    
//    self.drugName = self.drugNameField.text;
//    self.description = self.descriptionView.text;
//    
//    
//    NSLog(@"display drug %@",self.drugName);
//    NSLog(@"Display Desc %@", self.description);
//    
//    
////http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=1&doctor_id=3&drug=advil&note=HELLO&refills=5
//
//    
//    
//    self.addPrescURL = [[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=" stringByAppendingString: self.userID] stringByAppendingString:@"&doctor_id="] stringByAppendingString:self.doctorID] stringByAppendingString:@"&drug=" ]  stringByAppendingString: self.drugName];
//    
//    NSLog(@"display addPrescURL: %@", self.addPrescURL);
//    
//   // NSError* error;
//    //NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.addPrescURL]];
//    
//    
//    self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.addPrescURL]]];
    
    
}


- (IBAction)pressNumRefill:(id)sender{

    
    
    NSLog(@"Num refills string:%@", self.numRefillButton.titleLabel.text);
    
    
    if ([self.numRefillButton.titleLabel.text isEqualToString: @"# of Refills:"]){
        
        
        NSLog(@"Num refills string is EQUAL");
        
        self.refillPicker.hidden = NO;
        self.numRefillButton.titleLabel.text = @"Select";
        [self.numRefillButton setTitle:@"Select" forState:UIControlStateNormal];
        [self.refillPicker selectRow:0 inComponent:0 animated:NO];
        [self.drugNameField resignFirstResponder];
        
    }
    
    else if ([self.numRefillButton.titleLabel.text isEqualToString: @"Select"]){
        
        self.refillPicker.hidden = YES;
        self.numRefillButton.titleLabel.text = @"# of Refills:";
        [self.numRefillButton setTitle:@"# of Refills:" forState:UIControlStateNormal];
        
    }
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    
    self.amountRefill = [self.refillArray objectAtIndex:row];
    //self.numRefillButton.titleLabel.text = [@"# of Refills " stringByAppendingString:[self.refillArray objectAtIndex:row]];
    NSLog(@"selected refill #:%@", self.amountRefill);
    
    self.amountRefillLabel.text = self.amountRefill;
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    
    if ([self.numRefillButton.titleLabel.text isEqualToString: @"# of Refills:"]){
        
        self.refillPicker.hidden = YES;
    }
    else if([self.numRefillButton.titleLabel.text isEqualToString: @"Select"])
            {
                
                self.numRefillButton.titleLabel.text = @"# of Refills:";
                [self.numRefillButton setTitle:@"# of Refills:" forState:UIControlStateNormal];
                self.amountRefillLabel.text = self.amountRefill;
                self.refillPicker.hidden = YES;

            }
    
    self.numRefillButton.titleLabel.text =  @"# of Refills";
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    
    return YES;
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
