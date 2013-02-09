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

- (void)enterWith:(double)initValue causedBy:(int)input
{
}

- (void)leave
{
}

- (void)processDigit:(int)digit
{
    [self.brain stateTransitionTo:brainState_left withInitialValue:digit causedBy:inputType_digit];
}

- (void)processDecimal
{
    [self.brain stateTransitionTo:brainState_left withInitialValue:-1 causedBy:inputType_decimal];
}

- (void)processMemoryFunction:(int)func
{
    if (memRecall == func) {
        [self.brain stateTransitionTo:brainState_left withInitialValue:self.brain.memoryStore causedBy:inputType_operator];
    }
}

@end
