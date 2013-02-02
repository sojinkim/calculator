//
//  GettingRightOperandState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingRightOperandState.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@interface GettingRightOperandState() {
    BOOL isDecimalPressed;
    BOOL isSignPressed;
}
@property (nonatomic,weak) CalculatorBrain *brain;
@end

@implementation GettingRightOperandState

+ (GettingRightOperandState *)brainStateOfBrain:(id)myBrain
{
    NSAssert([myBrain isKindOfClass:[CalculatorBrain class]], @"this is not my brain");
    
    GettingRightOperandState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (BOOL)processDigit:(int)digit
{
    self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    self.operand = [self.brain.inputString doubleValue];
    
    NSLog(@"input num = %d input sring = %@ right operand = %g", digit, self.brain.inputString, self.operand);

    return NO;
}

- (BOOL)processOperator:(int)op
{
    [self.brain performOperation];
    self.operand = 0;
    self.brain.operatorString = op;
    self.brain.state = self.brain.gettingOperatorState;
    self.brain.amITakingRightOperand = NO;

    self.brain.inputString = nil;
    isDecimalPressed = NO;
    return YES;
}

- (BOOL)processEnter
{
    [self.brain performOperation];
    self.operand = 0;
    self.brain.operatorString = -1;
    self.brain.state = self.brain.gettingLeftOperandState;
    self.brain.amITakingRightOperand = NO;

    self.brain.inputString = nil;
    isDecimalPressed = NO;
    return YES;
}

- (BOOL)processSign
{
    self.operand *= -1;

    return NO;
}

- (BOOL)processDecimal
{
    if (!isDecimalPressed) {
        isDecimalPressed = YES;
        self.brain.inputString = [self.brain.inputString stringByAppendingString:@"."];
    }
    
    return NO;
}

- (BOOL)processMemoryFunction:(int)func
{
    if (memRecall == func) {
        self.operand = self.brain.memoryStore;
    } else if (memSub == func) {
        self.brain.memoryStore -= self.operand;
    } else if (memAdd == func) {
        self.brain.memoryStore += self.operand;
    } else {
        NSAssert(NO, @"not supported mem operator %d", func);
    }

    return NO;
}

@end
