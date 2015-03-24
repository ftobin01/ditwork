//
//  ViewController.m
//  Blackjack
//
//  Created by Zachary Davison on 10/20/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "ViewController.h"
#import "BJCard.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *deck;
@property (nonatomic, strong) NSMutableArray *hand;

@end

@implementation ViewController

- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  [self setupDeck];
  [self setupHand];
  
  ///
  
  NSNumber *myNumber = @42;
  
  void (^myBlock)() = ^{
    NSLog(@"Hello %@", myNumber);
  };
  
  myNumber = @24;
  
  myBlock();
  
  //
  
  NSLog(@"%@", _deck);
  
  BJCard *drawnCard = [self drawCard];
  [_hand addObject:drawnCard];
  
  NSLog(@"%@", _hand);
}

- (void)setupHand{
  _hand = [NSMutableArray array];
}

- (void)setupDeck{
  NSArray *faces = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
  NSArray *suits = @[@"♣", @"♥", @"♠", @"♦"];
  
  _deck = [NSMutableArray array];
  
  for(NSString *suit in suits){
    for (NSString *face in faces) {
      BJCard *cardInDeck = [[BJCard alloc] initWithSuit:suit face:face];
      [_deck addObject:cardInDeck];
    }
  }
}

- (BJCard*)drawCard{
  NSInteger index = arc4random() % _deck.count;
  BJCard *card = [_deck objectAtIndex:index];
  [_deck removeObject:card];
  
  return card;
}

@end
