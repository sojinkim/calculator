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
    brainState_self = -1, brainState_init, brainState_left, brainState_op, brainState_right
} brainState;

@interface BrainState : NSObject

- (brainState)whoAmI;
- (void)cleanBeforeLeave;

- (brainState)processDigit:(int)digit;
- (brainState)processOperator:(operatorType)op;
- (brainState)processEnter;
- (brainState)processSign;
- (brainState)processDecimal;
- (brainState)processMemRecall;

@end
