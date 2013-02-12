//
//  GettingLeftOperandState.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "GettingLeftOperandState.h"
#import "CalculatorBrain.h"
#import "OperatorUtil.h"

@interface GettingLeftOperandState() {
BOOL isDecimalPressed;
BOOL isSignPressed;
BOOL shouldIAppendUserInput;
}
@property (nonatomic, weak) CalculatorBrain *brain;
@end

@implementation GettingLeftOperandState

+ (GettingLeftOperandState *)brainStateOfBrain:(CalculatorBrain *)myBrain
{
    GettingLeftOperandState *brainState = [[self alloc] init];
    brainState.brain = myBrain;
    return brainState;
}

- (void)enterWith:(double)initValue causedBy:(inputType)input
{
    if (inputType_decimal == input) {
        self.brain.inputString = @"0.";
        isDecimalPressed = YES;
    } else {
        self.brain.inputString = [NSString stringWithFormat:@"%g", initValue];
    }
    self.operand = [self.brain.inputString doubleValue];
}

- (void)leave
{
    self.brain.inputString = @"0";
    isDecimalPressed = NO;
    isSignPressed = NO;
}

- (brainState)whoAmI
{
    return brainState_left;
}

- (void)processDigit:(int)digit
{
    if ( [self.brain.inputString isEqualToString:@"0"] ) { // mr case
        self.brain.inputString = [NSString stringWithFormat:@"%d", digit];
    } else {
        self.brain.inputString = [self.brain.inputString stringByAppendingFormat:@"%d", digit];
    }
    self.operand = [self.brain.inputString doubleValue];
}

- (void)processOperator:(operatorType)op
{
    [self.brain stateTransitionTo:brainState_op withInitialValue:op causedBy:[OperatorUtil inputTypeFromOperatorType:op]];
}

- (void)processSign
{
    self.operand *= -1;
    isSignPressed = (self.operand < -1 ? YES : NO);
    
    if (isSignPressed) {
        self.brain.inputString = [NSString stringWithFormat:@"-%@",self.brain.inputString];
    } else {
        self.brain.inputString = [self.brain.inputString substringFromIndex:1];
    }
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
        self.brain.inputString = [NSString stringWithFormat:@"%g", self.operand];
        isDecimalPressed = NO;
    } else if (memSub == func) {
        self.brain.memoryStore -= self.operand;
    } else if (memAdd == func) {
        self.brain.memoryStore += self.operand;
    } else {
        NSAssert(NO, @"not supported mem operator %d", func);
    }
}

@end
