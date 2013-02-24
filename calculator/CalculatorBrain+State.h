//
//  CalculatorBrain+State.h
//  calculator
//
//  Created by Sojin Kim on 13. 2. 24..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain (State)

@property (nonatomic, strong) NSString *inputStringForOperand;
@property (nonatomic) double leftOperand;
@property (nonatomic) basicArithmeticOperator operatorType;
@property (nonatomic) double rightOperand;
@property (nonatomic) double calculationResult;
@property (nonatomic) double memoryStore;

- (double)performOperation;
- (void)manipulateInputStringForSignChange;

@end
