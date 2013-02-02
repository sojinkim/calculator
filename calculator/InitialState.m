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

@implementation InitialState
- (BOOL)processDigit:(id)brain:(int)digit
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    realBrain.leftOperand = digit;
    realBrain.state = realBrain.gettingLeftOperandState;

    return YES;
}

- (BOOL)processMemoryFunction:(id)brain:(int)func
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    if (memRecall == func) {
        realBrain.leftOperand = realBrain.memoryStore;
        realBrain.state = realBrain.gettingLeftOperandState;
        return YES;
    } else {return NO; }
}

@end
