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

@property (nonatomic, strong) NSString *inputString;
@property (nonatomic) double leftOperand;
@property (nonatomic) operatorType operatorString;
@property (nonatomic) double rightOperand;
@property (nonatomic) double calculationResult;
@property (nonatomic) double memoryStore;


- (void)initialize;
- (void)dropCurrentCalculation;

- (void)processDigit:(int)digit;
- (void)processOperator:(int)op;
- (void)processMemoryFunction:(int)func withValue:(double)value;
- (void)processMemClear;
- (void)processMemRecall;
- (void)processEnter;
- (void)processSign;
- (void)processDecimal;

- (brainState)currentState;

- (double)performOperation;  
- (void)manipulateInputStringForSignChange;

@end
