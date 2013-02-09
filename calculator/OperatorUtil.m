//
//  OperatorUtil.m
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import "OperatorUtil.h"

@implementation OperatorUtil

+ (BOOL)isArithmeticOperator:(operatorType)op
{
    if ((op < 4) & (op >= 0)) {
        return YES;
    } else {return NO; }
}

+ (BOOL)isMemoryOperator:(operatorType)op
{
    if ((op >= 4) & (op < 8)) {
        return YES;
    } else {return NO; }
}

+ (NSString *)stringValue:(operatorType)type
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
