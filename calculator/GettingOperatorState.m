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

- (void)enterWith:(double)initValue causedBy:(int)input
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

- (void)processOperator:(int)op
{
    self.operatorString = op; // overwrite
}

- (void)processMemoryFunction:(int)func
{
    if (memRecall == func) {
            [self.brain stateTransitionTo:brainState_right withInitialValue:self.brain.memoryStore causedBy:inputType_operator];
    }
}

@end
