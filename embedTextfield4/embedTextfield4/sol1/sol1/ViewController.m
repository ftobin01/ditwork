//
//  ViewController.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//
#import "ViewController.h"
#import "Deck.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+Helper.h"
#include "constants.h"
#import "Card+View.h"
@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dragAreas;
@property (nonatomic, strong) NSMutableArray *dropAreas;
@property (nonatomic, strong) NSArray *subviews;
@property (nonatomic, strong) UIImage *globalCardImage;
@property (nonatomic, strong) Card    *cardInPlay;


// Sinks for Cards
@property (nonatomic,strong) DeckObj *Deck;

-(void)  showDeck;
//-(CGRect ) inSubViewList : ( CGPoint ) locationInView;
//-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
-(CGRect )chkAreaByRect : (NSArray *) viewArea : ( CGRect ) locationRect;

//-(Card *) getCardFromSubView : (CGRect *) aRect;
//- (void) deleteSubViewByRect : (CGRect ) aRect;

@end


@implementation ViewController

//- (IBAction)tapDetected:(id)sender {
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    static bool done=FALSE;
    /* Set  up object properly */
    
 /**/   if(done==FALSE)
        {
        _Deck = [[DeckObj alloc] init];
        [_Deck  initDeck];
        done=TRUE;
        }
  
    
    [self setupAllView];
    NSArray *subviews = [NSArray array];
    
    [self makeMainCardLayout];
   subviews = [self.view subviews] ;
    NSLog(@"subview count 1 %lu",(unsigned long)[subviews count]);
    
     NSLog(@"viewDidLoad 5");    // Create Aces Area
     [self createAcesArea];
     NSLog(@"viewDidLoad 6");
     //Create Deck Area
     [self createDeckArea];
     NSLog(@"viewDidLoad 7");
   
    NSLog(@"Leaving ViewDidload  8 dragArea count =  %d",(int ) [_dragAreas count]);
}

- (void) createAcesArea
{
    int acesArea_YPos = (6 * CARDLENGTH );
    int acesArea_XPos = self.view.bounds.size.width - (4*(CARDWIDTH) + 6*(GAPBETWEENACECARDS));
    for (int i=0; i<(CARDWIDTH+GAPBETWEENACECARDS)*4; i+=CARDWIDTH+GAPBETWEENACECARDS)
    {
        CGRect cardRect = CGRectMake(acesArea_XPos+i, acesArea_YPos, CARDWIDTH,CARDLENGTH);
        NSLog(@"Frame cardRect f = %@", NSStringFromCGRect(cardRect));
        
        UIView *aceView = [[UIView alloc] initWithFrame:cardRect];
        aceView.backgroundColor = [UIColor blackColor];
        [[self view] addSubview:aceView];
        [_dropAreas addObject: aceView];
       // NSLog(@"create Aces dropAreas Count = %ul",_dropAreas.count);
    }
 NSLog(@"create Aces dropAreas Count = %lu",(unsigned long)_dropAreas.count);
}


- (void) createDeckArea
{
    
    CGRect cardRect = CGRectMake(DECKCARD_XPOS, DECKCARD_YPOS, CARDWIDTH,CARDLENGTH);
    UIView *deckView = [[UIView alloc] initWithFrame:cardRect];
    
    deckView.backgroundColor = [UIColor blueColor];
    
    [[self view] addSubview:deckView];
    
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapDetected:)];
    
    [deckView addGestureRecognizer:tapGesture];
    
}




- (void) makeMainCardLayout     // check out subviewe layout
{
    Card *dealtCard;

    CGRect aRect;
    float j=15;
    float cardRow=CARDSTARTPOS;
    
        UIView *view1;
    
    for (int cardColumnIndex=0; cardColumnIndex<MAXCARDCOLUMNS; cardColumnIndex++)
    {
        for ( int i=0; i<= cardColumnIndex; i++)
        {
            //       dealtCard = [[Card alloc] init];
            NSLog(@" Deck dealcard.cardval %d",dealtCard.cardVal);
            aRect = CGRectMake( j, cardRow, CARDWIDTH, CARDLENGTH);
            view1 = [[UIView alloc] initWithFrame:aRect];
            _Deck.cardRect = aRect;  // assign View made to card
            dealtCard = [_Deck dealCard : view1];  // Deal a Card, Assign View
            
            [_Deck.cardsMainArea addObject: dealtCard]; // add to Main Area
            dealtCard.cardRect = aRect;  // assign View made to card
            [dealtCard drawCardPicture: view1 : CARDREVERSE];
            
            //[self drawCardPicture: view1 : dealtCard.cardPic];
            
            [[self view] addSubview:view1];
            
            cardRow+=CARDLENGTH/2;
        }
        // Section - For Last card Each Column
        j+=CARDWIDTH + GAPBETWEENCARDS;
        cardRow=CARDSTARTPOS;
        
        // Adding last card area in Each column as a draggable area.
        // [_dragAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable
        
        NSLog(@"viewDidLoad 1");
        [_dragAreas addObject: view1];      // Add last Card in Column to Droppable Area
        
        NSLog(@"viewDidLoad 2");       // Show its Real Face
        NSString *picFile =[_Deck getPicFileName :dealtCard];
        
        NSLog(@"viewDidLoad 2.5 ==> picFile = %@",picFile);
        [dealtCard drawCardPicture : view1 : picFile ];
        
        NSLog(@"viewDidLoad 3");
    }
}






- (void)tapDetected: (UIGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"In Tap Detected");
    
    CGPoint locationInView = [tapGestureRecognizer locationInView:self.view];
  
    CGRect tmpDeckRect = CGRectMake(DECKCARD_XPOS, DECKCARD_YPOS, CARDWIDTH,CARDLENGTH);
    
    if (CGRectContainsPoint(tmpDeckRect, locationInView))
        {
        NSLog(@"Deck Pressed!!!!");
            [self showDeck];
        }
        switch (tapGestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
              NSLog(@"Tap |Recognised");
            break;
        }
        case UIGestureRecognizerStateChanged:
            NSLog(@"Tap |Recognised 2");
            break;
            
        case UIGestureRecognizerStateEnded:
            NSLog(@"Tap |Recognised 3");
            
            
            break;
        default:
            NSLog(@"Error - Gesture State Not Recognised 4");
            break;
    
    
    }
}



#define SHOWDECK_XPOS    60
-(void) showDeck
{
    if ([[_Deck deck ] count] ==0)
           return; // DEck Empty!
    static BOOL SHOW_3_CARDS= TRUE;
    static BOOL DECK_SHOWN=FALSE;
    static UIView *showCard1;   //change to show card view
    static UIView *showCard2;
    static UIView *showCard3;
    int countDeckArea=(int) [[_Deck deckShownArea] count];
    if (countDeckArea==0)
        DECK_SHOWN=FALSE;
    if (!DECK_SHOWN)
        // need at least 1 view
    {
        NSLog(@"calling showDeck");
        CGRect cardRect1 = CGRectMake( SHOWDECK_XPOS, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
        showCard1 = [[UIView alloc] initWithFrame:cardRect1];
        Card *dealtCard1= [_Deck dealCard : showCard1];
        [dealtCard1 drawCardPicture : showCard1  : dealtCard1.cardPic];
        [self.view addSubview: showCard1];
        [[_Deck deckShownArea] addObject: dealtCard1];
        
        if (SHOW_3_CARDS==TRUE)
        {
            
            CGRect cardRect2 = CGRectMake( SHOWDECK_XPOS+10, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
            showCard2=[[UIView alloc] initWithFrame:cardRect2];
            Card *dealtCard2= [_Deck dealCard : showCard2];
            if ( dealtCard2  !=nil)
            {
                //  [_dragAreas addObject: showCard2];
                [self.view addSubview: showCard2];
                Card *dealtCard2= [_Deck dealCard : showCard2];
                
                [dealtCard2 drawCardPicture : showCard2  : dealtCard2.cardPic];
                NSLog(@"showDeck: adding dealtCard2.cardPic =%@",dealtCard2.cardPic);
                [[_Deck deckShownArea] addObject: dealtCard2];
                [_dragAreas removeLastObject];
                [_dragAreas addObject: showCard2];
                
                CGRect cardRect3 = CGRectMake( SHOWDECK_XPOS+20, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                showCard3=[[UIView alloc] initWithFrame:cardRect3];
                Card *dealtCard3= [_Deck dealCard : showCard3];
                if ( dealtCard3  !=nil)
                {
                    [dealtCard3 drawCardPicture : showCard3  : dealtCard3.cardPic];
                    NSLog(@"showDeck: adding dealtCard3.cardPic =%@",dealtCard2.cardPic);                                    [[_Deck deckShownArea] addObject: dealtCard3];
                    
                    NSLog(@"showDeck: after adding dealtCard2.cardPic =%@",[[_Deck deckShownArea] objectAtIndex: 1] );
                    
                    [_dragAreas removeLastObject];
                    [_dragAreas addObject: showCard3];
                    [self.view addSubview: showCard3];
                    
                    
                }
            }
            else
                [_dragAreas addObject: showCard1];
        }
        DECK_SHOWN=TRUE;
    }
    else
        
    {
        Card *dealtCard1= [_Deck dealCard : showCard1];
        
        if ( dealtCard1  !=nil)
        {
            // Deal 1 card
            if (SHOW_3_CARDS==FALSE)
            {
                //showCard1.backgroundColor = [UIColor colorWithPatternImage:dealtCard1.cardPic];
                [dealtCard1 drawCardPicture : showCard1  : dealtCard1.cardPic];
                [self updateDeckShownArea : dealtCard1 : 0];
                    }
            else
            {
                Card *dealtCard2 = [_Deck dealCard : showCard2];
                if (dealtCard2!=nil )
                {
                    [dealtCard2 drawCardPicture : showCard2  : dealtCard2.cardPic ];
                    
                    [self updateDeckShownArea : dealtCard1 : 1];
                    
                }
                else
                    return ;
                Card *dealtCard3 = [_Deck dealCard : showCard3];
                if (dealtCard3 !=nil)
                {
                    [dealtCard3 drawCardPicture : showCard3  : dealtCard3.cardPic ];
                   [self updateDeckShownArea : dealtCard1 : 2];                }
                else
                    return;
            }
        }
        else
            return;
    }
    // update Deck shown with new card from Deck
    
}


-(void) updateDeckShownArea : (Card*) dealtCard : (int) index
{
int countDeckArea = (int) [[_Deck deckShownArea] count];
if (countDeckArea>index)
    [[_Deck deckShownArea] replaceObjectAtIndex: index withObject: dealtCard] ;
else
    [[_Deck deckShownArea] addObject : dealtCard];
 }



- (CGRect ) inDropViewList: ( CGPoint ) locationInView
    {
   //  NSArray *subviews = _dragAreas;
        
        [_dropAreas  setArray : _dragAreas];
        NSArray *deckAreaCards = [[_Deck deckShownArea] copy];
        [_dropAreas removeObjectsInArray: deckAreaCards];
    
        
        int dropViewCount =(int)  [_dropAreas count];
        NSLog(@"InDropViewList...dropViewCount =%d",dropViewCount);
        UIView *subview = [[UIView alloc] init];
        
        if (dropViewCount >0)
            {
            for (int  subview_index = dropViewCount-1; subview_index >0; subview_index--)
                {
                subview = [_dropAreas objectAtIndex:subview_index];
                CGRect viewRect =  [subview frame];
                if (CGRectContainsPoint(viewRect, locationInView)==TRUE)
                    {
                NSLog(@"InDropViewList...return subview");
                return(viewRect);
                    }
                }
            }
        NSLog(@"InDropViewList...return nil");
        //viewRect =;
        return ( CGRectMake(0,0,0,0));
    }


- (CGRect ) inDragViewList: ( CGPoint ) locationInView
{
    //  NSArray *subviews = _dragAreas;
    int dragViewCount =(int)  [_dragAreas count];
    NSLog(@"inDragViewList...");
    UIView *subview = [[UIView alloc] init];
    if (dragViewCount >0)
        {
            for (int  subview_index = dragViewCount-1; subview_index >0; subview_index--)
                {
                subview = [_dragAreas objectAtIndex:subview_index];
                CGRect viewRect =  [subview frame];
                if (CGRectContainsPoint(viewRect, locationInView)==TRUE)
                    {
                    NSLog(@"inDragViewList...return subview");
                    return(viewRect);
                    }
                }
    }
    NSLog(@"inDragViewList...return nil");
    //viewRect =;
    return ( CGRectMake(0,0,0,0));
}




- (CGRect ) chkAreaByPoint : (NSArray *) viewArea : ( CGPoint ) locationInView
{
    //  NSArray *subviews = _dragAreas;
    int viewCount = (int)  [viewArea count];
    NSLog(@"chkViewByPoint...");
    UIView *view1 = [[UIView alloc] init];
    for (int  viewIdx = viewCount-1;  viewIdx >=0; viewIdx--)
    {
        view1 = [viewArea objectAtIndex:viewIdx];
        CGRect viewRect =  [view1 frame];
        if (CGRectContainsPoint(viewRect,locationInView)==TRUE)
        {
            NSLog(@"chkAreaByPoint...returning Rect");
            return(viewRect);
        }
    }
    NSLog(@"chkAreaByPoint...return nil");
    //viewRect =;
    return ( CGRectMake(0,0,0,0));
}




-(CGRect ) chkAreaByRect : (NSMutableArray *) viewArea : ( CGRect ) locationRect
{
    NSLog(@"chkAreaByRect...0");    //  NSArray *subviews = _dragAreas;
    int viewCount = (int)  [viewArea count];
    NSLog(@"chkAreaByRect...1");
    Card *view1 = [[Card alloc] init];
    NSLog(@"chkAreaByRect...2");
    for (int  viewIdx = viewCount-1;  viewIdx >=0; viewIdx--)
    {
        NSLog(@"chkAreaByRect...3");
        view1 = [viewArea objectAtIndex:viewIdx];
        NSLog(@"chkAreaByRect...4") ;
        CGRect viewRect =  view1.cardRect;
        if (CGRectEqualToRect(viewRect, locationRect)==TRUE)
        {
            NSLog(@"chkAreaByRect...returning Rect: TRUE");
            return(viewRect);
        }
    }
    NSLog(@"chkAreaByRect...return nil FALSE");
    //viewRect =;
    return ( CGRectMake(0,0,0,0));
}



- (void)dragDetected: (UIPanGestureRecognizer *)panGestureRecognizer
{
    NSLog(@"Drag Dectected 0 ");
    NSArray *subviews = [self.view subviews];
    CGPoint locationInView = [panGestureRecognizer locationInView:self.view];
    float x = locationInView.x;
    float y = locationInView.y;
    static float   dragCardOriginX;
    static float   dragCardOriginY;
    static int countStartingSubviews=0;
    
    //NB if subview dragged is not in draggable list return;
    // means al;l face up cards are added to draggable list
    
    dragCardOriginX=0; // viewRect.origin.x;
    dragCardOriginY=0; //  viewRect.origin.y;
    CGRect rectInView;
    NSLog(@"In DragDetected ");
    
    switch (panGestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:   //Drag Started
        {
            //Find Card from Drag Location
            rectInView =[self  inDragViewList :locationInView];
            if (CGRectIsEmpty(rectInView) )
            {
                NSLog(@"Drag Detected - Not Drag Area");
                panGestureRecognizer.enabled = NO;
                break;
            }
            else
            {
                NSLog(@"Drag Detected - Yes Drag Area");
                // Need to Check if Pan has occorred in Rects Bounded by CArds Out on Table
                // find CardArea to get card from
                /*
                 */
                
                NSMutableArray   *allAcesAreas = [self combineArrays: [_Deck clubsArea] :[_Deck heartsArea] : [_Deck spadesArea] : [_Deck diamondsArea]];
                
                
                // make Aces Area = clubsArea +spadesArea +    eartsArea +diamondsArea;
                // _cardInPlay.cardPic=CARDREVERSE;
                NSLog(@"In DragDetected rectInView before getCardfromrect Main=%@",NSStringFromCGRect(rectInView));
                NSLog(@"In DragDetected rectInView=%@",NSStringFromCGRect(rectInView));
                if (! (_cardInPlay= [_Deck getCardFromRect :[_Deck cardsMainArea] :rectInView]))
                {
                    NSLog(@"In DragDetected card not in Main *** rectInView=%@",NSStringFromCGRect(rectInView));
                    NSLog(@"DD card not in Main- About to chk Deck Shown Area rectInView=%@",NSStringFromCGRect(rectInView));
                    for (Card *c in [_Deck deckShownArea])
                    {
                        NSLog(@"DD Card c.cardVal=%d",c.cardVal);
                    }
                    NSLog(@"DD End Showing deckShown Area");
                    {
                        if ((_cardInPlay=[_Deck getCardFromRect: [_Deck deckShownArea] :rectInView ]))
                            NSLog(@"cardInPlay.cardPic - after deckShownArea -  getCardFromRect = %@",_cardInPlay.cardPic);
                        //if (!(_cardInPlay=getCardFromRect [_Deck acesArea] : rectInView))
                        else
                        {
                            if ((_cardInPlay=[_Deck getCardFromRect : allAcesAreas :rectInView ]))
                                NSLog(@"*** ACES AREA DETECTED ****");
                        }
                        NSLog(@"ERROR - CARD NOTFOUND ANYWHERE");
                    }
                }
                countStartingSubviews=(int) [subviews count];
                NSLog(@"**** UIGestureRecognizerStateBegan - Drag Started %@", NSStringFromCGPoint(locationInView));
                // NSLog(@"My view's frame is: %@", NSStringFromCGRect(self.view.frame));
                NSLog(@" Xpoint is %f",locationInView.x);
                // find view started
                NSLog(@"Subviews count %lu",(unsigned long) [subviews count]);
                NSLog(@"NOW FINd subview Point Location is in....");
                // NSLog(@"Count of number of subviews = %lu",q);
                // -(UIView *)findTopMostViewForPoint : (CGPoint) point
                //*** Need better way
                dragCardOriginX = x -10;//+  ((dragCardOriginX >10) ? -10 : 0);
                dragCardOriginY = y -11; //+  ((dragCardOriginY >10) ? -10 : 0);
                //dragCardOriginX=0;
                //var greeting = "Good" + ((now.getHours() > 17) ? " evening." : " day.");
                /*
                 CGRect tmpRect=CGRectMake( dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
                 
                 UIView *tmpView = [[UIView alloc] initWithFrame: tmpRect];
                 cardInView.frame=tmpRect;
                 */
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {//While Dragging
            dragCardOriginX = x -5;//+  ((dragCardOriginX >10) ? -10 : 0);
            dragCardOriginY = y -5; //+  ((dragCardOriginY >10) ? -10 : 0);
            NSLog(@"just before MAkeDragCardView dragCardOriginX %f, dragCardOriginY %f",dragCardOriginX,dragCardOriginY);
            [self makeDragCardView : dragCardOriginX : dragCardOriginY];
            NSLog(@"just after MAkeDragCardView dragCardOriginX %f, dragCardOriginY %f",dragCardOriginX,dragCardOriginY);
            //  NSLog(@"just after MAkeDragCardView");
            //   [self draggingCard ];
            
        }
            break;
        case UIGestureRecognizerStateEnded:    //Dropped!!!!!  - Dragging Ended
        {
            //drop Area = Drag Area- Deck Area
            NSLog(@"Dropped!!");
            
            //Delete Tails
            [self deleteSubViewTails :countStartingSubviews ];
            CGPoint dropLocationInView = [panGestureRecognizer locationInView:self.view];
            CGRect dropRectInView =[self  inDropViewList :dropLocationInView];
            NSLog(@"dropLocationInView =%@ ",NSStringFromCGRect(dropRectInView));
            NSLog(@"About to Check Drop  Area");
            
            if (CGRectIsEmpty(dropRectInView) )
            {
                NSLog(@"Drop Area - Not Droppable ");
                //panGestureRecognizer.enabled = NO;
                break;
            }
            else
                {
                // Find Specific Area to Drop To
                // Check Main Area
                NSLog(@"About to check if  Drop is in Main Area");
                    if (!CGRectIsEmpty ([self chkAreaByRect :_Deck.cardsMainArea :dropRectInView  ]))
                    {
                    NSLog(@"Drop in Main Area");
                NSLog(@"DROPPED - location Point %@", (NSStringFromCGPoint(dropLocationInView)));
                NSLog(@"DROPPED - location Rect %@", (NSStringFromCGRect(dropRectInView)));
                     
     int mainCardIndex=[_Deck maxVolIntersection : _Deck.cardsMainArea : dropRectInView ];
            Card *cardDroppingOn= [[Card alloc] init];
            cardDroppingOn = [_Deck.cardsMainArea objectAtIndex : mainCardIndex];
                        NSLog(@"Card with Biggest Volume = %d , cardSuit %d",cardDroppingOn.cardVal,cardDroppingOn.cardSuit);
                   // Main Area to Main Area
                        /*
                        [self moveToColumnByRect : dropRectInView : cardDroppingOn.cardRect];
                         */
                    /*   - Add to end of Main Area
                        - search  for rect in cardsMain
                        - make new  from it
                        - change new card from reverse to Face UP
                        -
                      */
                        
                    // Deck Area to Main Area
            // Check Card Logic - if OK AddCard to View
        UIView *newView = [self addNewCardView :  _cardInPlay : cardDroppingOn];
                        
                       
    [self updateDeckArea ];
                _cardInPlay.cardRect=newView.frame;
            [[_Deck cardsMainArea] addObject:_cardInPlay];
                        
                    
                    }
                else
                    {
                        NSLog(@"Drop Area not Main Area");
                    if (!CGRectIsEmpty ([self chkAreaByRect :_Deck.cardsAceArea :dropRectInView  ]))
                        {
                        NSLog(@"Drop in Aces Area");
                        }
                    
                
                // work out if dropped in an updatable area
               // if (! (_cardInPlay= [_Deck getCardFromRect :[_Deck cardsMainArea] :rectInView]))
                    
                    else
                        NSLog(@"Drop Area Area Unknown");
                    }
                }
        }
            break;
        default:
            NSLog(@"Error - Gesture State Not Recognised ");
            break;
        }
            if (panGestureRecognizer.state ==UIGestureRecognizerStateCancelled)
                panGestureRecognizer.enabled = YES;
            
            [self.view setNeedsDisplay];
            
}


-(void)updateDeckArea
{
    int count = (int)[_Deck.deckShownArea count];
    if (count >0)
        {
            Card *deckCard = [[_Deck deckShownArea]objectAtIndexedSubscript: count -1 ];
            // Remove DDeck Card from Deck Shown Area
            [_Deck.deckShownArea removeLastObject];
            //[];
            // find next Deck Subview usig Rect
            UIView *oldDeckView =[self deleteSubviewByRect : deckCard.cardRect];
            if (count-2 >= 0 )
                {
            Card *newDeckCard = [[_Deck deckShownArea] objectAtIndexedSubscript: count -2 ];
                UIView *newDeckView = [self findViewByRect : newDeckCard.cardRect ];
                [self updateDragArea: deckCard :newDeckView];
                }
            else
                
                if (count ==0)
                {
            Card *newDeckCard = [[_Deck deckShownArea] objectAtIndexedSubscript: 0];
            UIView *newDeckView = [self findViewByRect : newDeckCard.cardRect ];
            [self updateDragArea: deckCard :newDeckView];
                }
        }
}

                                     
                                     
                                     
                                     
-(void)updateDropArea : (Card*) oldCard : (UIView*) newView
{
    UIView *oldViewFound = [self findViewByRect : oldCard.cardRect];
    //if (oldViewFound!=nil)
      //  {
        [_dropAreas removeObjectIdenticalTo: oldViewFound];
        [_dropAreas addObject : newView];
        //}
    //else
      //  NSLog(@"Error : view not found : Drop Area");

}

-(void)updateDragArea : (Card*) oldCard : (UIView*) newView
{
     UIView *oldViewFound = [self findViewByRect : oldCard.cardRect];
   // if (oldViewFound!=nil)
     //   {
        [_dragAreas removeObjectIdenticalTo: oldViewFound];
        [_dragAreas addObject : newView];
       // }
   // else
     //   NSLog(@"Error : view not found : Drag Area");
}



-(UIView *) updateSuperView : (CGRect ) viewRect
{
    UIView* v;
    for (v  in [self.view subviews])
    {
        if (CGRectEqualToRect(v.frame,viewRect))
            [v removeFromSuperview];
    }
    return (v);
}


                                     
-(UIView *) findViewByRect : (CGRect ) viewRect
    {
    UIView* v;
        for (v  in [self.view subviews])
        {
            if (CGRectEqualToRect(v.frame,viewRect))
                break;
        }
        return (v);
    }
                     
                    
                     
                                     
                                     
                                     
                                     
-(UIView *) addNewCardView : (Card*) oldCard : (Card*) cardBeingAddedTo
{
    
    NSLog(@"addNewCardView : oldCard = %@",oldCard);
    float newXPos = cardBeingAddedTo.cardRect.origin.x;
    float newYPos = cardBeingAddedTo.cardRect.origin.y+CARDLENGTH/2;
    CGRect newRect = CGRectMake(newXPos,newYPos,  CARDWIDTH, CARDLENGTH);
    UIView *newView =[[UIView alloc] initWithFrame: newRect];
   
      [oldCard drawCardPicture : newView : oldCard.cardPic ];
      [[self view] addSubview:newView];
   // [self updateSuperView:oldCard.cardRect] ;
    
    [self updateDragArea:oldCard : newView];
    [self updateDropArea:oldCard :newView];
    //oldCard.cardRect = newRect; // Update Card
    
    return (newView);
}

    
-(void) deleteSubViewTails : (int)countStartingSubviews
    {
        NSArray *subviews = [self.view subviews];
        
        unsigned long CurrentSubviewCount = [subviews count];
        NSLog(@"DROPPED : CurrentSubviewCount = %lu,CountofStartingSubviews= %d",CurrentSubviewCount ,countStartingSubviews);
        
        for (int  i=(int) CurrentSubviewCount-(int)1 ; i>= (int) countStartingSubviews; i--)
        {
            UIView *subview = [subviews objectAtIndex:i];
            [subview removeFromSuperview];
            //[NSThread sleepForTimeInterval:0.6];
        }
    }
    



    

NSComparisonResult compare(UIView *firstView, UIView *secondView, void *context)
{
    if ( firstView.frame.origin.y < secondView.frame.origin.y)
        return NSOrderedAscending;
    else if (firstView.frame.origin.y > secondView.frame.origin.y)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


-(NSMutableArray *) combineArrays :(NSMutableArray *) array1 : (NSMutableArray *) array2 : (NSMutableArray *) array3 : (NSMutableArray *) array4

{
    if (array1!=nil)
    {
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[array1 arrayByAddingObjectsFromArray:array2]];
    NSMutableArray *newArray2 = [NSMutableArray arrayWithArray:[newArray arrayByAddingObjectsFromArray:array3]];

     NSMutableArray *newArray3 = [NSMutableArray arrayWithArray:[newArray2 arrayByAddingObjectsFromArray:array4]];
        
        return (newArray3);
    }
    else
        {
            NSLog(@"Error: 1st Array Passedto combine Arrays is nil");
            return( array1); // nil
        }
}



-(void) moveToColumnByRect : (CGRect ) origRect : (CGRect ) dropRect
{
    // This method sorts the rects coord by ypos in Array tomake sure they arein order before a move. it then moves all card above certain y value to simulate a column move.
    
    // Copy Subview Array
    NSMutableArray *subviewCopy= [NSMutableArray arrayWithArray :self.view.subviews];
    // Sort it usingCol Position
    NSArray *sortedViews = [subviewCopy sortedArrayUsingComparator: ^NSComparisonResult(UIView *obj1, UIView *obj2) {
                            if (obj1.frame.origin.y < obj2.frame.origin.y) {
                                return NSOrderedAscending;
                            } else if (obj1.frame.origin.y  > obj2.frame.origin.y) {
                                return NSOrderedDescending;
                            } else {
                                return NSOrderedSame;
                            }
                        }
                            ];

   
    // update dropRect Pos by card gap // will need to global variable or global object variable
    //for (UIView * view1 in  sortedViews) // find all subviews in column
    
 //   find all rects with same x (column )
 //   - find all rects with yvalu same and greater
 //   - update - update xand  and ypos by offset of rect dropping + new
    
        for (int i=0; i<[sortedViews count]; i++)
        {
            // subviews ***
      UIView *view1 = [sortedViews objectAtIndex:i];
        if (origRect.origin.y == view1.frame.origin.y)  // FindViews with Orig ColSize
            {
                ;  // create Copy of origrect
                CGRect newRect = CGRectMake(dropRect.origin.x, dropRect.origin.x +CARDOVERLAYGAP, origRect.size.height,origRect.size.width );
                _cardInPlay=[_Deck getCardFromRect :  [_Deck cardsMainArea] :  origRect];
                 
                 UIView *newView = [[UIView alloc] initWithFrame: newRect];
                newView.backgroundColor = [UIColor orangeColor];
                // need to do Card processing! also
                [self.view  addSubview: newView];
                [_cardInPlay drawCardPicture : newView : _cardInPlay.cardPic];
                [self deleteSubviewByRect : origRect ];
                
            }
        }
                        
}
                            
                            
- (UIView *) deleteSubviewByRect : (CGRect ) aRect
    {
        UIView *view1;
    for (int i=0; i<[self.view.subviews count]; i++)
        {
       view1 = [self.view.subviews objectAtIndex:i];
        if (CGRectEqualToRect(aRect, view1.frame))
            [view1 removeFromSuperview];
        }
        return (view1);
    }
                            
                            
    
- (void)didReceiveMemoryWarning
        {
            [super didReceiveMemoryWarning];
            // Dispose of any resources that can be recreated.
        }



-(void) makeDragCardView: (float) dragCardOriginX :(float) dragCardOriginY
{
    
    NSLog(@"in makeTmpCardView..\7dragCardOriginX %f,dragCardOriginY %f ",dragCardOriginX,dragCardOriginY);
    
    CGRect tmpRect=CGRectMake( dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
    //C dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
    
    UIView *tmpView = [[UIView alloc] initWithFrame: tmpRect];
    
    //   tmpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: _cardInPlay.cardPic] ];
    
    [_cardInPlay drawCardPicture :  tmpView : _cardInPlay.cardPic];
    [self.view addSubview: tmpView];
    [self.view setNeedsDisplay];

    
 //   unsigned long topSubviewCount = [subviews count];
    // UIView *topSubview = [subviews objectAtIndex:(int) topSubviewCount];
    //  CGRect  topviewRect =  [topSubview frame];
    // FOUMD
    
    /*  NSLog(@"checking intersection..%lu",CountOfStartingSubviews);
     for (int j= (int) CountOfStartingSubviews-1; j>0; j--)
     {
     UIView *subview = [subviews objectAtIndex:j];
     CGRect checkViewRect=[subview frame];
     if (CGRectIntersectsRect(tmpRect, checkViewRect))
     {
     NSLog(@"Found interection");
     subview.backgroundColor = [UIColor blueColor];
     }
     } */
     
     }


-( void )draggingCard
    {
     
       /*
        if ((_cardInPlay =[_Deck  getCardFromSubViewRect : cardInView.frame])==nil)
        {
            NSLog(@"Error - NO Card found from Subview");
            panGestureRecognizer.enabled = NO;
            break;
        }
        
        
        NSLog(@"drag detected ==> aSubview.frame = %@  ",NSStringFromCGRect(cardInView.frame));
        
        
        NSLog(@"Card found from Subview = %@" , _cardInPlay.cardPic);
        
        */
        unsigned long dragAreaCount = [_dragAreas count];
         /*
       // NSLog(@"drag detected ==> aSubview.frame = %@  ",NSStringFromCGRect(cardInView.frame));
        
        
        
        // MAKE SUBVIEW RED
        NSLog(@"Leaving Drag Detected : dragArea count =  %lu",(unsigned long)[_dragAreas count]);
        NSLog(@"dragAreaCounbt = %lu",dragAreaCount);
        UIColor *colorSave = nil;
        for (int j=0; j<(int) dragAreaCount; j++)
        {
            UIView *dropView = [_dragAreas objectAtIndex:j];
            NSLog(@"Checking dragrect in dragArea %@\nj= %d",dropView,j);
            
            CGRect checkViewRect=[dropView frame];
            NSLog(@"About to compare Intersection of  dragArea j= %d",j);
            
            NSLog(@"tmpRect =%@",NSStringFromCGRect(tmpRect));
            NSLog(@"CheckViewRect =%@",NSStringFromCGRect(checkViewRect));
            
 
            if (CGRectIntersectsRect(tmpRect, checkViewRect))  //they interSect
            {
                
                // *** show some animation to show could be dropped...
                
                // CGRect newFrame = dropView.frame;
                CGRect oldFrame = dropView.frame;
                
                
                NSLog(@"Found interection....");
   */
        
            /*
             else
             {
             if (dropView.backgroundColor == [UIColor blueColor])
             {
             dropView.backgroundColor = RANDOM_COLOR;
             }
             }
             */
            
        }



-(void) setupAllView
{
    self.view.userInteractionEnabled = YES;
    [self.view setAutoresizesSubviews:YES];
    // dragArea and dropArea -hold Views that
    // can be dragged or dropped to
    _dragAreas=[[NSMutableArray alloc] initWithCapacity:52];
    _dropAreas=[[NSMutableArray alloc] initWithCapacity:52];
    
    
    
    // Linking Pan Gesture Recogniser to entire view - as need to make it easier once item is dragged.
    UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDetected:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.enabled = YES;
    [self.view addGestureRecognizer:panGesture];
    
    
    
}
@end