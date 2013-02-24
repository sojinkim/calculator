//
//  GettingOperatorState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingOperatorState.h"
#import "CalculatorBrain+State.h"


@interface GettingOperatorState()
@property (nonatomic, weak) CalculatorBrain *brain;
@end

@implementation GettingOperatorState

+ (GettingOperatorState *)brainStateOfBrain:(CalculatorBrain *)myBrain
{
    GettingOperatorState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    brainState.brain.operatorType = invalid;
    return brainState;
}

- (brainState)whoAmI
{
    return brainState_op;
}

- (brainState)processDigit:(int)digit
{
    return brainState_right;
}

- (brainState)processDecimal
{
    return brainState_right;
}

- (brainState)processEnter
{
    NSAssert( invalid != self.brain.operatorType , @"operator should not be invliad" );
    
    [self.brain performOperation];
    return brainState_right;
}

- (brainState)processMemRecall
{
    return brainState_right;
}

- (brainState)processOperator:(basicArithmeticOperator)op
{
    self.brain.operatorType = op;
    return brainState_self;
}


@end
