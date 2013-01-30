//
//  CalculatorViewController.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 29..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CalculatorViewController ()

@property (nonatomic, weak) IBOutlet UIView *resultContainer;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

@property (nonatomic, weak) IBOutlet UIButton *buttonMc;
@property (nonatomic, weak) IBOutlet UIButton *buttonMplus;
@property (nonatomic, weak) IBOutlet UIButton *buttonMminus;
@property (nonatomic, weak) IBOutlet UIButton *buttonMr;
@property (nonatomic, weak) IBOutlet UIButton *buttonC;
@property (nonatomic, weak) IBOutlet UIButton *buttonSign;
@property (nonatomic, weak) IBOutlet UIButton *buttonDivide;
@property (nonatomic, weak) IBOutlet UIButton *buttonMultiply;
@property (nonatomic, weak) IBOutlet UIButton *buttonSubtract;
@property (nonatomic, weak) IBOutlet UIButton *buttonAdd;
@property (nonatomic, weak) IBOutlet UIButton *buttonEquals;
@property (nonatomic, weak) IBOutlet UIButton *buttonDecimal;
@property (nonatomic, weak) IBOutlet UIButton *button0;
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIButton *button3;
@property (nonatomic, weak) IBOutlet UIButton *button4;
@property (nonatomic, weak) IBOutlet UIButton *button5;
@property (nonatomic, weak) IBOutlet UIButton *button6;
@property (nonatomic, weak) IBOutlet UIButton *button7;
@property (nonatomic, weak) IBOutlet UIButton *button8;
@property (nonatomic, weak) IBOutlet UIButton *button9;

@end

@implementation CalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pattern - Gingham.png"]];

    CALayer *layer = self.resultContainer.layer;
    layer.borderWidth = 2.0f;
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.cornerRadius = 6.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    NSLog(@"Button pressed:%@", ((UIButton *)sender).currentTitle);
}

@end
