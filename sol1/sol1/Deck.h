//
//  Deck.h
//  sol1
//
//  Created by F T on 25/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//

#import "Cards.h"




@interface DeckObj : Card

@property (nonatomic,strong ) Card *cardInPlay;
@property (nonatomic,strong) NSMutableArray   *deck;


@property (nonatomic,strong) NSMutableArray   *cardsMainArea; //
@property(nonatomic,strong)  NSMutableArray   *cardsAceArea; //not sure i wil use this in Solitaire Screen
@property (nonatomic,strong) NSMutableArray   *deckShownArea; // where deck is shown

@property (nonatomic,strong) NSMutableArray   *clubsArea;
@property (nonatomic,strong) NSMutableArray   *heartsArea;
@property (nonatomic,strong)  NSMutableArray  *diamondsArea;
@property (nonatomic,strong) NSMutableArray   *spadesArea;

@property (nonatomic,strong) NSMutableArray *cardsArray;
@property NSArray *suitWords;
@property NSArray *cardWords;


//-(Card *)initCardWithData : (int ) suitNum :( int ) cardNumVal : (NSString *) cardPicName : (CGRect) cardRect : (BOOL ) cardFaceUp;

-(Card *) getCardFromSubViewRect : (CGRect ) aRect;
-(Card *) getCardFromRect : (NSMutableArray *) cardArray : (CGRect) aRect;

-(NSString *) getPicFileName : (Card *) acard;
-(Card *) dealCard;
 -(void) initDeck;
-(void) compareColumns;
// -( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
@end
