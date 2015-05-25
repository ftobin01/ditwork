//
//  Deck.m
//  sol1
//
//  Created by F T on 25/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//



#import "Deck.h"




@implementation Deck

int deckTop=52;

NSMutableSet *deck = [NSMutableSet setWithCapacity:52];


-(void) initDeck
{
    
    
    NSMutableArray *cardsArray = [[NSMutableArray alloc] initWithCapacity:52];
    
    Card *tmpCard= [[Card alloc] init];
    
    // Create Deck
    for (int suitNum=0; suitNum<4; suitNum++)
        {
            tmpCard.cardSuit=  suitNum;
            
            for (int  cardNumVal=0;cardNumVal<13; cardNumVal++)
                {
                    tmpCard.cardVal = cardNumVal;
                    tmpCard.cardPic = @"reversre Pic";
                    tmpCard.cardRect = CGRectMake(0,0,0,0);
                    tmpCard.cardFaceUp= FALSE;
                    [cardsArray addObject: tmpCard];
                }
                
            
        }
    
    // Shuffle Deck - Only Done At Start
    
    for (int cardPos=0; cardPos < [cardsArray count]; cardPos++)
        {
        int randInt = (arc4random() % ([cardsArray count] - cardPos)) + cardPos;
            
        [cardsArray exchangeObjectAtIndex:cardPos withObjectAtIndex:randInt];
        
        }
    // Using A Set to maintain Integrity of Deck
    // Not Essential for Solitaire - but gives 'Clean Deck'
    
    [deck addObjectsFromArray: cardsArray];
}



-(void) dealCard
    {
// returns one card from Deck
        // updates top of DEck Count
    }
@end
