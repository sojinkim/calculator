//
//  CalculatorBrain+State.m
//  calculator
//
//  Created by Sojin Kim on 13. 2. 24..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "CalculatorBrain+State.h"

@implementation CalculatorBrain (State)

@dynamic inputString;
@dynamic leftOperand;
@dynamic operatorString;
@dynamic rightOperand;
@dynamic calculationResult;
@dynamic memoryStore;

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

- (void)manipulateInputStringForSignChange
{
    NSRange range = {0 , 1};
    
    if ( [self.inputString hasPrefix:@"-"] ) {
        self.inputString = [self.inputString stringByReplacingCharactersInRange:range withString:@""];
    }
    else {
        self.inputString = [@"-" stringByAppendingString:self.inputString];
    }
}

@end
