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

- (void)enterWith:(double)initValue causedBy:(int)input
{
    if (inputType_decimal == input) {
        self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"0."];
    } else {
        self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%g", initValue];
    }
    self.operand = [self.brain.inputString doubleValue];
    
    NSLog(@"initial value = %g input string = %@ right operand = %g", initValue, self.brain.inputString, self.operand);
}

- (void)leave
{
    self.operand = 0;
    self.brain.inputString = nil;
    isDecimalPressed = NO;
    isSignPressed = NO;
}

- (void)processDigit:(int)digit
{
    self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    self.operand = [self.brain.inputString doubleValue];
    
    NSLog(@"input num = %d input string = %@ right operand = %g", digit, self.brain.inputString, self.operand);
}

- (void)processOperator:(int)op
{
    [self.brain performOperation];
    [self.brain stateTransitionTo:brainState_op withInitialValue:op causedBy:inputType_operator];
}

- (void)processEnter
{
    [self.brain stateTransitionTo:brainState_left withInitialValue:[self.brain performOperation] causedBy:inputType_enter];
}

- (void)processSign
{
    self.operand *= -1;
    isSignPressed = (isSignPressed ? NO : YES);
}

- (void)processDecimal
{
    if (!isDecimalPressed) {
        isDecimalPressed = YES;
        self.brain.inputString = [self.brain.inputString stringByAppendingString:@"."];
    }
}

- (void)processMemoryFunction:(int)func
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
}

@end
