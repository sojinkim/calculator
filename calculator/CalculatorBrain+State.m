//
//  CalculatorBrain+State.m
//  calculator
//
//  Created by Sojin Kim on 13. 2. 24..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain+State.h"

@implementation CalculatorBrain (State)

@dynamic inputStringForOperand;
@dynamic leftOperand;
@dynamic operatorType;
@dynamic rightOperand;
@dynamic calculationResult;
@dynamic memoryStore;

- (double)performOperation
{
    if (add == self.operatorType) {
        self.calculationResult = self.leftOperand + self.rightOperand;
    } else if (sub == self.operatorType) {
        self.calculationResult = self.leftOperand - self.rightOperand;
    } else if (multiply == self.operatorType) {
        self.calculationResult = self.leftOperand * self.rightOperand;
    } else if (divide == self.operatorType) {
        self.calculationResult = self.leftOperand / self.rightOperand;
    } else {NSAssert(NO, @"not supported arithmetic operator"); }
    
    return self.calculationResult;
}

- (void)manipulateInputStringForSignChange
{
    NSRange range = {0 , 1};
    
    if ( [self.inputStringForOperand hasPrefix:@"-"] ) {
        self.inputStringForOperand = [self.inputStringForOperand stringByReplacingCharactersInRange:range withString:@""];
    }
    else {
        self.inputStringForOperand = [@"-" stringByAppendingString:self.inputStringForOperand];
    }
}

@end
