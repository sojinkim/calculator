//
//  BrainState.h
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrainState : NSObject
- (void)enterWith:(int)initValue;
- (void)leave;

// returns yes when state changes for no reason
- (BOOL)processDigit:(int)digit;
- (BOOL)processOperator:(int)op;
- (BOOL)processEnter;
- (BOOL)processSign;
- (BOOL)processDecimal;

- (BOOL)processMemoryFunction:(int)func;

@end
