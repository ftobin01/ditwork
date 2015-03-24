OOP1.5
====================

Overview
--------------------

This class discusses the concepts of **automated testing** and **Test Driven Development**.

Testing
--------------------

Computer programs are large webs of operations that at some point reach a point where their complexity is difficult to maintain and upgrade without introducing bugs. When your program does hundreds or thousands of different things, it's possible to make changes in one area and cause bugs in another without noticing (ideally, this wouldn't happen due to good seperation of concerns, but it does).

What can we do about this? Well, we can test everything. Our first inclination might be to test the program manually, which works to a degree, but humans make mistakes, and this is also a very slow process (imagine manually testing every feature in Microsoft Office everytime you made a change!).

So what can we do? Well, we can write automated tests, which are small programs that will execute functions in our app automatically and ensure the result is what we expect. There are many different forms of automated test, but the type we will primarily be concerned with are **unit tests**.

Unit Testing With `Kiwi`
--------------------

XCode does ship with a capable unit testing framework called **XCTest** (see [here](http://www.preeminent.org/steve/iOSTutorials/XCTest/) for a tutorial if you're curious), but it has some limitations, is a little clunky in syntax, and is generally not used, so we will be using a common third party framework called `Kiwi`.

Kiwi is a **Behaviour Driven Development** framework, and this style of testing is common in many languages, the idea being that we define how we would like things to behave through tests, then we make the tests pass. This is a form of **Test Driven Development** (TDD).

```obj-c
describe(@"Team", ^{
    context(@"when newly created", ^{
        it(@"should have a name", ^{
            id team = [Team team];
            [[team.name should] equal:@"Black Hawks"];
        });

        it(@"should have 11 players", ^{
            id team = [Team team];
            [[[team should] have:11] players];
        });
    });
});
```

Above is an example test in `Kiwi`. The syntax may look strange, but if you recall it is just nested **blocks**. The general structure of a test is as follows:

- `describe` is the entity or class we are testing (eg: `Team`).
- `context` is the state the entity should be in before the following set of tests.
- each `it` block is a test.

The strings passed to the blocks are plain English descriptions of the test. You might notice if you ignore lots of the syntactical characters, this is quite readable. The *matchers* used to verify the result of an expression are things like `should` and `equal` which are easy to read put together. The tests above should be easy enough to read.

The idea behind unit testing is that we reduce everything to a boolean true/false test, and assert that each one is true, if the assertation is false, the test fails.

The advantage of these unit tests is that we can run them extremely fast, so fast that we can run them automatically everytime we build the app, and if any of them fail we are alerted immediately. As we write tests, we build up a set of **guarantees** that our code will behave a certain way, no matter how much we change.

`Kiwi` has a large collection of [`expectations`](https://github.com/kiwi-bdd/Kiwi/wiki/Expectations) we can use to write our tests easily, including `expectations` to verify arrays have a count within a certain range, assertations, and asynchronous expectations (eg: eventually, this network request should complete).

Kiwi also has very good [documentation](https://github.com/kiwi-bdd/Kiwi/wiki), which I would recommend you consult if you have any issues.

Test Driven Development (TDD)
--------------------

The core idea behind TDD is that we start by writing our tests, and then we just write code to make them pass. We add more tests until our code is correct. The advantage of developing like this is we skip a lot of things like '*launch the app, press some buttons, look at it*', and can instead focus on writing our code instead.

Let's take a simple example. We'd like to write a function that concatenates two strings together (eg: "Hello" + " World"). We start by writing our `Kiwi` test, before any code.

```obj-c
describe(@"concatenate", ^{
    it(@"should concatenate two strings", ^{
          NSString *result = [@"Hello" concatenate: @" World"];
          [[result should] equal:@"Hello World"]];
      });
});
```

Since we are dealing with an object without state, we skip the `context` block. Now, I can tell you that this function already exists in obj-c (`stringByAppendingString`, so our example here is quite trivial, but let's pretend it doesn't for a moment and examine what exactly we just did.

Before we've even written any code, we've thought about:

- What we'd like the code to do. (Concatenate two strings).
- What we'd like the function signature to look like (concatenate:).
- Where we'd like the function to exist (As a category on `NSString`).

These are all valuable things, decisions we have to make when writing code, and by writing *how we want the code to be used* beforehand, we've answered all of them.

Now, if we run this now, the test will fail. So let's make it pass.

```obj-c
@interface NSString (Concatenate)
- (NSString*)concatenate:(NSString*)string;
@end
```

```obj-c
@implementation NSString (Concatenate)

- (NSString*)concatenate:(NSString*)string{
  return [self stringByAppendingString:string];
}

@end
```

If we run the test now, it will pass. We've verified our code works without having to log anything to console, launch the simulator, or anything.

