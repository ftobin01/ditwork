#import <Kiwi/Kiwi.h>
#import <UIKit/UIKit.h>
#import "ControlFlow.h"
#import "DataStructures.h"
#import "Protocols.h"
#import "EmptyProtocol.h"
#import "TestProtocol.h"
#import "Blocks.h"

// 1: Control Flow

SPEC_BEGIN(ControlFlowSpec)
describe(@"ControlFlow", ^{
  
  it(@"ifTest: should return the string 'Fizz' if x == true/YES, and 'Buzz' if x == false/NO", ^{
    [[[ControlFlow ifTest:YES] should]  equal:@"Fizz"];
    [[[ControlFlow ifTest:NO]  should]  equal:@"Buzz"];
  });
  
  it(@"forTest: should return an array of the numbers from x to x+10, eg: 5 should return 5,6,7,8...15", ^{
    [[[ControlFlow forTest:0] should] equal:@[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10]];
    [[[ControlFlow forTest:5] should] equal:@[@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15]];
    [[[ControlFlow forTest:7] should] equal:@[@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17]];
  });
  
  it(@"forInTest: should return a new array containing the value of each number in the array passed in plus 1", ^{
    [[[ControlFlow forInTest:@[@0,@1,@2]] should] equal:@[@1,@2,@3]];
    [[[ControlFlow forInTest:@[@4,@5,@6]] should] equal:@[@5,@6,@7]];
  });
  
  it(@"whileTest: should return how many times a number is divisible by 2", ^{
    [[theValue([ControlFlow whileTest:2])  should]  equal:theValue(1)];
    [[theValue([ControlFlow whileTest:8])  should]  equal:theValue(3)];
    [[theValue([ControlFlow whileTest:16]) should] equal:theValue(4)];
    [[theValue([ControlFlow whileTest:32]) should] equal:theValue(5)];
  });
});


SPEC_END

// 2: Data Structures

SPEC_BEGIN(DataStructuresSpec)

describe(@"DataStructures", ^{
  
  it(@"array: should return an empty array.", ^{
    [[[DataStructures array] should] equal:@[]];
  });
  
  it(@"dictionary: should return a dictionary with one key: 'A' and a value of an NSNumber '3'", ^{
    [[[DataStructures dictionary][@"A"] should] equal:@3];
  });
  
  it(@"set: should return a set containing one instance of an NSNumber '4'", ^{
    [[[DataStructures set] should] equal:[[NSSet alloc] initWithObjects:@4, nil]];
  });
  
});

SPEC_END

// 3: Protocols

SPEC_BEGIN(ProtocolSpec)

describe(@"Protocols", ^{
  
  it(@"implementsEmptyProtocol: should return an instance of a class that implements the 'EmptyProtocol' protocol", ^{
    [[theValue([[Protocols implementsEmptyProtocol] conformsToProtocol:@protocol(EmptyProtocol)]) should] equal:theValue(YES)];
  });
  
  it(@"conformsToTestProtocol: should return an instance of a class that conforms to the 'TestProtocol' protocol, including all methods.", ^{
    [[theValue([[Protocols conformsToTestProtocol] conformsToProtocol:@protocol(TestProtocol)]) should] equal:theValue(YES)];
  });
  
  it(@"conformsToTableViewDataSource: should return an instance of a class that conforms to 'UITableViewDataSource' (does not need to have functional methods!) ", ^{
    [[theValue([[Protocols conformsToTableViewDataSource] conformsToProtocol:@protocol(UITableViewDataSource)]) should] equal:theValue(YES)];
  });
  
});

SPEC_END

// 4: Blocks

SPEC_BEGIN(BlockSpec)

describe(@"Blocks", ^{
  
  it(@"invokeBlock: should accept a block as a parameter and call it.", ^{
    NSNumber __block *value = @0;
    [Blocks invokeBlock:^{
      value = @1;
    }];
    [[value should] equal:@1];
  });
  
  it(@"invokeParameterBlock: should accept a block as a parameter (that takes an NSInteger parameter) and call it.", ^{
    NSNumber __block *value = @0;
    [Blocks invokeParameterBlock:^(NSInteger parameter){
      value = @1;
    }];
    [[value should] equal:@1];
  });
  
  it(@"returnBlock: should return a block that when invoked returns an NSNumber '5'", ^{
    [[[Blocks returnBlock]() should] equal:@5];
  });
  
});

SPEC_END