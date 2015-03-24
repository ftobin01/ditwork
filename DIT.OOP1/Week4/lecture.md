OOP 1.4
====================

Overview
--------------------
This class consists of an introduction to `Blocks`.

[Blocks](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html)
--------------------

You may have seen Blocks, or something similar to them, in other languages, refered to as Lambdas, Procs, Anonymous Methods, or Closures. While their syntax in obj-c is a little goofy, and there are a few gotchas you need to be aware of, they are a very useful tool and important part of modern obj-c programming, also, in Swift, the concept is used a lot more.

Blocks are, in essence, a way to **encapsulate** code and pass it around so that it may be executed later. You may have seen this concept referred to in other languages as a **callback**.

Often, you will see them used as ways to execute code once an **asynchronous** task has completed (eg: a network request to load something from the web), they are also used as alternatives to **delegates**, and often fulfill very similar purposes.

You can think of them as a method you can pass around, they can do everything methods can do, including take arguments and return values.

Let's look at the simplest example of a block.

```obj-c
^{
  NSLog(@"Hello World");
}
```

The above code is not very useful, but it is helpful for us to start at the most basic foundation of a block, so we can understand additional features as we add them.

The above code declares a block that executes an `NSLog` statement that will print "Hello World" to console. Without storing this block somewhere, it's not particularly much use to us, so let's do that.

```obj-c
void (^myBlock)() = ^{
 NSLog(@"Hello World");
}
```

This looks a little more complicated, lets break it down.

- `void` declares the **return type** of the block.
- `(^myBlock)` is the quite strange syntax used to declare the name of the block variable, eg: `myBlock`. The `^` (carat) operator is used almost everywhere when we work with blocks.
- `()` is the argument list for the block. This block takes no arguments, so contains nothing. This is often written as `(void)`, which is the same thing.

What follows is the same code we had before. Now, this block is a little more useful. We can call it, like a method, using the following code:

`myBlock()`

Which may look familiar, note that we don't use square brackets here, but rather a more traditional function call syntax, the reasoning for this is that blocks do not invoke a **message**, the syntax for method calls in obj-c, eg `[self method]`, is used to indicate message passing is occuring.

This block, while now usable, is still not particularly useful, let's jump ahead and look at a very real world example using `AFNetworking`.

```obj-c
void (^myBlock)(AFHTTPRequestOperation *operation, id responseObject){
 NSLog(@"%@", responseObject);
}
```

The above block is taken from the [`setCompletionBlockWithSuccess:failure:`](https://github.com/AFNetworking/AFNetworking/blob/master/AFNetworking/AFHTTPRequestOperation.m#L107) method of the [`AFNetworking`](https://github.com/AFNetworking/AFNetworking) library. Commonly used in apps to make network requests to web services.

The difference now is that this block takes two parameters, `operation` and `responseObject`, which we can access within our block. The `AFNetworking` library will call this block when an *asynchronous network request* completes, and will pass it the two parameters `operation` and `responseObject`.

All we do inside it is log the response object to console so we can take a look at it, similar to our previous example, just with a format string.

The above block can be called like so:

```obj-c
myBlock(someOperation,anObject);
```

Where `someOperation` and `anObject` are objects of the appropriate type declared previously.

Capturing Semantics
--------------------

One thing useful about blocks is that they **capture** variables used inside of them, the reasoning for this is that since blocks are usually used at a later time than they are declared, the variables used inside them may not be available by the time the block is called, so blocks implicitly capture values used inside them. By default, this is always done **by value**, rather than by reference, which means that the value is **copied** as it exists **at the time the block is declared**.

This has important implications, that we will discuss later, but for now let us observe this behaviour in the following code:

```obj-c
NSInteger myInteger = 42;

void (^myBlock)() = ^{
  NSLog(@"Hello %ld", (long)myInteger);
};

myInteger = 24;

myBlock();
```

The above code will print `42` to console. This is because the variable `myInteger` was **captured** by the block at point of creation.

Note however, that the **value** of the variable is captured. In the case of pointers (references), the value we are capturing is the **address** of the variable, so if we were to use an `NSNumber` in the above example, it would print `24`.

[Block Syntax](http://goshdarnblocksyntax.com/)
--------------------

obj-c block syntax is quite obtuse and differs in slighty ways depending on where you are declaring a block.

Here is a cheat sheet:

```obj-c
//As a local variable:
returnType (^blockName)(parameterTypes) = ^returnType(parameters) {
  //Your code
};

//As a property:
@property (nonatomic, copy) returnType (^blockName)(parameterTypes);

//As a method parameter:
- (void)someMethodThatTakesABlock:(returnType (^)(parameterTypes))blockName;

//As an argument to a method call:
[someObject someMethodThatTakesABlock:^returnType (parameters) {
 //Your code
}];

```

A UIKit example
--------------------

A simple example of blocks in practice exists in the `UIView` API used for animations. The method we will look at is `animateWithDuration:animations:completion:`

```obj-c
[UIView animateWithDuration:5
                 animations:^{
  // Animation code
} completion:^(BOOL finished) {
  // When finished
}];
```

The reason this method uses blocks is so that it can execute all of the code in a single `CAAnimation` transaction. Understanding this right now is not important, just know that the goal is to make sure all the animations occur at the same time. The `completion` block allows us to specify things that should happen after the animation has completed, the parameter `finished`, passed to the `completion` block, is used incase the animations were cancelled, or did not fully complete for some reason. In most cases, it will be set to `true`.

We can use the above code to animate something, and then when the animation is completed, we can do something else. This could be used, for example, to make a button slide somewhere on the screen, and then when it has finished, change its title:

```obj-c
  [UIView animateWithDuration:5
                   animations:^{
                     myButton.frame = CGRectMake(myButton.frame.origin.x,
                                                 myButton.frame.origin.y + 50,
                                                 myButton.bounds.size.width,
                                                 myButton.bounds.size.height);
                   } completion:^(BOOL finished) {
                     UIButton *myButton;
                     [myButton setTitle:@"Animation Done!" forState:UIControlStateNormal];
                   }];
```

Further Reading
--------------------

Blocks are a complex but powerful tool, and we will discuss them in further detail in future, but for now if you are interested or would like to understand better, here are some resources:

- https://developer.apple.com/library/ios/documentation/cocoa/Conceptual/Blocks/Articles/00_Introduction.html
- http://www.appcoda.com/objective-c-blocks-tutorial/

