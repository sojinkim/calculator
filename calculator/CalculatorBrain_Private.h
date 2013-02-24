//
//  CalculatorBrain_Private.h
//  calculator
//
//  Created by Sojin Kim on 13. 2. 24..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

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

- (double)performOperation;
- (void)manipulateInputStringForSignChange;

@end
