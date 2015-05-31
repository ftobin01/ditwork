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
@property (nonatomic,strong) NSMutableSet   *deck;
@property(nonatomic,strong)  NSMutableSet   *cardsMainArea; // Cards in Solitaire Screen
@property (nonatomic,strong) NSMutableSet   *cardsClubsArea;
@property (nonatomic,strong) NSMutableSet   *cardsHeartsArea;
@property(nonatomic,strong)  NSMutableSet   *cardsDiamondsArea;
@property (nonatomic,strong) NSMutableSet   *cardsSpadesArea;


@property (nonatomic,strong) NSMutableArray *cardsArray;
@property NSArray *suitWords;
@property NSArray *cardWords;


//-(Card *)initCardWithData : (int ) suitNum :( int ) cardNumVal : (NSString *) cardPicName : (CGRect) cardRect : (BOOL ) cardFaceUp;

-(Card *) getCardFromSubViewRect : (CGRect ) aRect;
-(Card *) getCardFromRect : (NSMutableSet *) cardArray : (CGRect) aRect;

-(NSString *) getPicFileName : (Card *) acard;
-(Card *) dealCard;
 -(void) initDeck;
-(void) compareColumns;
// -( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
@end
