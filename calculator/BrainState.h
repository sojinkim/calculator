//
//  BrainState.h
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrainState : NSObject

- (void)enterWith:(double)initValue causedBy:(int)input;
- (void)leave;

- (void)processDigit:(int)digit;
- (void)processOperator:(int)op;
- (void)processEnter;
- (void)processSign;
- (void)processDecimal;

- (void)processMemoryFunction:(int)func;

@end
