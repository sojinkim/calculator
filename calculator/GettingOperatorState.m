//
//  GettingOperatorState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingOperatorState.h"
#import "CalculatorBrain.h"


@interface GettingOperatorState()
@property (nonatomic, weak) CalculatorBrain *brain;
@end

@implementation GettingOperatorState

+ (GettingOperatorState *)brainStateOfBrain:(CalculatorBrain *)myBrain
{
    GettingOperatorState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    brainState.operatorString = invalid;
    return brainState;
}

- (void)enterWith:(double)initValue causedBy:(inputType)input
{
    self.operatorString = (operatorType)initValue;
}

- (void)leave
{
}

- (brainState)whoAmI
{
    return brainState_op;
}

- (void)processDigit:(int)digit
{
    [self.brain stateTransitionTo:brainState_right withInitialValue:digit causedBy:inputType_digit];
}

- (void)processDecimal
{
    [self.brain stateTransitionTo:brainState_right withInitialValue:-1 causedBy:inputType_decimal];
}

- (void)processEnter
{
    [self.brain stateTransitionTo:brainState_init withInitialValue:[self.brain performOperation] causedBy:inputType_enter];
}

- (void)processOperator:(operatorType)op
{
    self.operatorString = op; // overwrite
}

- (void)processMemoryFunction:(int)func
{
    if (memRecall == func) {
        [self.brain stateTransitionTo:brainState_right withInitialValue:self.brain.memoryStore causedBy:inputType_mem];
    }
}

@end
