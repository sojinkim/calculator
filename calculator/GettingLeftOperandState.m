//
//  GettingLeftOperandState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingLeftOperandState.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@interface GettingLeftOperandState() {
    BOOL isDecimalPressed;
}
@property (nonatomic, weak) CalculatorBrain *brain;
@end

@implementation GettingLeftOperandState

+ (GettingLeftOperandState *)brainStateOfBrain:(CalculatorBrain *)myBrain
{
    GettingLeftOperandState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (brainState)whoAmI
{
    return brainState_left;
}

- (brainState)processDigit:(int)digit
{
    if ( [self.brain.inputString isEqualToString:@"0"] ) { 
        self.brain.inputString = [NSString stringWithFormat:@"%d", digit];
    } else {
        self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    }
    
    self.brain.leftOperand = [self.brain.inputString doubleValue];
    
    return brainState_self;
}

- (brainState)processOperator:(operatorType)op
{
    [self cleanBeforeLeave];
    return brainState_op;
}

- (brainState)processSign
{
    self.brain.leftOperand *= -1;
    self.brain.inputString = [NSString stringWithFormat:@"%g", self.brain.leftOperand];
    
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
    self.brain.inputString = @"0";
    isDecimalPressed = NO;
}
@end
