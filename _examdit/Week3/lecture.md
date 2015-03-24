OOP 1.3
====================

Overview
--------------------
This class consists of an overview of `Protocols` and the `delegate` pattern.

[Protocols](https://developer.apple.com/library/ios/documentation/cocoa/conceptual/ProgrammingWithObjectiveC/WorkingwithProtocols/WorkingwithProtocols.html)
--------------------

**Protocols**, also known as **Interfaces** in other languages, are an *interface* without an *implementation*. These can then be adopted, or *conformed to* by classes, allowing us to treat that class as an *instance* of that protocol.

In effect, it means we dont need to know what a class is exactly, we just want to know that it implements certain methods.

In Objective-C, a protocol is declared as follows:

```obj-c
@protocol MyProtocol

@required
- (void)myRequiredMethod:(NSString*)aString;

@optional
- (void)myOptionalMethod:(NSString*)aString;
```

Note that methods in a protocol can be marked as **`@required`** or **`@optional`**, as the names suggest, these tell us that when we implement the protocol, we **must** implement all **`@required`** methods, while we are free to implement **`@optional`** ones if we so wish. The distinction is usually so that protocols can offer optional behaviour that we may or may not want.

The point of a protocol is so that we may have multiple classes that all offer the same interface, but different implementations, in lots of these cases, we dont care about the specifics of these classes, but we do want to verify that they support the functionality we want.

This means we can refer to the object as an instance of `id<MyProtocol>`, which means this is 'an object that implements the methods defined in `MyProtocol`.

Commonly, protocol methods are used to **notify** us that something happened (especially if that action was **asynchronous**), or to **ask** for a value we may need to configure something with. This is usually referred to as the `delegate` pattern.

[Delegates](https://developer.apple.com/library/ios/documentation/general/conceptual/CocoaEncyclopedia/DelegatesandDataSources/DelegatesandDataSources.html)
--------------------

Delegates are a way of **handing off** functionality or configuration of an object to another object. Essentially, an object can call methods on another object that conforms to a `protocol`, to provide functionality.

This **design pattern** is common in the Core Frameworks, especially UIKit, and is a powerful tool allowing you to take simple classes and tailor them to your needs without subclassing them.

A common delegate implementation looks like this:

**NameDelegate.h**
```obj-c
@protocol NameDelegate

- (NSString*)name;

@end
```

**ZDNameSource.h**
```obj-c
@interface ZDNameSource <NameDelegate>

@end
```

**ZDNameSource.m**
```obj-c
@implementation ZDNameSource

- (NSString*)name{
 return @"Zachary Davison";
}

@end
```

**ViewController.h**
```obj-c
//...

@property (nonatomic, weak) id<NameDelegate> nameDelegate;
@property (nonatomic, weak) IBOutlet UILabel *label;

//...
```

**ViewController.m**
```obj-c
//...
- (void)viewDidLoad{
  [super viewDidLoad];

  _label.text = [_nameDelegate name];
}
//...
```

Note in the above example, `nameDelegate` was never set by us. Usually, this would be set by something else, because `ViewController` does not care that `nameDelegate` is an instance of `ZDNameSource`, just that it implements the methods in the `NameDelegate` protocol.

The advantage of this may still not be apparent, so lets look at a common UIKit example of the **delegate** pattern.

[UITableViewDataSource](https://developer.apple.com/library/ios/documentation/uikit/reference/UITableViewDataSource_Protocol/index.html)
--------------------

[`UITableView`](https://developer.apple.com/library/ios/documentation/uikit/reference/UITableView_Class/index.html#//apple_ref/occ/cl/UITableView) is a UIKit class for showing tables of content. Here's an example of it in Snapchat:

![](https://github.com/zdavison/DIT.OOP1/blob/master/Week3/snapchat.png)

That entire screen consists of a `UINavigationBar` and a `UITableView`, nothing more. The `UITableView` contains instances of [`UITableViewCell`](https://developer.apple.com/library/ios/DOCUMENTATION/UIKit/Reference/UITableViewCell_Class/index.html) to show each persons name and the icon beside it.

`UITableViewDataSource` is a protocol that defines methods that provide the `UITableView` instance with information it needs to **populate** itself with `UITableViewCell` instances. The ones we care about right now are:

```obj-c
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
```

The first method, `tableView:numberOfRowsInSection:` is called by the `UITableView` to ask our implementation *how many rows the tableView should display*. This is often just the number of items in an array, something like:

```obj-c
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _deck.count;
}
```

Note the `section` parameter, which allows us to have multiple different sections in our table. Ignore this for now, the default is 1 section.

The second method, `tableView:cellForRowAtIndexPath:`, asks us to return a `UITableViewCell` representing the information at the current `NSIndexPath` (an `NSIndexPath` is simply a pairing of a `section` and a `row`).

As a quick aside, `UITableView` **re-uses** cells, to avoid creating 1000s of instances of `UITableViewCell` in memory, this works because on the screen, there are only ever a few cells on screen at once, so once a cell leaves the screen, it can be reused. We will talk about this in more detail later, but for now this will help you understand the following code:

```obj-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellIdentifier"];
  cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
  return cell;

}
```

What we are doing above is asking the `UITableView` to give us a `UITableViewCell` instance (it will either return us an old one it has decided can be reused, or create a new one if necessary). We then **configure** this cells label using a string that contains the current row, and then we return it.

If this code was implemented on a `UIViewController` subclass we created, we could then set the `delegate` property of our `UITableView` to `self` in `viewDidLoad`, and the `UITableView` would call these methods whenever it needed to know *how many cells* it should display, and then once for each cell to get an instance of `UITableViewCell`.

This is one of the most common usages of the `delegate` pattern in iOS.

