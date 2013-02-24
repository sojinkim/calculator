//
//  OperatorUtil.h
//  calculator
//
//  Created by Sojin Kim on 13. 1. 31..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    invalid = -1, add, sub, multiply, divide
} basicArithmeticOperator;

typedef enum {
    memRecall, memSub, memAdd, memClear
} memoryFunctionType;

@interface OperatorUtil : NSObject
+ (NSString *)stringValue:(basicArithmeticOperator)type;
@end
