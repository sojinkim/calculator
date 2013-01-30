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

@end
