//
//  GettingOperatorState.h
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "BrainState.h"
#import "OperatorUtil.h"

@class CalculatorBrain;

@interface GettingOperatorState : BrainState

+ (GettingOperatorState *)brainStateOfBrain:(CalculatorBrain *)myBrain;
@end
