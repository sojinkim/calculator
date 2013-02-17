//
//  GettingRightOperandState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingRightOperandState.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@interface GettingRightOperandState() {
    BOOL isDecimalPressed;
}
@property (nonatomic,weak) CalculatorBrain *brain;
@end

@implementation GettingRightOperandState

+ (GettingRightOperandState *)brainStateOfBrain:(CalculatorBrain *)myBrain
{
    GettingRightOperandState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (brainState)whoAmI
{
    return brainState_right;
}

- (brainState)processDigit:(int)digit
{
    if ( [self.brain.inputString isEqualToString:@"0"] ) {  
        self.brain.inputString = [NSString stringWithFormat:@"%d", digit];
    } else {
        self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    }
    self.brain.rightOperand = [self.brain.inputString doubleValue];
    
    return brainState_self;
}

- (brainState)processOperator:(operatorType)op
{
    [self.brain performOperation];
    return brainState_init;
}

- (brainState)processEnter
{
    [self.brain performOperation];
    return brainState_init;
}

- (brainState)processSign
{
    self.brain.rightOperand *= -1;
    self.brain.inputString = [NSString stringWithFormat:@"%g", self.brain.rightOperand];
    
    return brainState_self;
}

- (brainState)processDecimal
{
    if (!isDecimalPressed) {
        isDecimalPressed = YES;
        self.brain.inputString = [self.brain.inputString stringByAppendingString:@"."];
    }
    return brainState_self;
}

- (void)cleanBeforeLeave
{
    self.brain.rightOperand = 0;
    self.brain.leftOperand = 0;
    self.brain.operatorString = invalid;
    self.brain.inputString = @"0";
    
    isDecimalPressed = NO;
}

@end
