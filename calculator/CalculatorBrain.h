//
//  CalculatorBrain.h
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 21..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrainState.h"
#import "OperatorUtil.h"

@interface CalculatorBrain : NSObject
@property (nonatomic) double memoryStore;
@property (nonatomic) NSString *inputString;

- (void)initialize;
- (void)dropCurrentCalculation;

- (void)processDigit:(int)digit;
- (void)processOperator:(int)op;
- (void)processMemory:(int)mem;
- (void)processEnter;
- (void)processSign;
- (void)processDecimal;

- (double)performOperation;  // returns result

- (operatorType)operatorString;
- (double)leftOperand;
- (double)rightOperand;
- (double)calculationResult;
- (brainState)currentState;
- (void)gotoTheState:(brainState)newState;

- (void)stateTransitionTo:(brainState)state withInitialValue:(double)value causedBy:(inputType)input;

@end
