//
//  BrainState.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "BrainState.h"

@implementation BrainState

- (brainState)whoAmI
{
    NSAssert(NO, @"please implement this");
    return brainState_init;
}

- (void)cleanBeforeLeave
{
}

- (brainState)processDigit:(int)digit
{
    return brainState_self;
}

- (brainState)processOperator:(operatorType)op
{
    return brainState_self;
}

- (brainState)processEnter
{
    return brainState_self;
}

- (brainState)processSign
{
    return brainState_self;
}

- (brainState)processDecimal
{
    return brainState_self;
}

@end
