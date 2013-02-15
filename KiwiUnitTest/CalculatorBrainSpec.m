#import "CalculatorBrain.h"
#import "Kiwi.h"

SPEC_BEGIN(CalculatorBrainSpec)

describe(@"CalculatorBrainSpec", ^{
    context(@"brain is in initial state", ^{
        __block CalculatorBrain *myBrain = nil;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should ignore enter and stay in the initial state", ^{
           [myBrain processEnter];
           [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
           });
        
        it(@"should handle leading zeros correctly", ^{
            [myBrain processDigit:0];
            [myBrain processDigit:0];
            [myBrain processDigit:0];
            [myBrain processDigit:3];
            [myBrain processDigit:2];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"32")];
        });
        
        it(@"should handle the frist decimal correctly, ignore the second", ^{
            [myBrain processDecimal];
            [myBrain processDigit:0];
            [myBrain processDigit:0];
            [myBrain processDecimal];
            [myBrain processDigit:2];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"0.002")];
        });
        
        it(@"should handle sign correctly", ^{
            [myBrain processDigit:2];
            [myBrain processDigit:0];
            [myBrain processSign];
            [[theValue(myBrain.inputString) should] equal:theValue(@"-20")];
            [myBrain processDigit:0];
            [[theValue(myBrain.inputString) should] equal:theValue(@"-200")];
            [myBrain processDecimal];
            [myBrain processSign];
            [myBrain processDigit:2];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"200.2")];
        });
        
        it(@"should handle operator correctly", ^{
            [myBrain processOperator:0];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"0")];
            [[theValue(myBrain.operatorString) should] equal:theValue(add)];
            
            [myBrain processOperator:1];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"0")];
            [[theValue(myBrain.operatorString) should] equal:theValue(sub)];
            
            [myBrain processOperator:2];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"0")];
            [[theValue(myBrain.operatorString) should] equal:theValue(multiply)];
            
            [myBrain processOperator:3];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            [[theValue(myBrain.inputString) should] equal:theValue(@"1")];
            [[theValue(myBrain.operatorString) should] equal:theValue(divide)];            
        });

    });
});


SPEC_END