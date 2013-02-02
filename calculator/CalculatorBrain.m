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

- (NSString *)inputString
{
    if (!_inputString) {
        _inputString = [[NSString alloc] init];
        NSLog(@"input string allocation");
    }
    return _inputString;
}

- (int)operatorString
{
    return self.gettingOperatorState.operatorString;
}

- (double)leftOperand
{
    return self.gettingLeftOperandState.operand;
}

- (double)rightOperand
{
    return self.gettingRightOperandState.operand;
}

- (void)setOperatorString:(int)op
{
    self.gettingOperatorState.operatorString = op;
}

- (void)setLeftOperand:(double)value
{
    self.gettingLeftOperandState.operand = value;
}

- (void)setRightOperand:(double)value
{
    self.gettingRightOperandState.operand = value;
}

- (void)initialize
{
    if (!self.state) {
        NSLog(@"brain states created");
        
        self.initialState = [InitialState brainStateOfBrain:self];
        self.gettingOperatorState = [GettingOperatorState brainStateOfBrain:self];
        self.gettingLeftOperandState = [GettingLeftOperandState brainStateOfBrain:self];
        self.gettingRightOperandState = [GettingRightOperandState brainStateOfBrain:self];
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
    
    self.inputString = nil;
}

- (void)processDigit:(int)digit
{
    [self.state processDigit:digit];
}

- (void)processOperator:(int)op
{
    if ([OperatorUtil isArithmeticOperator:op]) {
        [self.state processOperator:op];
    } else if (memClear == op) { // mc
        self.memoryStore = 0;
    } else {
        [self.state processMemoryFunction:op];       // mr, m-, m+
    }
}

- (void)processEnter
{
    [self.state processEnter];
}

- (void)processSign
{
    [self.state processSign];
}

- (void)processDecimal
{
    [self.state processDecimal];
}

- (double)performOperation
{
    if (add == self.operatorString) {
        self.leftOperand += self.rightOperand;
    } else if (sub == self.operatorString) {
        self.leftOperand -= self.rightOperand;
    } else if (multiply == self.operatorString) {
        self.leftOperand *= self.rightOperand;
    } else if (divide == self.operatorString) {
        self.leftOperand /= self.rightOperand;
    } else {NSAssert(NO, @"not supported arithmetic operator"); }

    
    return self.leftOperand;
}

@end
