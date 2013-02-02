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

- (BOOL)processDigit:(int)digit
{
    //self.brain.rightOperand = digit;
    self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    self.brain.rightOperand = [self.brain.inputString doubleValue];
    NSLog(@"input num = %d input sring = %@ right operand = %g", digit, self.brain.inputString, self.brain.rightOperand);
    
    
    self.brain.state = self.brain.gettingRightOperandState;
    self.brain.amITakingRightOperand = YES;
    
    return YES;
}

- (BOOL)processOperator:(int)op
{
    self.operatorString = op; // overwrite

    return NO;
}

- (BOOL)processMemoryFunction:(int)func
{
    if (memRecall == func) {
        self.brain.rightOperand = self.brain.memoryStore;
    }

    self.brain.state = self.brain.gettingRightOperandState;
    self.brain.amITakingRightOperand = YES;

    return YES;
}

@end
