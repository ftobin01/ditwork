//
//  OOP1LabTestExampleTests.m
//  OOP1LabTestExampleTests
//
//  Created by Zachary Davison on 11/15/14.
//  Copyright (c) 2014 OO. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Example.h"

// This is the test file. In here will be all the tests you need to make pass.
// You can run tests by pressing Cmd + U or selecting Product > Test from the top menu.
// Each test may require you to create classes and methods to make them pass.
// Initially, they may not compile, since the necessary classes or methods may not exist
// (your first step should be to create all the necessary classes and methods so you can compile the tests)

// The "describe" block will contain the name of any class you need to create,
// and within it will be the necessary tests for that class.

// Click the diamond symbol in the left pane (where your files are)
// of XCode (5th from the left) to see individual test results.

// The tests will be more complex than the ones below,
// which are trivial examples of the format in order to not give too much away.

SPEC_BEGIN(ExampleSpec)

//
describe(@"Example", ^{
  
  it(@"add: should add two numbers together", ^{
    [[[Example add:@1 y:@2] should] equal:@3];
  });
  
  it(@"concatenate: should concatenate two strings", ^{
    [[[Example concatenate:@"Hello" y:@" World"] should] equal:@"Hello World"];
  });
  
});

SPEC_END