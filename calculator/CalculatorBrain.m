//
//  CalculatorBrain.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain.h"

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
    
    NSLog(@"brain emptied");
    self.leftOperand = self.rightOperand = self.memoryStore = 0;
    self.operatorString = -1;
    self.state = self.initialState;
}

- (void)processDigit:(int)digit
{
    [self.state processDigit:self:digit];
}

- (void)processOperator:(int)op
{
    if (op < 4)
        [self.state processOperator:self:op];
    
    else if (7 == op) // mc
            self.memoryStore = 0;
    else
            [self.state processMemoryFunction:self :op];  // 4, 5, 6, = mr, m-, m+
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
    if (0 == self.operatorString) // isEqualToString:@"+"
        self.leftOperand += self.rightOperand;
    
    else if (1 == self.operatorString) // isEqualToString:@"-"
        self.leftOperand -= self.rightOperand;
    
    else if (2 == self.operatorString) // isEqualToString:@"×"
        self.leftOperand *= self.rightOperand;
    
    else if (3 == self.operatorString) // isEqualToString:@"÷"
        self.leftOperand /= self.rightOperand;
    
    else NSAssert(NO, @"not supported arithmetic operator");
    
    return self.leftOperand;
}


@end



