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

- (void)gotoTheState:(brainState)newState
{
    if ( newState == self.currentState ) {
        return;
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
    [self gotoTheState:brainState_init];
}

- (void)processDigit:(int)digit
{
    brainState newState = [self.state processDigit:digit];
    
    while (brainState_self != newState) {
        [self gotoTheState:newState];
        newState = [self.state processDigit:digit];
    }
}

- (void)processOperator:(int)op
{
    brainState newState = [self.state processOperator:op];

    while(brainState_self != newState) {
        [self gotoTheState:newState];
        newState = [self.state processOperator:op];
    }
}

- (void)processMemory:(int)mem
{
    if (memClear == mem) { // mc
        self.memoryStore = 0;
    } else {   // mr, m-, m+
    
    }
}

- (void)processEnter
{
    brainState newState = [self.state processEnter];
    
    while(brainState_self != newState) {
        [self gotoTheState:newState];
        newState = [self.state processEnter];
    }
}

- (void)processSign
{
    brainState newState = [self.state processSign];
    
    while(brainState_self != newState) {
        [self gotoTheState:newState];
        newState = [self.state processSign];
    }
}

- (void)processDecimal
{
    brainState newState = [self.state processDecimal];
    
    while (brainState_self != newState) {
        [self gotoTheState:newState];
        newState= [self.state processDecimal];
    }
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

@end
