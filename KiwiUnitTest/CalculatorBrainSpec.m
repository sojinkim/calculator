#import "CalculatorBrain.h"
#import "Kiwi.h"

SPEC_BEGIN(CalculatorBrainSpec)

describe(@"CalculatorBrainSpec : state transition verification", ^{
    context(@"brain is in initial state", ^{
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
            
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain dropCurrentCalculation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain performOperation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"should change state", ^{
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
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
    });
});

describe(@"CalculatorBrainSpec : state transition verification", ^{
    context(@"brain is in left state", ^{
        __block CalculatorBrain *myBrain = nil;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            [myBrain gotoTheState:brainState_left];
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should remain in the left state", ^{
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processDecimal];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processDigit:9];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
        });
        
        it(@"should change state", ^{
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
        });
        
        it(@"should change state", ^{
            [myBrain dropCurrentCalculation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"should change state", ^{
            [myBrain performOperation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });        
    });
});

describe(@"CalculatorBrainSpec : state transition verification", ^{    
    context(@"brain is in operator state", ^{
        __block CalculatorBrain *myBrain = nil;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            [myBrain gotoTheState:brainState_op];
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should remain in the operator state", ^{            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
        });
        
        it(@"should change state", ^{
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"should change state", ^{
            [myBrain processDecimal];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
        });
        
        it(@"should change state", ^{
            [myBrain processDigit:9];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
        });
        
        it(@"should change state", ^{
            [myBrain dropCurrentCalculation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"should change state", ^{
            [myBrain performOperation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });        
    });
});

describe(@"CalculatorBrainSpec : state transition verification", ^{
    context(@"brain is in right state", ^{
        __block CalculatorBrain *myBrain = nil;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            [myBrain gotoTheState:brainState_right];
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should remain in the right state", ^{
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processDecimal];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processDigit:9];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
        });
        
        it(@"should change state", ^{
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
        });
        
        it(@"should change state", ^{
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];

        });
        
        it(@"should change state", ^{
            [myBrain dropCurrentCalculation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
        
        it(@"should change state", ^{
            [myBrain performOperation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });        
    });
});

/////// above, should pass (of course not yet ㅋㅋ


/////// below, need to inspect properly. just copy and paste'd

describe(@"CalculatorBrain : verify input value handling which does not invlove state transition by inspecting propery values", ^{
    context(@"brain is in initial state", ^{
        __block CalculatorBrain *myBrain = nil;
        __block double memoryStore;
        __block NSString *inputString;
        __block operatorType operatorString;
        __block double leftOperand;
        __block double rightOperand;
        __block double calculationResult;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            memoryStore = myBrain.memoryStore;
            inputString = myBrain.inputString;
            operatorString = myBrain.operatorString;
            leftOperand = myBrain.leftOperand;
            rightOperand = myBrain.rightOperand;
            calculationResult = myBrain.calculationResult;            
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should handle", ^{
            
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain dropCurrentCalculation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
            
            [myBrain performOperation];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_init)];
        });
    });
});

describe(@"CalculatorBrain : verify input value handling which does not invlove state transition by inspecting propery values", ^{
    context(@"brain is in left state", ^{
        __block CalculatorBrain *myBrain = nil;
        __block double memoryStore;
        __block NSString *inputString;
        __block operatorType operatorString;
        __block double leftOperand;
        __block double rightOperand;
        __block double calculationResult;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            [myBrain gotoTheState:brainState_left];
            [myBrain initialize];
            memoryStore = myBrain.memoryStore;
            inputString = myBrain.inputString;
            operatorString = myBrain.operatorString;
            leftOperand = myBrain.leftOperand;
            rightOperand = myBrain.rightOperand;
            calculationResult = myBrain.calculationResult;
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should handle", ^{
            [myBrain processEnter];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processDecimal];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
            [myBrain processDigit:9];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_left)];
            
        });
    });
    
});

describe(@"CalculatorBrain : verify input value handling which does not invlove state transition by inspecting propery values", ^{
    context(@"brain is in op state", ^{
        __block CalculatorBrain *myBrain = nil;
        __block double memoryStore;
        __block NSString *inputString;
        __block operatorType operatorString;
        __block double leftOperand;
        __block double rightOperand;
        __block double calculationResult;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            [myBrain gotoTheState:brainState_op];
            [myBrain initialize];
            memoryStore = myBrain.memoryStore;
            inputString = myBrain.inputString;
            operatorString = myBrain.operatorString;
            leftOperand = myBrain.leftOperand;
            rightOperand = myBrain.rightOperand;
            calculationResult = myBrain.calculationResult;
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should handle", ^{
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processOperator:add];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_op)];
            
        });
    });
});

describe(@"CalculatorBrain : verify input value handling which does not invlove state transition by inspecting propery values", ^{
    
    context(@"brain is in right state", ^{
        __block CalculatorBrain *myBrain = nil;
        __block double memoryStore;
        __block NSString *inputString;
        __block operatorType operatorString;
        __block double leftOperand;
        __block double rightOperand;
        __block double calculationResult;
        
        beforeEach(^{
            myBrain = [[CalculatorBrain alloc] init];
            [myBrain initialize];
            [myBrain gotoTheState:brainState_right];
            [myBrain initialize];
            memoryStore = myBrain.memoryStore;
            inputString = myBrain.inputString;
            operatorString = myBrain.operatorString;
            leftOperand = myBrain.leftOperand;
            rightOperand = myBrain.rightOperand;
            calculationResult = myBrain.calculationResult;
        });
        
        afterEach(^{
            myBrain = nil;
        });
        
        it(@"should handle", ^{
            [myBrain processMemory:memClear];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processMemory:memAdd];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processMemory:memSub];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processMemory:memRecall];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processSign];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processDecimal];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
            [myBrain processDigit:9];
            [[theValue(myBrain.currentState) should] equal:theValue(brainState_right)];
            
        });
    });
});

SPEC_END
