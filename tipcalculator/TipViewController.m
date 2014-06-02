//
//  TipViewController.m
//  tipcalculator
//
//  Created by Matt Mitchell on 5/27/14.
//  Copyright (c) 2014 Matt Mitchell. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIStepper *splitStepper;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender
{
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues
{
    NSArray *tipValues = @[@(0.10), @(0.15), @(0.20)];
    
    float billAmount = [self.billTextField.text floatValue];
    float tipPercentage = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float tipAmount = billAmount * tipPercentage;
    float totalAmount = tipAmount + billAmount;
    float splitAmount = totalAmount / self.splitStepper.value;
    
    self.tipPercentageLabel.text = [NSString stringWithFormat:@"(%0.0f%%)", (tipPercentage * 100)];
    self.billTextField.text = [NSString stringWithFormat:@"%0.2f", billAmount];
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.splitLabel.text = [NSString stringWithFormat:@"%i", (int)self.splitStepper.value];
    self.splitTotalLabel.text = [NSString stringWithFormat:@"$%0.2f", splitAmount];
    
    if (billAmount < 0.01) {
        self.billTextField.text = @"";
    }
    
    if (self.splitStepper.value == 1) {
        self.splitTotalLabel.alpha = 0;
        self.splitTitleLabel.alpha = 0;
    } else {
        self.splitTotalLabel.alpha = 1;
        self.splitTitleLabel.alpha = 1;
    }
    
}

@end
