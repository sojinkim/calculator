//
//  OperatorUtil.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "OperatorUtil.h"

@implementation OperatorUtil

+ (NSString *)stringValue:(basicArithmeticOperator)type
{
    switch (type) {
        case add:
            return @"+";
        case sub:
            return @"-";
        case multiply:
            return @"x";
        case divide:
            return @"÷";
        default:
            return @"invalid";
    }
}

@end
