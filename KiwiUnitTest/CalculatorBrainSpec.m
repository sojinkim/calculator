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
            [[theValue([myBrain currentState]) should] equal:theValue(brainState_init)];
        });

        it(@"should fail", ^{
            id fake = nil;
            [fake shouldNotBeNil];
        });
    });
});


SPEC_END