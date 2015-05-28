//
//  Deck.h
//  sol1
//
//  Created by F T on 25/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//

#import "Cards.h"

#define HEARTS      0
#define SPADES      1
#define CLUBS       2
#define DIAMONDS    3



@interface DeckObj : Card

@property (nonatomic)  int deckTop;
@property (nonatomic ) Card *cardInPlay;
@property (nonatomic) NSMutableSet *deck;
@property (nonatomic,strong) NSMutableArray *cardsArray;
@property NSArray *suitWords;
@property NSArray *cardWords;


-(NSString *) getPicFileName : (Card *) acard;
-(Card *) dealCard;
 -(void) initDeck;
-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
@end
