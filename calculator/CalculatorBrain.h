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
- (void)processMemory:(int)mem;
- (void)processEnter;
- (void)processSign;
- (void)processDecimal;

- (double)performOperation;  // returns result
- (brainState)currentState;

@end
