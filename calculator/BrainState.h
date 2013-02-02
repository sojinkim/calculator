//
//  BrainState.h
//  mycalulator
//
//  Created by Sojin Kim on 13. 1. 23..
//  Copyright (c) 2013년 Sojin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrainState : NSObject

// returns yes when state changes for no reason
- (BOOL)processDigit:(id)brain:(int)digit;
- (BOOL)processOperator:(id)brain:(int)op;
- (BOOL)processEnter:(id)brain;
- (BOOL)processSign:(id)brain;
- (BOOL)processMemoryFunction:(id)brain:(int)func;

@end
