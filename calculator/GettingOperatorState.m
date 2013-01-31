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


@implementation GettingOperatorState
- (BOOL)processDigit :(id)brain :(int)digit
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.rightOperand = digit;
    realBrain.state = realBrain.gettingRightOperandState;
    realBrain.amITakingRightOperand = YES;
    
    return YES;
}

- (BOOL)processOperator :(id)brain :(int)op
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.operatorString = op; // overwrite
    
    return NO;
}

- (BOOL)processMemoryFunction:(id)brain :(int)func
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    if (memRecall == func) 
        realBrain.rightOperand = realBrain.memoryStore;
    
    realBrain.state = realBrain.gettingRightOperandState;
    realBrain.amITakingRightOperand = YES;
    
    return YES;
}
@end