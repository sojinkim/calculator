//
//  BrainState.h
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperatorUtil.h"

typedef enum {
    brainState_init, brainState_left, brainState_op, brainState_right
} brainState;

@interface BrainState : NSObject

- (void)enterWith:(double)initValue causedBy:(inputType)input;
- (void)leave;
- (brainState)whoAmI;

- (void)processDigit:(int)digit;
- (void)processOperator:(operatorType)op;
- (void)processEnter;
- (void)processSign;
- (void)processDecimal;

- (void)processMemoryFunction:(int)func;

@end
