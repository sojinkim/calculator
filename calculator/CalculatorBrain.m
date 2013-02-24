//
//  CalculatorBrain.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain.h"
#import "CalculatorBrain_Private.h"

@implementation CalculatorBrain 

- (brainState)currentState
{
    return self.state.whoAmI;
}

- (BOOL)moveToNewState:(brainState)newState
{
    if ( (newState == brainState_self) || (newState == self.currentState) ) {
        return NO;
    }
    
    [self.state cleanBeforeLeave];
    switch (newState) {
        case brainState_init:
            self.state = self.initialState;
            break;
        case brainState_left:
            self.state = self.leftOperandState;
            break;
        case brainState_op:
            self.state = self.operatorState;
            break;
        case brainState_right:
            self.state = self.rightOperandState;
            break;
        default:
            NSAssert(NO, @"No such BrainState");
    }
    return YES;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.initialState = [InitialState brainStateOfBrain:self];
        self.operatorState = [GettingOperatorState brainStateOfBrain:self];
        self.leftOperandState = [GettingLeftOperandState brainStateOfBrain:self];
        self.rightOperandState = [GettingRightOperandState brainStateOfBrain:self];
        
        self.state = self.initialState;
        self.inputStringForOperand = @"0";
    }

    return self;
}

- (void)dropCurrentCalculation
{
    self.inputStringForOperand = @"0";
    self.leftOperand = self.rightOperand = 0;
    self.operatorType = invalid;
    self.calculationResult = 0;
    [self moveToNewState:brainState_init];
}

- (void)processDigit:(int)digit
{
    while ( [self moveToNewState:[self.state processDigit:digit]] );
}

- (void)processOperator:(int)op
{
    while ( [self moveToNewState:[self.state processOperator:op]] );
}

- (void)processMemoryFunction:(int)func withValue:(double)value;
{
    NSLog(@"memory button process : button tag %d, value %g", func, value);
    
    switch (func) {
        case memAdd:
            self.memoryStore += value;
            break;
        case memSub:
            self.memoryStore -= value;
            break;
        default:
            break;
    }
}

- (void)processMemClear
{
    self.memoryStore = 0;
}

- (void)processMemRecall
{
    while ( [self moveToNewState:[self.state processMemRecall]] );
}

- (void)processEnter
{
    while ( [self moveToNewState:[self.state processEnter]] );
}

- (void)processSign
{
    while ( [self moveToNewState:[self.state processSign]] );
}

- (void)processDecimal
{
    while ( [self moveToNewState:[self.state processDecimal]] );
}

- (double)performOperation
{
    if (add == self.operatorType) {
        self.calculationResult = self.leftOperand + self.rightOperand;
    } else if (sub == self.operatorType) {
        self.calculationResult = self.leftOperand - self.rightOperand;
    } else if (multiply == self.operatorType) {
        self.calculationResult = self.leftOperand * self.rightOperand;
    } else if (divide == self.operatorType) {
        self.calculationResult = self.leftOperand / self.rightOperand;
    } else {NSAssert(NO, @"not supported arithmetic operator"); }
    
    return self.calculationResult;
}

- (void)manipulateInputStringForSignChange
{
    NSRange range = {0 , 1};
    
    if ( [self.inputStringForOperand hasPrefix:@"-"] ) {
        self.inputStringForOperand = [self.inputStringForOperand stringByReplacingCharactersInRange:range withString:@""];
    }
    else {
        self.inputStringForOperand = [@"-" stringByAppendingString:self.inputStringForOperand];
    }
}

@end
