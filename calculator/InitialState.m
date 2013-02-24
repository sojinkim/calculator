//
//  InitialState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "InitialState.h"
#import "CalculatorBrain.h"
#import "CalculatorBrain_Private.h"
#import "OperatorUtil.h"

@interface InitialState()
@property (nonatomic, weak) CalculatorBrain* brain;
@end

@implementation InitialState

+ (InitialState *)brainStateOfBrain:(CalculatorBrain *)myBrain
{
    InitialState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (brainState)whoAmI
{
    return brainState_init;
}

- (brainState)processOperator:(basicArithmeticOperator)op
{
    self.brain.leftOperand = self.brain.calculationResult;
    return brainState_left;
}

- (brainState)processDigit:(int)digit
{
    return brainState_left;
}

- (brainState)processSign
{
    self.brain.calculationResult = self.brain.calculationResult * (-1);
    return brainState_self;
}

- (brainState)processDecimal
{
    return brainState_left;
}

- (brainState)processMemRecall
{
    return brainState_left;
}

- (void)cleanBeforeLeave
{
    self.brain.calculationResult = 0;
}

@end
