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

@interface OperatorUtil : NSObject

+ (BOOL)isArithmeticOperator:(operatorType)op;
+ (BOOL)isMemoryOperator:(operatorType)op;
+ (NSString *)stringValue:(operatorType)type;

@end
