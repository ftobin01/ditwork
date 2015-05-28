//
//  Deck.m
//  sol1
//
//  Created by F T on 25/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//



#import "Deck.h"

#define CARDREVERSE     @"card reverse 2.jpeg"

@interface DeckObj (Card)

@property (nonatomic)  int deckTop;
@property (nonatomic) NSMutableSet *deck;
@property (nonatomic ) Card *cardInPlay;
@property (nonatomic,strong) NSMutableArray *cardsArray;
@property NSArray *suitWords;
@property NSArray *cardWords;

//@property (nonatomic) DeckObj *SolDeck;

-(void) initDeck;
- (Card *) dealCard;
-(NSString *) getPicFileName : (Card *) acard;

@end


@implementation DeckObj




-(void) initDeck
{
    _suitWords = @[ @"hearts", @"spades", @"clubs", @"diamonds"];
    
    _cardWords = @[ @"jack",@"queen",@"king",@"ace"];
    
    [self makeDeck];
}


-(void) makeDeck
{
    
   // Deck *solDeck = [[Deck alloc] init];
    NSLog(@"InMakeDeck");
    NSLog(@"InMakeDeck CARDREVERSE= %@",CARDREVERSE);
    _deck = [[NSMutableSet  alloc] initWithCapacity:52];
    
   // NSMutableArray *_cardsArray;
   // _cardsArray=[NSMutableArray   arrayWithCapacity:52];
    //NSMutableArray *_cardsArray = [NSMutableArray array];
    
    _cardsArray= [[NSMutableArray  alloc] initWithCapacity:52];
    _cardInPlay = [[Card alloc] init];
   // NSMutableArray *_cardsArray = [[NSMutableArray alloc] initWithCapacity:52];
  
    
    // Create Deck
    for (int suitNum=0; suitNum<4; suitNum++)
        {
            for (int  cardNumVal=0;cardNumVal<13; cardNumVal++)
                {
                    Card *tmpCard= [[Card alloc] init];
                    
                    tmpCard.cardSuit=  suitNum;
                    tmpCard.cardVal = cardNumVal;
                    tmpCard.cardPic = CARDREVERSE;
                    tmpCard.cardRect = CGRectMake(0,0,0,0);
                    tmpCard.cardFaceUp= FALSE;
                    
                    // [Card copy];
                    [_cardsArray addObject: tmpCard];
                    
                
                   // Card *p = [_cardsArray objectAtIndex:cardNumVal];
                    
                    /*
                    NSLog(@"InMakeDeck - tmpCard.cardVal= >> %d",tmpCard.cardVal);
                    NSLog(@"InMakeDeck - tmpCard.cardSuit= >> %d",tmpCard.cardSuit);
                    NSLog(@"InMakeDeck - p.cardVal= >> %d",p.cardVal);
                    NSLog(@"InMakeDeck - p.cardSuit= >> %d",p.cardSuit);
                      NSLog(@"InMakeDeck - _cardsArray.count = >> %lu",(unsigned long)[_cardsArray count]);
                     */
                }
   
            
        }


NSLog(@"InMakeDeck - _cardsArray.count 2 = >> %lu",(unsigned long)[_cardsArray count]);

       
    NSLog(@"MAKEDECK - before Shuffle ");
    /*
    NSEnumerator *enumerator = [_cardsArray keyEnumerator];
    
    for(NSString *aKey in enumerator) {
        NSLog(@"%@", aKey);
        NSLog(@"%@", [[myDictionary valueForKey:aKey] string]); //made up method
    }
    */
    /*
    for (int i=(int)[_cardsArray count]-1; i>=0; i--)
    {
        Card *p =[_cardsArray objectAtIndex:i];
        NSLog(@"In MakeDeck card [%d] p.cardSuit %d p.cardVal = %d",i,p.cardSuit,p.cardVal);
    }
     */
    /*
    NSArray  *p = _cardsArray;
    
    for (Card *c in p) //not working
        
    {
        NSLog(@"In MakeDeck card c.cardSuit %d c.cardVal = %d",c.cardSuit,c.cardVal);
    }
     */
    
    
    
    
    
    // Shuffle Deck - Only Done At Start
    NSLog(@"InMakeDeck - about to shuffle");
    for (int cardPos=0; cardPos < [_cardsArray count]; cardPos++)
        {
        int randInt = (arc4random() % ([_cardsArray count] - cardPos)) + cardPos;
            
        [_cardsArray exchangeObjectAtIndex:cardPos withObjectAtIndex:randInt];
        
        }
    
    NSLog(@"InMakeDeck - _cardsArray.count 3 aftrshuffle = >> %lu",(unsigned long)[_cardsArray count]);
    

    
    // Using A Set to maintain Integrity of Deck
    // Not Essential for Solitaire - but gives 'Clean Deck'
     NSLog(@"InMakeDeck - about to add toSet ");
    NSLog(@"InMakeDeck - _cardsArray count = %lu ",(unsigned long)[_cardsArray count]);
    [self.deck  addObjectsFromArray: _cardsArray];
    
    for (Card * c in _cardsArray)
    
    {
        NSLog(@"In MakeDeck card c.cardSuit %d c.cardVal = %d",c.cardSuit,c.cardVal);
    }
    
}



-(Card *) dealCard
    {
         NSLog(@"In dealCard");
       // Card *cardDealt = [[Card alloc] init];
        int i=0;
        
        // Using First Iteration in Loop to NSSet element
        Card *dealCard;  //needs to outside swcope for loop
        for (dealCard in _deck)
        {
        //Card *cardDealt = [[Card alloc] init];
        // *cardDealt = *dealCard;
        NSLog(@"In dealCard :  1 [%d] = %@",(int)i++,dealCard.cardPic);
        NSLog(@"In dealCard : dealCard.cardVal 1.1 = %d",dealCard.cardVal);
       
            // cardDealt= dealCard ;
     //   NSLog(@"In dealCard dealCard 2 = %@",dealCard);
        break;
        }
        
        if (dealCard)
            [_deck removeObject: dealCard];
        
        return (dealCard);      //returns nil if empty
    }



-(NSString *) getPicFileName : (Card *) aCard
{
  //  get card val from acard
  //  construct filename from it
    
    int wordIndex;
    NSString *tmpString;
    if ((aCard.cardVal <= 10) && (aCard.cardVal >1))
        {
            tmpString = [NSString stringWithFormat:@"%d_of_%@.png",(int) aCard.cardVal, [_suitWords objectAtIndex : aCard.cardSuit] ];
        }
    else
        {
        if (aCard.cardVal==1)
            wordIndex=3;
        else
            wordIndex = aCard.cardVal -10;
            tmpString = [NSString stringWithFormat:@"%@_of_%@.png", [_cardWords objectAtIndex : wordIndex], _suitWords[aCard.cardSuit]];
        }
    return tmpString;
}


@end