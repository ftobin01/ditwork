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

#include "constants.h"


@interface ViewController ()

@property NSMutableArray *dropAreas;
@property NSArray *subviews;
@property UIImage *globalCardImage;
@property (nonatomic, strong) Card    *cardInPlay;


// Sinks for Cards
@property (nonatomic,strong) DeckObj *Deck;

-(void)  showDeck;
-(CGRect ) inSubViewList : ( CGPoint ) locationInView;
-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
//-(Card *) getCardFromSubView : (CGRect *) aRect;
//- (void) deleteSubViewByRect : (CGRect ) aRect;
@end


@implementation ViewController

//- (IBAction)tapDetected:(id)sender {
//}
-(void) setupAllView
    {
        self.view.userInteractionEnabled = YES;
        [self.view setAutoresizesSubviews:YES];
        
        // Linking Pan Gesture Recogniser to entire view - as need to make it easier once item is dragged.
        UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDetected:)];
        panGesture.minimumNumberOfTouches = 1;
        panGesture.enabled = YES;
        [self.view addGestureRecognizer:panGesture];
        
      
    
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        _dropAreas=[NSMutableArray array];

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
   
    NSLog(@"Leaving ViewDidload  8 dropArea count =  %d",(int ) [_dropAreas count]);
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
    }
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
            [self drawCardPicture: view1 : CARDREVERSE];
            
            //[self drawCardPicture: view1 : dealtCard.cardPic];
            
            [[self view] addSubview:view1];
            
            cardRow+=CARDLENGTH/2;
        }
        // Section - For Last card Each Column
        j+=CARDWIDTH + GAPBETWEENCARDS;
        cardRow=CARDSTARTPOS;
        
        // Adding last card area in Each column as a draggable area.
        // [_dropAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable
        
        NSLog(@"viewDidLoad 1");
        [_dropAreas addObject: view1];      // Add last Card in Column to Droppable Area
        
        NSLog(@"viewDidLoad 2");       // Show its Real Face
        NSString *picFile =[_Deck getPicFileName :dealtCard];
        
        NSLog(@"viewDidLoad 2.5 ==> picFile = %@",picFile);
        [self drawCardPicture : view1 : picFile ];
        
        NSLog(@"viewDidLoad 3");
    }
}









-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName
{
   /* sizes image to card view */
    NSLog(@"drawCardPicture 1. PicName=%@",cardPicName);
    
        UIGraphicsBeginImageContext(view1.frame.size);
        [[UIImage imageNamed: cardPicName] drawInRect:view1.bounds];
    NSLog(@"drawCardPicture 2. PicName=%@",cardPicName);
_globalCardImage= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
       NSLog(@"drawCardPicture 3. PicName=%@",cardPicName);
    view1.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage ];
      //view1.backgroundColor = [UIColor colorWithWhite:.5f alpha: .5f];
    
    //else if you want it to be another color use the general UIColor method: +colorWithRed:green:blue:alpha:    ];
       NSLog(@"Leaving drawCardPicture 4. PicName=%@",cardPicName);
    
    
    
}


-  (UIImage *)  imageTint :(NSString *) name withTintColor: (UIColor *) tintColor
{
    
    UIImage *baseImage = [UIImage imageNamed:name];
    
    CGRect drawRect = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(baseImage.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, baseImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // draw original image
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, drawRect, baseImage.CGImage);
    
    // draw color atop
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGContextFillRect(context, drawRect);
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
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
    static BOOL SHOW_3_CARDS= TRUE;
    static BOOL DECK_SHOWN=FALSE;
    static UIView *showCard1;       //change to show card view
    static UIView *showCard2;
    static UIView *showCard3;
    if (!DECK_SHOWN)
    // need at least 1 view
        {
            NSLog(@"calling showDeck");
            CGRect cardRect1 = CGRectMake( SHOWDECK_XPOS, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
            showCard1 = [[UIView alloc] initWithFrame:cardRect1];
            Card *dealtCard1= [_Deck dealCard : showCard1];
            [self drawCardPicture : showCard1  : dealtCard1.cardPic];
            [self.view addSubview: showCard1];
            [[_Deck deckShownArea] addObject: dealtCard1];
            
            if (SHOW_3_CARDS==TRUE)
                {
                    
                    CGRect cardRect2 = CGRectMake( SHOWDECK_XPOS+10, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                    showCard2=[[UIView alloc] initWithFrame:cardRect2];
                    Card *dealtCard2= [_Deck dealCard : showCard2];
                    if ( dealtCard2  !=nil)
                        {
                            //  [_dropAreas addObject: showCard2];
                            [self.view addSubview: showCard2];
                            Card *dealtCard2= [_Deck dealCard : showCard2];
                            
                            [self drawCardPicture : showCard2  : dealtCard2.cardPic];
                NSLog(@"showDeck: adding dealtCard2.cardPic =%@",dealtCard2.cardPic);
                            [[_Deck deckShownArea] addObject: dealtCard2];
                            [_dropAreas removeLastObject];
                            [_dropAreas addObject: showCard2];
                            
                            CGRect cardRect3 = CGRectMake( SHOWDECK_XPOS+20, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                            showCard3=[[UIView alloc] initWithFrame:cardRect3];
                            Card *dealtCard3= [_Deck dealCard : showCard3];
                            if ( dealtCard3  !=nil)
                                {
                                [self drawCardPicture : showCard3  : dealtCard3.cardPic];
         NSLog(@"showDeck: adding dealtCard3.cardPic =%@",dealtCard2.cardPic);                                    [[_Deck deckShownArea] addObject: dealtCard3];
                                    
                NSLog(@"showDeck: after adding dealtCard2.cardPic =%@",[[_Deck deckShownArea] objectAtIndex: 1] );
                                                                
                                    [_dropAreas removeLastObject];
                                    [_dropAreas addObject: showCard3];
                                    [self.view addSubview: showCard3];
                            
                                    
                                }
                        }
            else
                [_dropAreas addObject: showCard1];
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
                [self drawCardPicture : showCard1  : dealtCard1.cardPic];
                [[_Deck deckShownArea] replaceObjectAtIndex:0 withObject: dealtCard1];
                }
                else
                    {
                    Card *dealtCard2 = [_Deck dealCard : showCard2];
                    if (dealtCard2!=nil )
                        {
                        [self drawCardPicture : showCard2  : dealtCard2.cardPic ];
                        [[_Deck deckShownArea] replaceObjectAtIndex:1 withObject: dealtCard2];
                    }
                    else
                        return ;
                    Card *dealtCard3 = [_Deck dealCard : showCard3];
                    if (dealtCard3 !=nil)
                        {
                        [self drawCardPicture : showCard3  : dealtCard3.cardPic ];
                            [[_Deck deckShownArea] replaceObjectAtIndex:2 withObject: dealtCard3];
                        }
                    else
                        return;
                }
            }
           else
               return;
    }
            // update Deck shown with new card from Deck

}


    
- (CGRect ) inSubViewList: ( CGPoint ) locationInView
    {
   //  NSArray *subviews = _dropAreas;
        int CurrentSubviewCount =(int)  [_dropAreas count];
        NSLog(@"InSubViewList...");
        UIView *subview = [[UIView alloc] init];
        for (int  subview_index = CurrentSubviewCount-1; subview_index >=0; subview_index--)
        {
            subview = [_dropAreas objectAtIndex:subview_index];
            CGRect viewRect =  [subview frame];
            if (CGRectContainsPoint(viewRect, locationInView)==TRUE)
            {
                NSLog(@"InSubViewList...return subview");
                return(viewRect);
            }
        }
        NSLog(@"InSubViewList...return nil");
        //viewRect =;
        return ( CGRectMake(0,0,0,0));
    }




- (CGRect ) chkAreaByPoint : (NSArray *) viewArea : ( CGPoint ) locationInView
{
    //  NSArray *subviews = _dropAreas;
    int viewCount = (int)  [viewArea count];
    NSLog(@"chkViewByPoint...");
    UIView *view1 = [[UIView alloc] init];
    for (int  viewIdx = viewCount-1;  viewIdx >=0; viewIdx--)
    {
        view1 = [viewArea objectAtIndex:viewIdx];
        CGRect viewRect =  [view1 frame];
        if (CGRectContainsPoint(viewRect, locationInView)==TRUE)
        {
            NSLog(@"chkAreaByPoint...returning Rect");
            return(viewRect);
        }
    }
    NSLog(@"chkAreaByPoint...return nil");
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
    static unsigned long CountOfStartingSubviews=0;
    
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
            rectInView =[self  inSubViewList :locationInView];
            
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
                // make Aces Area = clubsArea +spadesArea +    eartsArea +diamondsArea;
               // _cardInPlay.cardPic=CARDREVERSE;
                 NSLog(@"In DragDetected rectInView before getCardfromrect Main=%@",NSStringFromCGRect(rectInView));
                NSLog(@"In DragDetected rectInView=%@",NSStringFromCGRect(rectInView));                if (! (_cardInPlay= [_Deck getCardFromRect :[_Deck cardsMainArea] :rectInView]))
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
                            NSLog(@"ERROR - CARD NOTFOUND ANYWHERE");
                        }
                    }
                CountOfStartingSubviews=[subviews count];
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
            CGPoint dropLocationInView = [panGestureRecognizer locationInView:self.view];
            NSLog(@"DROPPED UIGestureRecogniserStateEnded %@", (NSStringFromCGPoint(dropLocationInView)));
            
            unsigned long CurrentSubviewCount = [subviews count];
            NSLog(@"CurrentSubviewCount = %lu, Count ofStartingSubviews= %lu", CurrentSubviewCount ,CountOfStartingSubviews);
            for (int  i=(int) CurrentSubviewCount-(int)1 ; i>= (int) CountOfStartingSubviews; i--)
            {
                UIView *subview = [subviews objectAtIndex:i];
                [subview removeFromSuperview];
                //[NSThread sleepForTimeInterval:0.6];
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

NSComparisonResult compare(UIView *firstView, UIView *secondView, void *context)
{
    if ( firstView.frame.origin.y < secondView.frame.origin.y)
        return NSOrderedAscending;
    else if (firstView.frame.origin.y > secondView.frame.origin.y)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}





-(void) moveToColumnByRect : (CGRect ) origRect : (CGRect ) dropRect
{
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
                [self drawCardPicture : newView : _cardInPlay.cardPic];
                [self deleteSubviewByRect : origRect ];
                
            }
        }
                        
}
                            
                            
- (void) deleteSubviewByRect : (CGRect ) aRect
    {
    for (int i=0; i<[self.view.subviews count]; i++)
        {
        UIView *view1 = [self.view.subviews objectAtIndex:i];
        if (aRect.origin.y == view1.frame.origin.y)
            [view1 removeFromSuperview];
        }
    
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
    
    [self drawCardPicture :  tmpView : _cardInPlay.cardPic];
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
        unsigned long dropAreaCount = [_dropAreas count];
         /*
       // NSLog(@"drag detected ==> aSubview.frame = %@  ",NSStringFromCGRect(cardInView.frame));
        
        
        
        // MAKE SUBVIEW RED
        NSLog(@"Leaving Drag Detected : dropArea count =  %lu",(unsigned long)[_dropAreas count]);
        NSLog(@"DropAreaCounbt = %lu",dropAreaCount);
        UIColor *colorSave = nil;
        for (int j=0; j<(int) dropAreaCount; j++)
        {
            UIView *dropView = [_dropAreas objectAtIndex:j];
            NSLog(@"Checking dragrect in dropArea %@\nj= %d",dropView,j);
            
            CGRect checkViewRect=[dropView frame];
            NSLog(@"About to compare Intersection of  dropArea j= %d",j);
            
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




-(int ) maxVolIntersection : (NSMutableArray *)ViewsToCheck : (CGRect) rectToChk
{
    int maxVol;
    CGRect intVol;
    int maxVolIndex=0;
    
    for (int i=0; i<[ViewsToCheck count]; i++)
        {
            UIView   *checkView =(UIView *) [ViewsToCheck objectAtIndex : i];
            CGRect viewRect = checkView.frame;
            CGRect intersectVolRect=CGRectIntersection(rectToChk,viewRect);
                if (!CGRectIsNull(intVol)) // ! CGRectNull - they Intersect volume returned
                    {
                        int intersectVol = intersectVolRect.size.height * intersectVolRect.size.width;
                        if (intersectVol > maxVol)
                            {
                            maxVol=intersectVol;
                            maxVolIndex = i;
                            }
                    }
        }
    return(maxVolIndex);
}



-(void) EndOfGameAnimation
    {
        
        // Depending On Suit:
        // for any Cards in Main Area  - animated move to Aces Are
        // forAny Cards in DeckShown Are move to0 aces Area
        // for Any cards in Deck - Show Face and Move To Aces Area
      /*
        for (Card *c in [_Deck mainCardsArea))
            {
                //if (!c.cardFaceUp)
                             //get Card picture
                             // show picture
                             
         
            UIView.animateWithDuration(0.5, delay: 0.3, options: nil, animations: {
                    self.username.center.x += self.view.bounds.width
            }, completion: nil);
                
                
                
            }
       */
    }

@end