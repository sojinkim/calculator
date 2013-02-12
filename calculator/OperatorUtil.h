//
//  OperatorUtil.h
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    invalid = -1, add, sub, multiply, divide, memRecall, memSub, memAdd, memClear
} operatorType;

typedef enum {
    inputType_digit, inputType_operator_add, inputType_operator_sub, inputType_operator_mul, inputType_operator_div, inputType_enter, inputType_sign, inputType_decimal, inputType_clear, inputType_mem
} inputType;

@interface OperatorUtil : NSObject

+ (BOOL)isArithmeticOperator:(operatorType)op;
+ (BOOL)isMemoryOperator:(operatorType)op;
+ (NSString *)stringValue:(operatorType)type;
+ (inputType)inputTypeFromOperatorType:(operatorType)op;
+ (operatorType)operatorTypeFromInputType:(inputType)input;
@end
