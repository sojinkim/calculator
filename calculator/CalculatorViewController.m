//
//  CalculatorViewController.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 29..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"
#import <QuartzCore/QuartzCore.h>

@interface CalculatorViewController ()

@property (nonatomic, weak) IBOutlet UIView *resultContainer;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *equationLabel;

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

@property (nonatomic, strong) CalculatorBrain *brain;

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

- (CalculatorBrain *)brain
{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
        [_brain initialize];
    }

    return _brain;
}

- (void)updateDisplay
{
    NSLog(@"state%d : result = %g, %g %@ %g, inputstring=%@", self.brain.currentState, self.brain.calculationResult, self.brain.leftOperand, [OperatorUtil stringValue:self.brain.operatorString], self.brain.rightOperand, self.brain.inputString);
    
    if (brainState_init == self.brain.currentState) {   // display result
        self.resultLabel.text = [NSString stringWithFormat:@"%g", self.brain.calculationResult];
    } else {   // or display user input
        self.resultLabel.text = self.brain.inputString;
    }
    
    // display equation
    if ((brainState_op == self.brain.currentState ) || (brainState_right == self.brain.currentState)) {
        self.equationLabel.text = [NSString stringWithFormat:@"%g %@ ", self.brain.leftOperand, [OperatorUtil stringValue:self.brain.operatorString]];
    }
    else {
        self.equationLabel.text = nil;
    }
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSLog(@"Button pressed:%@", sender.currentTitle);  
}

- (IBAction)digitPressed:(UIButton *)sender
{
    [self.brain processDigit:[sender tag]];
    [self updateDisplay];
}

- (IBAction)decimalPressed:(UIButton *)sender
{
    [self.brain processDecimal];
    [self updateDisplay];
}

- (IBAction)signPressed:(UIButton *)sender
{
    [self.brain processSign];
    [self updateDisplay];
}

- (IBAction)clearPressed:(UIButton *)sender
{
    [self.brain dropCurrentCalculation];
    [self updateDisplay];
}

- (IBAction)enterPressed:(UIButton *)sender
{
    [self.brain processEnter];
    [self updateDisplay];
}

- (IBAction)memRecallPressed:(UIButton *)sender {
    [self.brain processMemRecall];
    [self updateDisplay];
}

- (IBAction)memClearPressed:(UIButton *)sender {
    [self.brain processMemClear];
    [self.buttonMr setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)memoryFuntionPressed:(UIButton *)sender {
    [self.brain processMemoryFunction:[sender tag] withValue:[self.resultLabel.text doubleValue]];
    [self.buttonMr setBackgroundColor:[UIColor yellowColor]];
}

- (IBAction)operatorPressed:(UIButton *)sender
{
    [self.brain processOperator:[sender tag]];
    [self updateDisplay];
}

@end
