OOP1.2 Lab
====================

Overview
--------------------

The goal of this lab is to model the basic requirements needed to run a game of [Blackjack](http://www.wikihow.com/Play-Blackjack) in Objective-C code.

You can use a `Single View` XCode project that gives you a single UIViewController class, and you can use the `viewDidLoad` method as an entry point to get started. There is no need to create UI for the game as this will be covered in the iOS1 labs.

Goals
--------------------
Your code should provide the following features:
- A representation of a 52 card deck (no jokers).
- A way to `draw` a card from the deck (This should remove it from the deck also).
- A way to store a users `hand` (eg, what cards you currently have in your hand).
- A way to get the value of a card.

Required Understanding
--------------------
Collection Classes, Control Flow Statements, Instance Methods, Classes.

Hints
--------------------
- The 'random' function in objc is `arc4random_uniform(n)` where `n` is the maximum. (eg `arc4random_uniform(5)` will be between 0 and 5
- You will need to make use of an appropriate **collection class** to represent the deck.
- You will need to make use of an appropriate **collection class** to represent a players hand.
- You could use a `method` to `draw` a card to a `player`s hand.
- Think about how you would generate the deck of 52 from an array of 4 suits and an array of 13 cards.
- You could use an `NSDictionary` to store a lookup list of the values of each face. (eg: `K` == `10`)

Submission
--------------------
Please create a [GitHub](https://github.com/) account and `push` your code to a repository named `OOP1` under a folder called `Lab2`. Send me the URL for this repository. Please include your real name with the URL if it is not already displayed on [GitHub](https://github.com/).

Notes
--------------------

- **Your game does not need to be fully playable. Please focus on getting as much done as possible and submitting it to GitHub. In the coming iOS1 labs we will be creating a user interface for the game and making it playable. For now it is enough to have working versions of the above. You can use `NSLog` statements to confirm your code behaves how you want in XCode. **


