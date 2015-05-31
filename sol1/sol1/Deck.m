//
//  Deck.m
//  sol1
//
//  Created by F T on 25/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//



#import "Deck.h"

//#define CARDREVERSE     @"card reverse 2.jpeg"

@interface DeckObj (Card)


@property (nonatomic,strong) NSMutableSet *deck;

@property (nonatomic,strong) NSMutableSet    *cardsMainArea; //
@property(nonatomic,strong)  NSMutableSet   *cardsAceArea; //not sure i wil use this in Solitaire Screen

@property (nonatomic,strong) NSMutableSet   *cardsClubsArea;
@property (nonatomic,strong) NSMutableSet   *cardsHeartsArea;
@property (nonatomic,strong)  NSMutableSet   *cardsDiamondsArea;
@property (nonatomic,strong) NSMutableSet   *cardsSpadesArea;


@property (nonatomic ) Card *cardInPlay;
@property (nonatomic,strong) NSMutableArray *cardsArray;
@property NSArray *suitWords;
@property NSArray *cardWords;

- (Card *)      getCardFromSubViewRect : (CGRect) aSubview;
- (Card *)      getCardFromRect : (NSMutableSet *) cardArray : (CGRect) aRect;

- (void)        initDeck;
- (Card *)      dealCard;
- (NSString *)  getPicFileName : (Card *) acard;

//- (Card *)       initCardWithData : (int ) suitNum :( int ) cardNumVal : (NSString *) cardPicName : (CGRect) cardRect : (BOOL ) cardFaceUp;

-(BOOL) aceCardLogic : (Card *) dropCard :(Card *) dragCard;
-(BOOL) mainCardLogic :(Card *) dropCard :(Card *) dragCard;

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
     _cardsMainArea = [[NSMutableSet  alloc] initWithCapacity:52]; // Cards in Solitaire Screen
     _cardsClubsArea = [[NSMutableSet  alloc] initWithCapacity:52];;
      _cardsHeartsArea = [[NSMutableSet  alloc] initWithCapacity:52];;
    _cardsDiamondsArea = [[NSMutableSet  alloc] initWithCapacity:52];;
     _cardsSpadesArea = [[NSMutableSet  alloc] initWithCapacity:52];;
    
  
    
    
    
    
    
   // NSMutableArray *_cardsArray;
   // _cardsArray=[NSMutableArray   arrayWithCapacity:52];
    //NSMutableArray *_cardsArray = [NSMutableArray array];
    
    _cardsArray= [[NSMutableArray  alloc] initWithCapacity:52];
    _cardInPlay = [[Card alloc] init];
   // NSMutableArray *_cardsArray = [[NSMutableArray alloc] initWithCapacity:52];
  
    
    // Create Deck
    Card *tmpCard;
    for (int suitNum=0; suitNum<4; suitNum++)
        {
            for (int  cardNumVal=1;cardNumVal<= 13; cardNumVal++)
                {
                    
                    tmpCard = [[Card alloc ] initCardWithData : suitNum : cardNumVal :  CARDREVERSE: CGRectMake(0,0,0,0) :FALSE];
                    
    /*
                    Card *tmpCard= [[Card alloc] init];
                    
                    tmpCard.cardSuit=  suitNum;
                    tmpCard.cardVal = cardNumVal;
                    tmpCard.cardPic = CARDREVERSE;
                    tmpCard.cardRect = CGRectMake(0,0,0,0);
                    tmpCard.cardFaceUp= FALSE;
     */
                    tmpCard.cardPic =[self getPicFileName : tmpCard];
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
        
        NSLog(@"In dealCard : dealCard.cardVal 1.1 = %@",dealCard);
        return (dealCard);      //returns nil if empty
    }



-(NSString *) getPicFileName : (Card *) aCard
{
  //  get card val from acard
  //  construct filename from it
    NSLog(@"getPicFileName 1 cardVal = %d",aCard.cardVal);
    int wordIndex;
    NSString *tmpString;
    if ((aCard.cardVal <= 10) && (aCard.cardVal >1))
        {
            tmpString = [NSString stringWithFormat:@"%d_of_%@.png",(int) aCard.cardVal, [_suitWords objectAtIndex : aCard.cardSuit] ];
        }
    else
        {
        if (aCard.cardVal==1)  // ace
            aCard.cardVal=14;
        wordIndex = aCard.cardVal -11; // 11,12,13,14
        tmpString = [NSString stringWithFormat:@"%@_of_%@.png", [_cardWords objectAtIndex : wordIndex], _suitWords[aCard.cardSuit]];
            
        }
    NSLog(@"getPicFileName  2 cardVal = %d",aCard.cardVal);
    
    NSLog(@"getPicFileName  3 cardVal = %@",aCard.cardPic);
    
    aCard.cardPic = [tmpString copy] ;
    aCard.cardFaceUp = TRUE;
    
    NSLog(@"getPicFileName  4 cardVal = %@",aCard.cardPic);  return tmpString;
}


-(Card *) getCardFromSubViewRect : (CGRect) aRect
{
    NSLog(@"getCardFomSubView aSubview.frame = %@  ",NSStringFromCGRect(aRect));
    NSLog(@"getCardFromSubView count of deck = %lu", (unsigned long)[_deck count]);
    Card *c = [[Card alloc] init];
    for ( c in _deck)
    {
         NSLog(@"getCardFromSubview c.cardVal =%d aRect = %@ cardRect =%@",c.cardVal,NSStringFromCGRect(aRect),NSStringFromCGRect(c.cardRect));
        
        if ( CGRectEqualToRect(aRect, c.cardRect))
        {
            NSLog(@"getCardFomSubView Found Card : %d %@", c.cardVal, c.cardPic);
            return (c);
        }
        
    }
    NSLog(@"getCardFomSubView Returning Nil ");
    return (nil);
  /*
    Frame A view's frame (CGRect) is the position of its rectangle in the superview's coordinate system. By default it starts at the top left.
    
    Bounds A view's bounds (CGRect) expresses a view rectangle in its own coordinate system.
    */
}


-(Card *) getCardFromRect : (NSMutableSet *) cardArray : (CGRect) aRect
{
    NSLog(@"getCardFronRect arect.frame = %@  ",NSStringFromCGRect(aRect));
    NSLog(@"getCardFromSubView count of deck = %lu", (unsigned long)[_deck count]);
    Card *c = [[Card alloc] init];
    for ( c in cardArray)
    {
        NSLog(@"getCardFromSubview c.cardVal =%d aRect = %@ cardRect =%@",c.cardVal,NSStringFromCGRect(aRect),NSStringFromCGRect(c.cardRect));
        
        if ( CGRectEqualToRect(aRect, c.cardRect))
        {
            NSLog(@"getCardFomSubView Found Card : %d %@", c.cardVal, c.cardPic);
            return (c);
        }
        
    }
    NSLog(@"getCardFomSubView Returning Nil ");
    return (nil);
    /*
     Frame A view's frame (CGRect) is the position of its rectangle in the superview's coordinate system. By default it starts at the top left.
     
     Bounds A view's bounds (CGRect) expresses a view rectangle in its own coordinate system.
     */
}




-(BOOL) aceCardLogic : (Card *) dropCard :(Card *) dragCard
{
    if (![_cardInPlay sameSuit :dropCard : dragCard] )
        return (FALSE);
    if (![_cardInPlay cardIsLower : dropCard : dragCard])
        return(FALSE);
    
    return (TRUE);
}




-(BOOL) mainCardLogic :(Card *) dropCard :(Card *) dragCard
{
    if (![_cardInPlay redAndBlack: dropCard :dragCard])
        return (FALSE);
    if (![_cardInPlay cardIsLower:dragCard :dropCard])
        return (FALSE);
    
    return (TRUE);
}
@end