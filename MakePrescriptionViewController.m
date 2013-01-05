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

@synthesize userID;
@synthesize doctorID;

@synthesize addPrescURL;
@synthesize QRImage;
@synthesize refillPicker;
@synthesize refillArray;

@synthesize numRefillButton;

@synthesize amountRefill;

- (void)viewDidLoad
{
    
    //For now
    self.doctorID = @"1";
    //for now
    
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
    
    
    [refillPicker setDataSource: self];
    [refillPicker setDelegate: self];
    [refillPicker setFrame: CGRectMake(30, 50.0, 50, 200.0)];
    refillPicker.showsSelectionIndicator = YES;
    [refillPicker selectRow:2 inComponent:0 animated:YES];
    [self.view addSubview: refillPicker];
    
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
    
    self.descriptionView.frame = CGRectMake(self.descriptionView.frame.origin.x, (self.descriptionView.frame.origin.y - 130.0), self.descriptionView.frame.size.width, self.descriptionView.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    self.descriptionView.frame = CGRectMake(self.descriptionView.frame.origin.x, (self.descriptionView.frame.origin.y + 130.0), self.descriptionView.frame.size.width, self.descriptionView.frame.size.height);
    
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
        
        
        
        self.drugName = self.drugNameField.text;
        self.description = self.descriptionView.text;
        
        
        NSLog(@"display drug %@",self.drugName);
        NSLog(@"Display Desc %@", self.description);
        
        
        //http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=1&doctor_id=3&drug=advil&note=HELLO&refills=5
        
        
        
        self.addPrescURL = [[[[[[[@"http://default-environment-ntmkc2r9ez.elasticbeanstalk.com/ProjectZero-server/index.php/QRCodeGen/addPresc/?user_id=" stringByAppendingString: self.userID] stringByAppendingString:@"&doctor_id="] stringByAppendingString:self.doctorID] stringByAppendingString:@"&drug=" ]  stringByAppendingString: self.drugName] stringByAppendingString:@"&note="] stringByAppendingString:self.description];
        
        NSLog(@"display addPrescURL: %@", self.addPrescURL);
        
        // NSError* error;
        //NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.addPrescURL]];
        
        
        //self.QRImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.addPrescURL]]];

        
        
        
        
        PrescQRViewController *destViewController = (PrescQRViewController*)segue.destinationViewController;
        //destViewController.QRImage = self.QRImage;
        
        destViewController.drugName = self.drugName;
        destViewController.imageURL = self.addPrescURL;
        destViewController.description = self.description;
        
        
        NSLog(@"QRImage: %@", self.QRImage);
        
        
    }
        
        
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
    
    
    if ([self.numRefillButton.titleLabel.text isEqualToString: @"# of Refills"]){
        
        
        NSLog(@"Num refills string is EQUAL");
        
        self.refillPicker.hidden = NO;
        self.numRefillButton.titleLabel.text = @"Select";
        [self.numRefillButton setTitle:@"Select" forState:UIControlStateNormal];
        
    }
    
    else if ([self.numRefillButton.titleLabel.text isEqualToString: @"Select"]){
        
        self.refillPicker.hidden = YES;
        self.numRefillButton.titleLabel.text = @"# of Refills";
        [self.numRefillButton setTitle:@"# of Refills" forState:UIControlStateNormal];
        
    }
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    
    self.amountRefill = [self.refillArray objectAtIndex:row];
    
    NSLog(@"selected refill #:%@", self.amountRefill);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Touch outside of box
    self.refillPicker.hidden = YES;
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