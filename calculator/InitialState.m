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

+ (InitialState *)brainStateOfBrain:(id)myBrain
{
    NSAssert([myBrain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    
    InitialState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (BOOL)processDigit:(int)digit
{
    self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    self.brain.leftOperand = [self.brain.inputString doubleValue];
    
    NSLog(@"input num = %d input sring = %@ left operand = %g", digit, self.brain.inputString, self.brain.leftOperand);
    
    self.brain.state = self.brain.gettingLeftOperandState;

    return YES;
}

- (BOOL)processDecimal
{
    self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"0."];
    
    NSLog(@"input sring = %@ left operand = %g", self.brain.inputString, self.brain.leftOperand);
    
    self.brain.state = self.brain.gettingLeftOperandState;
    
    return YES;
}

- (BOOL)processMemoryFunction:(int)func
{
    if (memRecall == func) {
        self.brain.leftOperand = self.brain.memoryStore;
        self.brain.state = self.brain.gettingLeftOperandState;
        return YES;
    } else {return NO; }
}

@end
