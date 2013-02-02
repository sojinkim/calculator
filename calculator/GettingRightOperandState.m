//
//  GettingRightOperandState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingRightOperandState.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@implementation GettingRightOperandState
- (BOOL)processDigit:(id)brain:(int)digit
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    realBrain.rightOperand = realBrain.rightOperand * 10 + digit;

    return NO;
}

- (BOOL)processOperator:(id)brain:(int)op
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    [realBrain performOperation];
    realBrain.rightOperand = 0;
    realBrain.operatorString = op;
    realBrain.state = realBrain.gettingOperatorState;
    realBrain.amITakingRightOperand = NO;

    return YES;
}

- (BOOL)processEnter:(id)brain
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    [realBrain performOperation];
    realBrain.rightOperand = 0;
    realBrain.operatorString = -1;
    realBrain.state = realBrain.gettingLeftOperandState;
    realBrain.amITakingRightOperand = NO;

    return YES;
}

- (BOOL)processSign:(id)brain
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    realBrain.rightOperand *= -1;

    return NO;
}

- (BOOL)processMemoryFunction:(id)brain:(int)func
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;

    if (memRecall == func) {
        realBrain.rightOperand = realBrain.memoryStore;
    } else if (memSub == func) {
        realBrain.memoryStore -= realBrain.rightOperand;
    } else if (memAdd == func) {
        realBrain.memoryStore += realBrain.rightOperand;
    } else {
        NSAssert(NO, @"not supported mem operator %d", func);
    }

    return NO;
}

@end
