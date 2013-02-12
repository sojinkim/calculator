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

+ (inputType)inputTypeFromOperatorType:(operatorType)op
{
    inputType input = 0;
    switch (op) {
        case add:
            input = inputType_operator_add;
            break;
        case sub:
            input = inputType_operator_sub;
            break;
        case multiply:
            input = inputType_operator_mul;
            break;
        case divide:
            input = inputType_operator_div;
            break;
        default:
            NSAssert(NO, @"no such operator type");
            break;
    }
    return input;
}

+ (operatorType)operatorTypeFromInputType:(inputType)input;
{
    operatorType opType;
    switch (input) {
        case inputType_operator_add:
            opType = add;
            break;
        case inputType_operator_sub:
            opType = sub;
            break;
        case inputType_operator_mul:
            opType = multiply;
            break;
        case inputType_operator_div:
            opType = divide;
            break;
        default:
            opType = invalid;
            break;
    }
    return opType;
}

@end
