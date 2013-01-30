//
//  CalculatorBrain.h
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrainState.h"

@interface CalculatorBrain : NSObject
// hold user input and math result
@property (nonatomic) double leftOperand;
@property (nonatomic) double rightOperand;
@property (nonatomic) int operatorString;
@property (nonatomic) double memoryStore;

@property (nonatomic) BOOL amITakingRightOperand; // ...

// hold brain states
@property (nonatomic) BrainState *state;
@property (nonatomic) InitialState *initialState;
@property (nonatomic) GettingOperatorState *gettingOperatorState;
@property (nonatomic) GettingLeftOperandState *gettingLeftOperandState;
@property (nonatomic) GettingRightOperandState *gettingRightOperandState;


- (void)initialize;

- (void)processDigit:(int)digit;
- (void)processOperator:(int)op;
- (void)processEnter;
- (void)processSign;

- (void)setState:(BrainState *)state;
- (double)performOperation;  // returns result


@end

