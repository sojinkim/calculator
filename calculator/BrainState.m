//
//  BrainState.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "BrainState.h"
#import "CalculatorBrain.h"

@implementation BrainState
- (BOOL)processDigit :(id)brain :(int)digit {return NO;}
- (BOOL)processOperator :(id)brain :(int)op {return NO;}
- (BOOL)processEnter:(id)brain {return NO;}
- (BOOL)processSign:(id)brain {return NO;}
- (BOOL)processMemoryFunction : (id)brain :(int)func {return NO;}
@end


@implementation InitialState
- (BOOL)processDigit :(id)brain :(int)digit
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.leftOperand = digit;
    realBrain.state = realBrain.gettingLeftOperandState;

    return YES;
}

- (BOOL)processMemoryFunction : (id)brain :(int)func
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    if (4 == func) // mr
        realBrain.leftOperand = realBrain.memoryStore;

    return YES;
}
@end


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
@end


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


@implementation GettingRightOperandState
- (BOOL)processDigit :(id)brain :(int)digit
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    realBrain.rightOperand = realBrain.rightOperand*10 + digit;
    
    return NO;
}

- (BOOL)processOperator :(id)brain :(int)op
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain*)brain;
    
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

- (BOOL)processMemoryFunction : (id)brain :(int)func
{
    NSAssert([brain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    CalculatorBrain *realBrain = (CalculatorBrain *)brain;
    
    
    if (4 == func) // mr
        realBrain.rightOperand = realBrain.memoryStore;
    
    else if (5 == func) // m-
        realBrain.memoryStore -= realBrain.rightOperand;
    
    else if (6 == func) // m+
        realBrain.memoryStore += realBrain.rightOperand;
    
    else
        NSAssert(NO, @"not supported mem operator %d", func);
    
    return NO;
}
@end

