//
//  InitialState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "InitialState.h"
#import "CalculatorBrain.h"
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

- (void)enterWith:(double)initValue causedBy:(inputType)input
{
    self.calculationResult = initValue;
    if ( [OperatorUtil isArithmeticOperator:[OperatorUtil operatorTypeFromInputType:input]] ) {
        [self processOperator:[OperatorUtil operatorTypeFromInputType:input]];
    }
}

- (void)leave
{
}

- (brainState)whoAmI
{
    return brainState_init;
}

- (void)processOperator:(operatorType)op
{
    inputType input = [OperatorUtil inputTypeFromOperatorType:op];
    [self.brain stateTransitionTo:brainState_left withInitialValue:self.calculationResult causedBy:input];
    [self.brain stateTransitionTo:brainState_op withInitialValue:op causedBy:input];
}

- (void)processDigit:(int)digit
{
    [self.brain stateTransitionTo:brainState_left withInitialValue:digit causedBy:inputType_digit];
}

- (void)processSign
{
    [self.brain stateTransitionTo:brainState_left withInitialValue:(self.calculationResult*-1) causedBy:inputType_sign];
}

- (void)processDecimal
{
    [self.brain stateTransitionTo:brainState_left withInitialValue:-1 causedBy:inputType_decimal];
}

- (void)processMemoryFunction:(int)func
{
    if (memRecall == func) {
        [self.brain stateTransitionTo:brainState_left withInitialValue:self.brain.memoryStore causedBy:inputType_mem];
    } else if (memSub == func) {
        self.brain.memoryStore -= self.calculationResult;
    } else if (memAdd == func) {
        self.brain.memoryStore += self.calculationResult;
    } else {
        NSAssert(NO, @"not supported mem operator %d", func);
    }
}

@end
