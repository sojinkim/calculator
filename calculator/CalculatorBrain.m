//
//  CalculatorBrain.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@interface CalculatorBrain ()

@end

@implementation CalculatorBrain

- (void)initialize
{
    if (!self.state) {
        NSLog(@"brain states created");
        self.initialState = [[InitialState alloc] init];
        self.gettingOperatorState = [[GettingOperatorState alloc] init];
        self.gettingLeftOperandState = [[GettingLeftOperandState alloc] init];
        self.gettingRightOperandState = [[GettingRightOperandState alloc] init];
    }
    
    NSLog(@"brain enters init state");
    self.operatorString = -1;
    self.state = self.initialState;
}

- (void)dropCurrentCalculation
{
    self.leftOperand = self.rightOperand = 0;
    self.operatorString = invalid;
    self.state = self.initialState;
}

- (void)processDigit:(int)digit
{
    [self.state processDigit:self:digit];
}

- (void)processOperator:(int)op
{
    if ( [OperatorUtil isArithmeticOperator:op] )
        [self.state processOperator:self:op];
    
    else if (memClear == op) // mc
            self.memoryStore = 0;
    else
            [self.state processMemoryFunction:self :op];  // mr, m-, m+
}

- (void)processEnter
{
    [self.state processEnter:self];
}

- (void)processSign
{
    [self.state processSign:self];
}

- (double)performOperation
{
    if (add == self.operatorString) 
        self.leftOperand += self.rightOperand;
    
    else if (sub == self.operatorString) 
        self.leftOperand -= self.rightOperand;
    
    else if (multiply == self.operatorString) 
        self.leftOperand *= self.rightOperand;
    
    else if (divide == self.operatorString) 
        self.leftOperand /= self.rightOperand;
    
    else NSAssert(NO, @"not supported arithmetic operator");
    
    return self.leftOperand;
}


@end



