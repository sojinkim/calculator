//
//  CalculatorBrain.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain.h"
#import "OperatorUtil.h"
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

- (brainState)currentState
{
    return self.state.whoAmI;
}

- (void)stateTransitionTo:(brainState)state withInitialValue:(double)value causedBy:(inputType)input
{
    [self.state leave];
    
    switch (state) {
        case brainState_init:
            self.gettingLeftOperandState.operand = 0;
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
    
    [self.state enterWith:value causedBy:input];
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
    self.state = self.initialState;
}

- (void)dropCurrentCalculation
{
    [self stateTransitionTo:brainState_init withInitialValue:0 causedBy:inputType_clear];
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
    double result = 0;
    
    if (add == self.operatorString) {
        result = self.leftOperand + self.rightOperand;
    } else if (sub == self.operatorString) {
        result = self.leftOperand - self.rightOperand;
    } else if (multiply == self.operatorString) {
        result = self.leftOperand * self.rightOperand;
    } else if (divide == self.operatorString) {
        result = self.leftOperand / self.rightOperand;
    } else {NSAssert(NO, @"not supported arithmetic operator"); }
    
    return result;
}

@end
