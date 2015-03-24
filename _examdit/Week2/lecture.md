OOP 1.2
====================

Overview
--------------------
This class consists of an overview of control flow statements:

(`if`, `else`,`for`,`while`,`switch`, `for in`)

...and basic common data structures used in Objective-C provided by `Foundation`.

(`NSArray`, `NSMutableArray`, `NSDictionary`, `NSMutableDictionary`, `NSSet`, `NSOrderedSet`).

There is also a brief crash course in `git`.

Control Flow
--------------------

Objective-C offers all of the usual control flow statements, directly ported from C, with the addition of a `fast enumeration` control flow statement, used to iterate over collections (eg: `for in`).

Following are examples of all the Objective-C control flow statements:

### if / else
```objective-c
if(myValue == 2){
  NSLog(@"myValue is 2");
}else{
  NSLog(@"myValue is not 2");
}
```

### for
```objective-c
for(int i = 0; i < 10; i++){
  // Print each number from 0 to 9.
  NSLog(@"%d", i);
  // 0,1,2,3,4,5,6,7,8,9,10
}
```

### while
```objective-c
while(expression){
  NSLog(@"Do something");
}
```

### switch
```objective-c
  switch (expression) {
    case 1:
      NSLog(@"Expression is 1");
      break;

     case 2:
      NSLog(@"Expression is 2");
      break;

    default:
      NSLog(@"Expression is neither 1 nor 2");
      break;
  }
```

### for in

Offered as part of a protocol `NSFastEnumeration` on various Objective-C collection classes (eg: `NSArray`, etc), provides a nicer way to iterate over objects in an array.

```objective-c
for(NSNumber *number in @[@1,@2,@3,@4]){
  NSLog(@"number is %@", number);
}
```

Data Structures
--------------------

Objective-C offers a variety of data structures that you will use day to day writing code. The main ones are covered below, although there are a few oddball ones out there (`CFBag`) that you may encounter in future, although reasons to make use of these are very rare.

It is important to understand that Data Structures in `Foundation` are implemented as **Class Clusters**:

### [Class Clusters](https://developer.apple.com/library/ios/documentation/general/conceptual/CocoaEncyclopedia/ClassClusters/ClassClusters.html)

The `Foundation` collection classes / datastructures are implemented using a concept called **Class Clusters**, which allows us to use one single interface (eg: `NSArray`), while the underlying implementation will choose which specific implementation to use to optimize for performance and storage.

The actual implementation of these underlying classes is difficult to know, since the source is not open, the important thing for you to understand is that **subclassing** these class clusters is not as simple as subclassing other classes in the language, and requires [some work](https://mikeash.com/pyblog/friday-qa-2010-03-12-subclassing-class-clusters.html).

### [NSArray](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/index.html)

`NSArray` is the most common collection / datastructure used in Objective-C, and is used to store *collections of objects in order*. It is the equivalent to an `Array` or `ArrayList` from other languages, and can be instantiated in several ways, the old, longform ways:

```objective-c
[[NSArray alloc] initWithObjects:@1,@2,@3,nil];
[NSArray arrayWithObjects:@1,@2,@3,nil];
```

...or the preferred, modern format of:

```objective-c
@[@1,@2,@3];
```

An `NSArray` provides ways to index (access) it's members, the old way:

```objective-c
NSArray *array = @[@1,@2];
[array objectAtIndex:1]; // Result is '2'
```

...or again, the preferred, modern, **subscript** method:

```objective-c
NSArray *array = @[@1,@2];
array[1]; // Result is '2'
```

`NSArray` also provides many useful methods for **sorting** and performing methods on its members.

An `NSArray` instance is **immutable**, meaning its contents cannot be added to, removed, or changed (the objects inside may themselves be changed).

Take a look at the [class reference](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/index.html) for more information.

Normally, operations on an array follow normal [Big O **{Important!}**](http://www.cforcoding.com/2009/07/plain-english-explanation-of-big-o.html)  rules for their operational cost, but due to **class clustering**, you may in fact observe differences in `NSArray` performance, if you put this to the test.

### [NSMutableArray](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/index.html)

An `NSMutableArray` instance behaves exactly like an `NSArray`, except it is **mutable**, which means that its contents can be added to, removed, moved around, etc. It provides methods such as `addObject:` and `removeObjectAtIndex:` to do this.

### [NSDictionary](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDictionary_Class/index.html)

An NSDictionary is the Objective-C equivalent to a `Hashmap`, a Javascript `Object`, or a Java/C# `Dictionary`. It allows us to store associated with a `key`, which is often an `NSString`, but can be any object that is *Hashable*, which in Obj-C means implements the `NSCopying` protocol.

Dictionaries, as a data structure, provide performance benefits and ease of use for accessing large amounts of data, provided we use a good **hashing function** for our contents, and are used commonly in Objective-C day to day.

In Objective-C, we can initialize an `NSDictionary` using old forms, such as `initWithObjects:forKeys:`, etc, but the modern, preferred version is to initialize an instance using the following format:

```objective-c
@{
  @"Key": @"Value",
  @"Key2": @"Value2"
}
```

`NSDictionary` can also be **subscripted**, much like `NSArray`, using:

```objective-c
NSDictionary *dictionary = @{"@"Key": @"Value"};
dictionary[@"Key"]; // Result is 'Value'
```

`NSDictionary` is a very important class to understand. You should read up on the general advantages of the datastructure, and you should also understand **collisions** and how they can cause performance problems.

### [NSMutableDictionary](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSMutableDictionary_Class/index.html)

Following the same pattern as `NSArray`, `NSMutableDictionary` is a **mutable** version of `NSDictionary`.

### [NSSet](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSSet_Class/index.html)

`NSSet` is a less common but useful datastructure, and provides an *unordered* , *uniqued* collection of objects. This means that no object can exist in an `NSSet` twice. Although `NSSet` does not guarantee any ordering, and in fact there are no ways to access an object inside `NSSet` using an array index or similar.

You may ask, why would we ever want this? Sometimes, we are faced with problems where we want to treat a set of objects all the same, and do not care which object comes first, or last, etc, and we would like to show this is the case by using an `NSSet`, so nobody ever expects these objects to be in any sort of order. Also, the guarantee of uniqueness is often useful to make sure we don't have any duplicates.

An object in an `NSSet` is guaranteed to be unique as long as it returns the same `hash` and `isEqual:` result as an object that should be deemed identical to it.

Unlike `NSArray` and `NSDictionary`, there are no convenience/'modern' methods to initialize an instance, so we have to use old school methods:

```objective-c
[[NSSet alloc] initWithObjects:@1,@1,@2,nil];
// This set will contain '@1' and '@2'.
```

Much like `NSArray` and `NSMutableArray`, there is an `NSMutableSet`. (And an `NSMutableOrderedSet`)

### [NSOrderedSet](https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSOrderedSet_Class/index.html)

`NSOrderedSet`, like its name suggests, provides the uniqueness guarantee of `NSSet`, but also maintains an ordering, like `NSArray`. The most common instances of it are seen in `Core Data` relationships, but it can also be useful for your own code.

It otherwise behaves exactly like an `NSSet`.

`git`
--------------------

`git`, created by Linus Torvalds, is a **distributed source control** tool. It is similar in purpose to `svn` and `mercurial`. The purpose of `git` is primarily to make working with large amounts of programmers on one project manageable, but it can also be very useful to manage your own projects, as when used correctly, it provides a **fully revertible** history of your entire development, allowing you to roll back mistakes, see logs, and understand your development much better.

I highly recommend trying out this [interactive tutorial by GitHub](https://try.github.io/levels/1/challenges/1) and this [interactive tutorial on branching](http://pcottle.github.io/learnGitBranching/) to learn about `git`.

We will not cover branching for now, but please feel free to learn ahead as this can be very useful to know. For now, know that you are always on the `master` branch.

### Overview

`git` operates through a hidden `.git` folder in every project you are using `git` to manage. This folder contains a history of changes you have made to your code, allowing you to inspect and roll back to any `commit` at any time. The general methodology for working with `git` is you do work on your machine, and when it is ready, `commit` it to your local `git` repository. After this, you can `push` your `commit`s to the server, where they will be available for other people to view/use. In the event of two developers having made changes to the same area of code, you will trigger a `merge conflict`, which can be easily resolved.

### Basic Commands

The absolute basics you need to know to make use of `git` for this class are the commands `status`, `add`, `commit`, and `push`. We will be using `git` to manage course materials, and to submit lab work and assignments.


### `status`

eg: `git status`

`status` shows you the current status of your **unstaged changes**, eg: what files you have changed, added, or deleted. These changes are currently not applied to your `git` history, and need to be `commit`ted.

### `add`

eg: `git add .`

`add` adds your **unstaged changes** to your **current commit**, otherwise known as **staging** changes. `add`ing changes is not enough to `commit` them, however, and these can later be removed or **unstaged**.

### `commit`

eg: `git commit -m "My Commit Message"`

`commit` commits your **staged changes** into the repository on your machine, adding them to your history. To do this, you need to provide a **commit message**, which should explain what your code, an overview of changes you made, etc.

### `push`

eg: `git push origin master`

`push` 'pushes' your code to the server so other people can see it.

### Adding a repo, staging code, committing, and pushing

```
git remote add origin http://github.com/mygithub
git add .
git commit -m "My Commit Message"
git push origin master
```
