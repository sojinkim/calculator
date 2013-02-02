//
//  BrainState.m
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "BrainState.h"
#import "CalculatorBrain.h"

@implementation BrainState

- (void)enterWith:(int)digit
{
    return;
}

- (void)leave
{
    return;
}

- (BOOL)processDigit:(int)digit
{
    return NO;
}

- (BOOL)processOperator:(int)op
{
    return NO;
}

- (BOOL)processEnter
{
    return NO;
}

- (BOOL)processSign
{
    return NO;
}

- (BOOL)processDecimal
{
    return NO;
}

- (BOOL)processMemoryFunction:(int)func
{
    return NO;
}

@end
