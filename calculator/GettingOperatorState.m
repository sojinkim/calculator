//
//  GettingOperatorState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingOperatorState.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@interface GettingOperatorState()
@property (nonatomic, weak) CalculatorBrain *brain;
@end

@implementation GettingOperatorState

+ (GettingOperatorState *)brainStateOfBrain:(id)myBrain
{
    NSAssert([myBrain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    
    GettingOperatorState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (void)enterWith:(double)initValue causedBy:(int)input
{
    self.operatorString = (operatorType)initValue;
}

- (void)leave
{
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
