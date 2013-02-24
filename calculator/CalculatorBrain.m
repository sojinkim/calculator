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

@property (nonatomic, strong) NSString *inputStringForOperand;
@property (nonatomic) double leftOperand;
@property (nonatomic) basicArithmeticOperator operatorType;
@property (nonatomic) double rightOperand;
@property (nonatomic) double calculationResult;
@property (nonatomic) double memoryStore;

@property (nonatomic) BrainState *state;
@property (nonatomic, strong) InitialState *initialState;
@property (nonatomic, strong) GettingOperatorState *operatorState;
@property (nonatomic, strong) GettingLeftOperandState *leftOperandState;
@property (nonatomic, strong) GettingRightOperandState *rightOperandState;

@end

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

@end
