#import "CalculatorBrain.h"
#import "Kiwi.h"

SPEC_BEGIN(CalculatorBrainSpec)

describe(@"CalculatorBrainSpec", ^{
    context(@"Each test case start from initial state", ^{
        __block CalculatorBrain *myBrain = nil;

        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
        });

        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should remain in the init state", ^{
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemoryFunction:memAdd withValue:33];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemoryFunction:memSub withValue:33];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain dropCurrentCalculation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"should change state", ^{
            [myBrain processDecimal];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
        });
        
        it(@"should change state", ^{
            [myBrain processDigit:9];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
        });
        
        it(@"should change state", ^{
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
        });
        
        it(@"should change state", ^{
            [myBrain processMemRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
        });
        
        it(@"input stream : 0 0 0 . 1 1 . 1 + - . 3 . 4 sign sign sign enter", ^{
            
            [myBrain processDigit:0];
            [myBrain processDigit:0];
            [myBrain processDigit:0];
            [myBrain processDecimal];
            [myBrain processDigit:1];
            [myBrain processDigit:1];
            [myBrain processDecimal];
            [myBrain processDigit:1];
            [[theValue(myBrain.leftOperand) should] equal:theValue(0.111)];
            [[myBrain.inputString should] equal:@"0.111"];
            
            [myBrain processOperator:add];
            [myBrain processOperator:sub];
            [[theValue(myBrain.operatorString) should] equal:theValue(sub)];
            
            [myBrain processDecimal];
            [myBrain processDigit:3];
            [myBrain processDecimal];
            [myBrain processDigit:4];
            [myBrain processSign];
            [myBrain processSign];
            [myBrain processSign];
            [[theValue(myBrain.rightOperand) should] equal:theValue(-0.34)];
            [[myBrain.inputString should] equal:@"-0.34"];
            
            [myBrain processEnter];
            [[theValue(myBrain.calculationResult) should] equal:theValue(0.451)];
            [[theValue(myBrain.leftOperand) should] equal:theValue(0)];
            [[myBrain.inputString should] equal:@"0"];
            [[theValue(myBrain.operatorString) should] equal:theValue(invalid)];
            [[theValue(myBrain.rightOperand) should] equal:theValue(0)];
            [[myBrain.inputString should] equal:@"0"];
        });
        
        it(@"input stream : 9 + 3 - enter sign 4 enter", ^{
            
            [myBrain processDigit:9];
            [[theValue(myBrain.leftOperand) should] equal:theValue(9)];
            [[myBrain.inputString should] equal:@"9"];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.operatorString) should] equal:theValue(add)];
            
            [myBrain processDigit:3];
            [[theValue(myBrain.rightOperand) should] equal:theValue(3)];
            [[myBrain.inputString should] equal:@"3"];
            
            [myBrain processOperator:sub];
            [[theValue(myBrain.calculationResult) should] equal:theValue(0)];
            [[theValue(myBrain.leftOperand) should] equal:theValue(12)];
            [[theValue(myBrain.operatorString) should] equal:theValue(sub)];
            
            [myBrain processEnter];
            [[theValue(myBrain.calculationResult) should] equal:theValue(12)];
            
            [myBrain processSign];
            [[theValue(myBrain.calculationResult) should] equal:theValue(-12)];
            
            [myBrain processDigit:4];
            [[theValue(myBrain.leftOperand) should] equal:theValue(4)];
            [[myBrain.inputString should] equal:@"4"];
            
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
        });
        
        it(@"input stream : 9 memAdd clear 2 memRecall 3", ^{
            [myBrain processDigit:9];
            [myBrain processMemoryFunction:memAdd withValue:9];
            [myBrain dropCurrentCalculation];
            [myBrain processDigit:2];
            [myBrain processMemRecall];
            [[myBrain.inputString should] equal:@"9"];
            
            [myBrain processDigit:3];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            [[theValue(myBrain.leftOperand) should] equal:theValue(3)];
        });
        
        it(@"input stream : 9 memAdd + memRecall sign enter", ^{
            [myBrain processDigit:9];
            [myBrain processMemoryFunction:memAdd withValue:9];
            [myBrain processOperator:add];
            [myBrain processMemRecall];
            [myBrain processSign];
            [myBrain processEnter];
            
            [[theValue(myBrain.calculationResult) should] equal:theValue(0)];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"input stream : 9 . memRecall 3 . : memRecall should clear left operand decimal flag", ^{
            [myBrain processDigit:9];
            [myBrain processDecimal];
            [myBrain processMemRecall];
            [myBrain processDigit:3];
            [myBrain processDecimal];
            [[myBrain.inputString should] equal:@"3."];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
        });
        
        it(@"input stream : 3 + 9 . memRecall 3 . : memRecall should clear right operand decimal flag", ^{
            [myBrain processDigit:3];
            [myBrain processOperator:add];
            [myBrain processDigit:9];
            [myBrain processDecimal];
            [myBrain processMemRecall];
            [myBrain processDigit:3];
            [myBrain processDecimal];
            [[myBrain.inputString should] equal:@"3."];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
        });
    });
});

SPEC_END
