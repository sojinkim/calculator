//
//  GettingLeftOperandState.h
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "BrainState.h"

@class CalculatorBrain;

@interface GettingLeftOperandState : BrainState
@property (nonatomic) double operand;

+ (GettingLeftOperandState *)brainStateOfBrain:(CalculatorBrain *)myBrain;
@end
