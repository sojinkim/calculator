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
    BOOL isMemRecalled;
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
    if (isMemRecalled) {
        [self cancleMemRecall];
    }
    
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
    if (isMemRecalled) {
        [self pushMemRecallValueToOperand];
    }
    
    [self cleanBeforeLeave];
    return brainState_op;
}

- (brainState)processSign
{
    [self.brain manipulateInputStringForSignChange];

    if (!isMemRecalled) {
        self.brain.leftOperand = [self.brain.inputString doubleValue];
    }
    
    return brainState_self;
}

- (brainState)processDecimal
{
    if (isMemRecalled) {
        [self cancleMemRecall];
    }
    
    if (!isDecimalPressed) {
        isDecimalPressed = YES;
        self.brain.inputString = [self.brain.inputString stringByAppendingString:@"."];
    }
    
    return brainState_self;
}

- (brainState)processMemRecall
{
    isMemRecalled = YES;
    isDecimalPressed = NO;
    self.brain.inputString = [NSString stringWithFormat:@"%g", self.brain.memoryStore];
    return brainState_self;
}

- (void)cancleMemRecall
{
    isMemRecalled = NO;
    self.brain.inputString = @"0";
}

- (void)pushMemRecallValueToOperand
{
    self.brain.leftOperand = [self.brain.inputString doubleValue];
}

- (void)cleanBeforeLeave
{
    self.brain.inputString = @"0";
    isDecimalPressed = NO;
    isMemRecalled = NO;
}
@end
