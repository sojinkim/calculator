//
//  BrainState.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "BrainState.h"

@implementation BrainState

- (void)enterWith:(double)initValue causedBy:(inputType)input
{
    NSAssert(NO, @"please implement this");
}

- (void)leave
{
    NSAssert(NO, @"please implement this");
}

- (brainState)whoAmI
{
    NSAssert(NO, @"please implement this");
    return brainState_init;
}

- (void)processDigit:(int)digit
{
}

- (void)processOperator:(operatorType)op
{
}

- (void)processEnter
{
}

- (void)processSign
{
}

- (void)processDecimal
{
}

- (void)processMemoryFunction:(int)func
{
}

@end
