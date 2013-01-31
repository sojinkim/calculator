//
//  GettingLeftOperandState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingLeftOperandState.h"
#import "CalculatorBrain.h"


@implementation GettingLeftOperandState
- (BOOL)processDigit :(id)brain :(int)digit
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.leftOperand = realBrain.leftOperand*10 + digit;
    
    return NO;
}

- (BOOL)processOperator :(id)brain :(int)op
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.operatorString = op;
    realBrain.state = realBrain.gettingOperatorState;
    
    return YES;
}

- (BOOL)processSign:(id)brain
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.leftOperand *= -1;
    
    return NO;
}

- (BOOL)processMemoryFunction : (id)brain :(int)func
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    if (4 == func) // mr
        realBrain.leftOperand = realBrain.memoryStore;
    
    else if (5 == func) // 5, 6 =  m-, m+
        realBrain.memoryStore -= realBrain.leftOperand;
    
    else if (6 == func)
        realBrain.memoryStore += realBrain.leftOperand;
    
    else
        NSAssert(NO, @"not supported mem operator %d", func);
    
    return NO;
}
@end