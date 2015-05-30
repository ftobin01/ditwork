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
@property(nonatomic,strong) DeckObj  *CardsMainArea;     // Cards in Solitaire Screen
@property (nonatomic,strong) DeckObj  *CardsClubsArea;
@property (nonatomic,strong) DeckObj  *CardsHeartsArea;
@property(nonatomic,strong) DeckObj  *CardsDiamondsArea;
@property (nonatomic,strong) DeckObj  *CardsSpadesArea;



-(void)  showDeck;
-(CGRect ) inSubViewList : ( CGPoint ) locationInView;
-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
-(Card *) getCardFromSubView : (CGRect *) aRect;

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
            dealtCard = [_Deck dealCard];               // Deal a Card
            NSLog(@" Deck dealcard.cardval %d",dealtCard.cardVal);
            
            aRect = CGRectMake( j, cardRow, CARDWIDTH, CARDLENGTH);
            view1 = [[UIView alloc] initWithFrame:aRect];
            
            _Deck.cardRect = aRect;  // assign View made to card
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
    static UIView *showCard1;
    static UIView *showCard2;
    static UIView *showCard3;
    
    if (!DECK_SHOWN)
    // need at least 1 view
        {
            NSLog(@"calling showDeck");
            CGRect cardRect1 = CGRectMake( SHOWDECK_XPOS, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
            showCard1 = [[UIView alloc] initWithFrame:cardRect1];
            showCard1.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];
            [self.view addSubview: showCard1];
            [_dropAreas addObject: showCard1];
 
            if (SHOW_3_CARDS==TRUE)
                {

                CGRect cardRect2 = CGRectMake( SHOWDECK_XPOS+10, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                showCard2=[[UIView alloc] initWithFrame:cardRect2];
            showCard2.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];                CGRect cardRect3 = CGRectMake( SHOWDECK_XPOS+20, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                showCard3=[[UIView alloc] initWithFrame:cardRect3];
            showCard3.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];                //  if not Created  add subview
            NSLog(@"Adding ShowDEcdk Card  2 and ShowDeck Card 3");
                [self.view addSubview: showCard2];
                [self.view addSubview: showCard3];
                
                // change Draggable Area from 1 card to 3rd Card
                [_dropAreas removeLastObject];
                [_dropAreas addObject: showCard3];
                
                }

             DECK_SHOWN=TRUE;
             }
    else
            {
                Card *dealtCard1= [_Deck dealCard];
                if ( dealtCard1  !=nil)
                {
                // Deal 1 card
                if (SHOW_3_CARDS==FALSE)
                {
                 //showCard1.backgroundColor = [UIColor colorWithPatternImage:dealtCard1.cardPic];
                    [self drawCardPicture : showCard1  : dealtCard1.cardPic];
                }
                else
                {
                    Card *dealtCard2 = [_Deck dealCard];
                    if (dealtCard2!=nil )
                            [self drawCardPicture : showCard2  : dealtCard2.cardPic ];
                    else
                        return ;
                    Card *dealtCard3 = [_Deck dealCard];
                    if (dealtCard3 !=nil)
                        [self drawCardPicture : showCard3  : dealtCard3.cardPic ];
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
            ;
    // [_dropAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
            subview = [_dropAreas objectAtIndex:subview_index];
    //    if(!subview.hidden && CGRectContainsPoint(subview.frame, point))
    //CGPoint pointConverted = [self.view convertPoint:point toView:subview];
    //for (UIView *subview in self.view.subviews)
    
   // NSLog(@"==>subview [i] = %lu ",(unsigned long) subview_index);
       // we want locations thtat are in top view except the last view.
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




    /*
     
     CGRect someRect;
     
     
     
     // enemy hit?
     //    CGRect enemyRect = CGRectMake(0, 0, 100, 200);
     // CGPoint hitPoint = CGPointMake(x, y); -- this is already got through locaation popint-
     // now we just use the array of subviews and find the subview thats a hit!
     
     unsigned long i;
     unsigned long v;
     NSLog(@"i=%lu, v= %lu",i,v);
     
     
     //listSubviewsOfView: _view;
     
     //_subviews = [self.view subviews] ;
     NSLog(@"In list Subview  2 : subview count %lu",(unsigned long)[self.subviews count]);
     // Return if there are no subviews
     //  if ([subviews count] == 0) return;
     
     // for (UIView *subview in subviews) {
     
     //  NSLog(@"%@", subview);
     
     // List the subviews of subview
     //[self listSubviewsOfView:subview];
     //   }
     
     
     
     
     
     i = [_rectArray count];
     //    for (v=0;v<i; v++)
     //      {
     someRect = [[_rectArray objectAtIndex:v] CGRectValue];
     //         NSLog(@"%@",someRect);
     
     // }
     */

    

    /*
     
     - (void)listSubviewsOfView:(UIView *)view {
     
     // Get the subviews of the view
     NSArray *subviews = [view subviews];
     //    NSLog(@"In list Subview : subview count %@",[subviews count]);
     // Return if there are no subviews
     if ([subviews count] == 0) return;
     
     for (UIView *subview in subviews) {
     
     NSLog(@"%@", subview);
     
     // List the subviews of subview
     [self listSubviewsOfView:subview];
     }
     
     
     }
     
     */
    
    
    /*
     
     
     -(UIView *)findTopMostViewForPoint : (CGPoint) point
     {for (int  i=(int) self.subviews.count -(int) 1; i>=0; i--)
     {
     UIView *subview = [self.subviews objectAtIndex:i];
     if(!subview.hidden && CGRectContainsPoint(subview.frame, point))
     {
     //CGPoint pointConverted = [self.view convertPoint:point toView:subview];
     
     return subview;
     }
     
     }
     return self.view;
     
     }
     
     
     */




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
    static UIView *subviewFound=nil;
    
    UIView *cardInView;
    
    //NB if subview dragged is not in draggable list return;
    // means al;l face up cards are added to draggable list
    
    dragCardOriginX=0; // viewRect.origin.x;
    dragCardOriginY=0; //  viewRect.origin.y;
    CGRect rectInView;
    switch (panGestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:   //Drag Started
        {
            rectInView =[self  inSubViewList :locationInView];
            
            if (CGRectIsEmpty(rectInView) )
            {
                NSLog(@"in SubviewList FALSE- maybe check higher up");
                //panGestureRecognizer.cancelsTouchesInView=YES;
                // panGestureRecognizer.delaysTouchesBegan=YES;
                //panGestureRecognizer.RequiredToFailByGestureRecognize=YES;
                panGestureRecognizer.enabled = NO;                //   [
                //panGestureRecognizer.delaysTouchesEnded=YES;
                break;
            }
            else
            {
                // Need to Check if Pan has occorred in Rects Bounded by CArds Out on Table
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
                
                CGRect tmpRect=CGRectMake( dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
                
                UIView *tmpView = [[UIView alloc] initWithFrame: tmpRect];
                
                cardInView.frame=tmpRect;
            }
            
        }
            
            break;
        case UIGestureRecognizerStateChanged:  //While Dragging
        {
            
            
            unsigned long dropAreaCount = [_dropAreas count];
            
            dragCardOriginX = x -10;//+  ((dragCardOriginX >10) ? -10 : 0);
            dragCardOriginY = y -11; //+  ((dragCardOriginY >10) ? -10 : 0);
            //dragCardOriginX=0;
            //var greeting = "Good" + ((now.getHours() > 17) ? " evening." : " day.");
            NSLog(@"drag detected ==> aSubview.frame = %@  ",NSStringFromCGRect(cardInView.frame));
            
            if ((_cardInPlay =[_Deck  getCardFromSubView : cardInView.frame])==nil)
                NSLog(@"Error - NO Card found from Subview");
            else
                NSLog(@"Card found from Subview = %@" , _cardInPlay.cardPic);
            
            CGRect tmpRect=CGRectMake( dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
            //C dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
            
            UIView *tmpView = [[UIView alloc] initWithFrame: tmpRect];
            
            //   tmpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: _cardInPlay.cardPic] ];
            
            [self drawCardPicture :  tmpView : _cardInPlay.cardPic];
            
            [self.view addSubview: tmpView];
            
            [self.view setNeedsDisplay];
            
            
            unsigned long topSubviewCount = [subviews count];
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
             }
             */
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
                    
                    //  newFrame.size.width  = 40.0f;
                    //  newFrame.size.height = 50.0f;
                    
                    // shift right by 500pts
                    
                    //(void)applyDefaultStyle {
                    // curve the corners
                    
                    /*
                     self.view.layer.cornerRadius = 4;
                     
                     // apply the border
                     self.view.layer.borderWidth = 1.0;
                     self.view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                     
                     // add the drop shadow
                     self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
                     self.view.layer.shadowOffset = CGSizeMake(2.0, 2.0);
                     self.view.layer.shadowOpacity = 0.25;
                     
                     */
                    
                    //   }
                    
                    //      dropView.backgroundColor=[UIColor orangeColor];
                    // dropView.tintColor=[UIColor orangeColor];
                    ;
                    
                    //   dropView.background = dropView.background + [UIColor colorWithWhite:.5 alpha:.5];
                    /*
                     else if you want it to be another color use the general UIColor method: +colorWithRed:green:blue:alpha:
                     */
                    
                    
                    
                    
                    NSLog(@"Found interection....");
                    //dropView.backgroundColor = [UIColor blueColor];
                    // tmpView.backgroundColor  = [UIColor blueColor];
                    /*
                     [UIView animateWithDuration:1.0
                     animations:^{
                     dropView.frame = oldFrame;
                     dropView.frame=oldFrame;                                    }];
                     */
                    // dropView.frame = oldFrame;
                    float hue=.669;
                    float saturation=.3;
                    float brightness=.9;
                    float alpha= .5;
                    
                    //      dropView.backgroundColor=[UIColor colorWithHue: hue
                    //saturation:saturation
                    //brightness: brightness
                    //alpha: alpha];
                    
                }
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
            
            
        }
            break;
        case UIGestureRecognizerStateEnded:    //Drop - Dragging Ended
        {
            CGPoint dropLocationInView = [panGestureRecognizer locationInView:self.view];
            NSLog(@"DROPPED UIGestureRecogniserStateEnded %@", NSStringFromCGPoint(dropLocationInView));
            
            //DElete All subviews created since Drag Started
            // Delete Forward if dropped on target
            // Delete Backward if nnot found;
            // Check Array of Dropable Areaqs - Eg Aces location - 7 face up card Rectangles
            //          for (UIView *subview in DroppableAreas)
            //          {
            //              CGRect subRect = subview.frame;
            
            
            //          }
            //GET LAWST SUBVIEW
            /*
             unsigned long topSubviewCount = [subviews count];
             UIView *topSubview = [subviews objectAtIndex:(int) topSubviewCount];
             CGRect  topviewRect =  [topSubview frame];
             // FOUMD
             for (int j=0; j< CountOfStartingSubviews-1; j++)
             {
             UIView *subview = [subviews objectAtIndex:j];
             CGRect checkViewRect=[subview frame];
             if (CGRectIntersectsRect(topviewRect, checkViewRect))
             {
             subview.backgroundColor = [UIColor blueColor];
             }
             }
             // MAKE SUBVIEW RED
             
             */
            //Not Found
            unsigned long CurrentSubviewCount = [subviews count];
            NSLog(@"CurrentSubviewCount = %lu, Count ofStartingSubviews= %lu", CurrentSubviewCount ,CountOfStartingSubviews);
            for (int  i=(int) CurrentSubviewCount-(int)1 ; i>= (int) CountOfStartingSubviews; i--)
            {
                
                UIView *subview = [subviews objectAtIndex:i];
                
                [subview removeFromSuperview];
                //[NSThread sleepForTimeInterval:0.6];
                
            }
            // [self.view sendSubviewToBack :subviewFound];
            
            //    for (UIView *dropView in _subviews)
            
            // if (CGRectIntersectsRect(playerRect, mineRect))
            // {
            // OUCH! Found Card to Drag to;
            // }
            
            ;
            /*
             
             [UIView animateWithDuration:.5
             animations:^{
             dropView.frame = oldFrame;
             [self drawCardPicture :  dropView : _cardInPlay.cardPic];
             
             
             }];
             
             */
            
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





    
- (void)didReceiveMemoryWarning
        {
            [super didReceiveMemoryWarning];
            // Dispose of any resources that can be recreated.
        }
    
    
    
@end
    
