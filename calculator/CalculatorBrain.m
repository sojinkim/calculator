//
//  CalculatorBrain.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain.h"
#import "InitialState.h"
#import "GettingOperatorState.h"
#import "GettingLeftOperandState.h"
#import "GettingRightOperandState.h"

@interface CalculatorBrain () 

@property (nonatomic) BrainState *state;
@property (nonatomic, strong) InitialState *initialState;
@property (nonatomic, strong) GettingOperatorState *gettingOperatorState;
@property (nonatomic, strong) GettingLeftOperandState *gettingLeftOperandState;
@property (nonatomic, strong) GettingRightOperandState *gettingRightOperandState;

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
            self.state = self.gettingLeftOperandState;
            break;
        case brainState_op:
            self.state = self.gettingOperatorState;
            break;
        case brainState_right:
            self.state = self.gettingRightOperandState;
            break;
        default:
            NSAssert(NO, @"No such BrainState");
    }
    return YES;
}

- (void)initialize
{
    if (!self.state) {
        self.initialState = [InitialState brainStateOfBrain:self];
        self.gettingOperatorState = [GettingOperatorState brainStateOfBrain:self];
        self.gettingLeftOperandState = [GettingLeftOperandState brainStateOfBrain:self];
        self.gettingRightOperandState = [GettingRightOperandState brainStateOfBrain:self];
    }

    self.state = self.initialState;
    self.inputString = @"0";
}

- (void)dropCurrentCalculation
{
    self.inputString = @"0";
    self.leftOperand = self.rightOperand = 0;
    self.operatorString = invalid;
    self.calculationResult = 0;
    self.state = self.initialState;
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
    if (add == self.operatorString) {
        self.calculationResult = self.leftOperand + self.rightOperand;
    } else if (sub == self.operatorString) {
        self.calculationResult = self.leftOperand - self.rightOperand;
    } else if (multiply == self.operatorString) {
        self.calculationResult = self.leftOperand * self.rightOperand;
    } else if (divide == self.operatorString) {
        self.calculationResult = self.leftOperand / self.rightOperand;
    } else {NSAssert(NO, @"not supported arithmetic operator"); }
    
    return self.calculationResult;
}

- (void)manipulateInputStringForSignChange
{
    NSRange range = {0 , 1};
    
    if ( [self.inputString hasPrefix:@"-"] ) {
        self.inputString = [self.inputString stringByReplacingCharactersInRange:range withString:@""];
    }
    else {
        self.inputString = [@"-" stringByAppendingString:self.inputString];
    }
}


@end
