//
//  ViewController.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#define RANDOM_COLOR                                                           \
[UIColor colorWithRed : (CGFloat)random() / (CGFloat)RAND_MAX green : (CGFloat)random() / (CGFloat)RAND_MAX blue : (CGFloat)random() / (CGFloat)RAND_MAX alpha : 1.0]

//#ifdef NDEBUG
#ifdef NDEBUG              // NO DEBUG or RELEASE MODE   - Tiredof stopping for mispelt NSLOG DEbug mssages
#define          MYLOG  MyLog(...)
#define          MYLOg  MyLog(...)
#define          MYLog  MyLog(...)
#define          MYlog  MyLog(...)
#define          Mylog  MyLog(...)
#define          MyLOG  MyLog(...)
#define          MYloG  MyLog(...)

#define          MYLONGLOG
#else
#define             MYLOG  NSLog
#define             MYLOg  NSLog
#define             MYLog  NSLog
#define             MYlog  NSLog
#define             Mylog  NSLog
#define             MyLOG  NSLog
#define             MYloG  NSLog

#define             MYLONGLOG     NSLog(@"%_func %s, _line %d, _file %s, calling _func %s", __func__, __Line__, __File__, __PRETTY_FUNCTION__);
#endif

#define     MAXCARDROWS        8
#define     MAXCARDCOLUMNS     7

#define     CARDWIDTH           33.0
#define     CARDLENGTH          60.0

#define     GAPBETWEENCARDS     8
#define     GAPBETWEENACECARDS     5

#define     CARDSTARTPOS        40
#define     CARDSTARTROW        GAPBETWEENCARDS

#define     ACECARDSTARTPOS     xx

#define     DECKCARD_XPOS     14
#define     DECKCARD_YPOS    ( (MAXCARDROWS-2) * CARDLENGTH )


#import "ViewController.h"
#import "Deck.h"


@interface ViewController ()




@property NSMutableArray *dropAreas;
@property NSArray *subviews;
@property UIImage *globalCardImage;
@property Card    *cardInPlay;
@property (nonatomic,strong) DeckObj *Deck;


-(void)  showDeck;
-(BOOL) inSubViewList : ( CGPoint ) locationInView;
-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName;
@end


@implementation ViewController

//- (IBAction)tapDetected:(id)sender {
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int i=0;
    float j=15;
    float cardRow=CARDSTARTPOS;
    
    
    _dropAreas=[NSMutableArray array];
    
    CGRect aRect;
    NSArray *subviews = [NSArray array];
    UIView *view1;
    
    UIColor *rndColor= RANDOM_COLOR;
   
    self.view.userInteractionEnabled = YES;
    // Linking Pan Gesture Recogniser to entire view - as need to make it easier once item is dragged.
    UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDetected:)];
    panGesture.minimumNumberOfTouches = 1;
 //   panGesture.delegate = self; // Very important
    [self.view addGestureRecognizer:panGesture];
    
    
    //
     static bool done=FALSE;
    if(done==FALSE)
        {
        _Deck = [[DeckObj alloc] init];
        [_Deck  initDeck];
        done=TRUE;
        }
    Card *dealtCard;
    
    for (int cardColumnIndex=0; cardColumnIndex<MAXCARDCOLUMNS; cardColumnIndex++)
        {
        for ( i=0; i<= cardColumnIndex; i++)
        {
            dealtCard = [[Card alloc] init];
            dealtCard = [_Deck dealCard];
            NSLog(@" Deck dealcard.cardval %d",dealtCard.cardVal);

            aRect = CGRectMake( j, cardRow, CARDWIDTH, CARDLENGTH);
            view1 = [[UIView alloc] initWithFrame:aRect];
            
            _Deck.cardRect = aRect;  // assign View made to card
            
            NSString *cardFace =dealtCard.cardPic;
            NSLog(@"cardFace = %@", cardFace);
            
            [self drawCardPicture: view1 : cardFace];
            [[self view] addSubview:view1];
            
            cardRow+=CARDLENGTH/2;
            
            
        }
        
        // [view setNeedsDisplay];
        j+=CARDWIDTH + GAPBETWEENCARDS;
        cardRow=CARDSTARTPOS;
        
        // cardColor= RANDOM_COLOR;
        // Adding last card area in Each column as a draggable area.
        NSLog(@"Adding Drop Area ");
        NSLog(@"Frame f = %@", NSStringFromCGRect(aRect));
            
        // [_dropAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
            
            NSLog(@"viewDidLoad 1");
        [_dropAreas addObject: view1];
            
             NSLog(@"viewDidLoad 2");
            NSString *picFile =[_Deck getPicFileName :dealtCard];
            NSLog(@"viewDidLoad 2.5");
            [self drawCardPicture : view1 : picFile ];
             NSLog(@"viewDidLoad 3");            // find cars
            
            
            //Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
        NSLog(@"Just After Adding  dropArea count =  %d",(int)[_dropAreas count]);
             NSLog(@"viewDidLoad 4");
        }
    
    
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
  
    [self.view addGestureRecognizer:tapGesture];
    
}


-( void ) drawCardPicture : (UIView *)  view1 : (NSString *)cardPicName
{
    NSLog(@"drawCardPicture 1. PicName=%@",cardPicName);
    
        UIGraphicsBeginImageContext(view1.frame.size);
        [[UIImage imageNamed: cardPicName] drawInRect:view1.bounds];
    NSLog(@"drawCardPicture 2. PicName=%@",cardPicName);
_globalCardImage= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
       NSLog(@"drawCardPicture 3. PicName=%@",cardPicName);
          view1.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];
       NSLog(@"Leaving drawCardPicture 4. PicName=%@",cardPicName);
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
    static BOOL SHOW_3_CARDS= FALSE;
    static BOOL DECK_SHOWN=FALSE;
    
    if (!DECK_SHOWN)
    // need at least 1 view
        {
            NSLog(@"calling showDeck");
            CGRect cardRect1 = CGRectMake( SHOWDECK_XPOS, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
            UIView *showCard1 = [[UIView alloc] initWithFrame:cardRect1];
            showCard1.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];
            [self.view addSubview: showCard1];
            [_dropAreas addObject: showCard1];
 
    if (SHOW_3_CARDS==TRUE)
            {

                CGRect cardRect2 = CGRectMake( SHOWDECK_XPOS+10, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                UIView *showCard2=[[UIView alloc] initWithFrame:cardRect2];
            showCard2.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];                CGRect cardRect3 = CGRectMake( SHOWDECK_XPOS+20, DECKCARD_YPOS, CARDWIDTH, CARDLENGTH);
                UIView *showCard3=[[UIView alloc] initWithFrame:cardRect3];
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
    
    
    
}

- (void)dragDetected: (UIPanGestureRecognizer *)panGestureRecognizer
{
    
    NSLog(@"Drag Dectected 0 %@");
    

    
    // CGFloat width = CGRectGetWidth(self.view.bounds);
    //CGFloat height = CGRectGetHeight(self.view.bounds);}
    // Check if a card t this location.
    // if so ..
    // show card at finger location.
    // card should movde at this location
    /*
     CGPoint locationInView= [panGestureRecognizer translationInView:panGestureRecognizer.view];
     
     [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
     
     // TODO: Here, you should translate your target view using this translation
     UIView *someView.center = CGPointMake(someView.center.x + t.x, someView.center.y + t.y);
     */
    
    
    
    
    NSArray *subviews = [self.view subviews];
    
    
     CGPoint locationInView = [panGestureRecognizer locationInView:self.view];
    
    // CGPoint locationInView= [panGestureRecognizer translationInView:panGestureRecognizer.view];
    
    // [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
     
     // TODO: Here, you should translate your target view using this translation
    
    /*
    UIView *tmpView2;
    tmpView2.center = CGPointMake(tmpView2.center.x + locationInView.x, tmpView2.center.y + locationInView.y);
    
    */
    
    float x = locationInView.x;
    float y = locationInView.y;
    static float   dragCardOriginX;
    static float   dragCardOriginY;
    static unsigned long CountOfStartingSubviews=0;
    static UIView *subviewFound=nil;
    
    
    
 /*
  
    if ( [self inSubViewList: locationInView]==FALSE )
    {
        NSLog(@"returning as Not in SubviewList- maybe check higher up");
        return;
    }
*/

   dragCardOriginX=0; // viewRect.origin.x;
        dragCardOriginY=0; //  viewRect.origin.y;
        // YES! Found Card to Dra
        //NSLog(@"Found REct  i=%d",i);
        //NSLog("@")
        //NSLog(@"Frame found = %@", NSStringFromCGRect(viewRect));
        
        //  [self.view bringSubviewToFront :subview];
        //subviewFound=subview;
        // subview.backgroundColor = [UIColor blackColor];
        //UIView *tmpView = [[UIView alloc] initWithFrame:viewRect];
        // Find TopMOst view and amke if black.
        //        UIView *ggg  = [subview findTopMostViewForPoint:locationInView];
        // .backgroundColor = [UIColor blackColor];
        //  [self.view addSubview:tmpView];
        
        // we want to gety co-ords from top of current view to bottem
        // of last view placed
        //CountOfStartingSubviews=i;
        switch (panGestureRecognizer.state)
    
    {
            
        case UIGestureRecognizerStateBegan:   //Drag Started
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
         
        }
            
        break;
        case UIGestureRecognizerStateChanged:  //While Dragging
        {
            unsigned long dropAreaCount = [_dropAreas count];
            
            dragCardOriginX = x -10;//+  ((dragCardOriginX >10) ? -10 : 0);
            dragCardOriginY = y -11; //+  ((dragCardOriginY >10) ? -10 : 0);
            //dragCardOriginX=0;
            //var greeting = "Good" + ((now.getHours() > 17) ? " evening." : " day.");
            
            CGRect tmpRect=CGRectMake( dragCardOriginX,dragCardOriginY , CARDWIDTH, CARDLENGTH) ;
            
            UIView *tmpView = [[UIView alloc] initWithFrame: tmpRect];
            
            //tmpView.center = CGPointMake(tmpView.center.x +locationInView.x,tmpView.center.y + locationInView.y);  //To allow for Pan Delay
              // Works fine in Simulator
            
            
            //[panGestureRecognizer setTranslation:CGPointZero inView:self.view];
            
            //tmpView.center = CGPointMake(tmpView.center.x + locationInView.x, tmpView.center.y + locationInView.y);
            
            
            tmpView.backgroundColor = [UIColor colorWithPatternImage:_globalCardImage];
           // tmpView.backgroundColor = [UIColor redColor];
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
            UIColor *colorSave = Nil;
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
                    colorSave= dropView.backgroundColor;
                    NSLog(@"Found interection....");
                    
                    dropView.backgroundColor = [UIColor blueColor];
                    // tmpView.backgroundColor  = [UIColor blueColor];
                    
                }
                
                else
                {
                    if (dropView.backgroundColor == [UIColor blueColor])
                    {
                        dropView.backgroundColor = RANDOM_COLOR;
                    }
                }
                
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
            }
            
            break;
            
        default:
            NSLog(@"Error - Gesture State Not Recognised ");
            break;
        }
     [self.view setNeedsDisplay];
            
    }
    
- (BOOL) inSubViewList: ( CGPoint ) locationInView
    {
     NSArray *subviews = [self.view subviews];
     int CurrentSubviewCount =(int)  [subviews count];
    
        NSLog(@"InSubViewList...");
    
    for (int  subview_index = CurrentSubviewCount - 1; subview_index >=0; subview_index--)
        {
    
    // [_dropAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
            UIView *subview = [subviews objectAtIndex:subview_index];
    //    if(!subview.hidden && CGRectContainsPoint(subview.frame, point))
    //CGPoint pointConverted = [self.view convertPoint:point toView:subview];
    //for (UIView *subview in self.view.subviews)
    
    NSLog(@"==>subview  i = %lu ",(unsigned long) subview_index);
       // we want locations thtat are in top view except the last view.
    CGRect viewRect =  [subview frame];
    
    if (CGRectContainsPoint(viewRect, locationInView))
    {
        NSLog(@"InSubViewList...return TRUE");
        return(TRUE);
        
    }
}
        NSLog(@"InSubViewList...return FALSE");
    return (FALSE);
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

    
    
- (void)didReceiveMemoryWarning
        {
            [super didReceiveMemoryWarning];
            // Dispose of any resources that can be recreated.
        }
    
    
    
@end
    
