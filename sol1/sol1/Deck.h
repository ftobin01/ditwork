//
//  Deck.h
//  sol1
//
//  Created by F T on 25/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//

#import "Cards.h"

@interface Deck : Card

@property (nonatomic)  int deckTop;
@property (nonatomic) NSMutableSet *deck;

@end
