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

#define     MAXCARDROWS        7
#define     MAXCARDCOLUMNS     7

#define     CARDWIDTH           33.0
#define     CARDLENGTH          60.0

#define     GAPBETWEENCARDS     10
#define     GAPBETWEENACECARDS     15

#define     CARDSTARTPOS        20


#import "ViewController.h"



@interface ViewController ()



// -(void) make_card:(float), (float), (float),  (float);

@property NSMutableArray* rectArray;
@property NSMutableArray *dropAreas;
@property NSArray *subviews;
//-(void)listSubviewsOfView: (UIView  *) view;






@end


@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // view1 will be positioned at x = 30, y = 20 starting the top left corner of [self view]
    // [self view] could be the view managed by a UIViewController
    
    
    // makeFullCard()
    int i=0;
    int z=0;
    float j=15;
    float k=CARDSTARTPOS;
    
    
    _dropAreas=[NSMutableArray array];
    
    CGRect aRect;
    NSMutableArray *rectArray = [NSMutableArray array];
    NSArray *subviews = [NSArray array];
    
    
    
    // CGRect someRect = [[array objectAtIndex:0] CGRectValue];
    
    
    
    //    CGPoint lastLocation;
    
    UIView *view1;
    
    UIColor *rndColor= RANDOM_COLOR;
    /*
     UILabel *_lbl_title5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 288, 25)];
     _lbl_title5.text = @"http://sugartin.info";
     UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openWebURL:)];
     [_lbl_title5 addGestureRecognizer:tapGesture];
     [_srl addSubview:_lbl_title5];
     
     */
    self.view.userInteractionEnabled = YES;
    
    
    
    UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDetected:)];
    [self.view addGestureRecognizer:panGesture];
    
    
    UIColor *cardColor = RANDOM_COLOR;
    
    for (z=0; z<MAXCARDCOLUMNS; z++)
    {
        // view1.backgroundColor = redColor;
        for ( i=0; i<MAXCARDROWS; i++)
        {
            
            // UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
            
            //customView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"YourImage.png"]];
            
            //[self.view addSubview:customView];
            
            //           make_card(j, k, l,  m);
            
            
            
            
            
            
            
            
            aRect = CGRectMake( j, k, CARDWIDTH, CARDLENGTH);
            
            [rectArray addObject:[NSValue valueWithCGRect:aRect]];
            MYLOG(@"rect_Array count = %lu", [rectArray count]);
            
            view1 = [[UIView alloc] initWithFrame:aRect];
            
           //view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3_of_clubs.png"]];
            
            
            UIGraphicsBeginImageContext(view1.frame.size);
            [[UIImage imageNamed:@"3_of_clubs.png"] drawInRect:view1.bounds];
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            
            
            
            
            //UIImage* img = [UIImage imageNamed:@"3_of_clubs.png"];
            view1.backgroundColor = [UIColor colorWithPatternImage:img];
            
            // view1.backgroundColor = cardColor;
            
            
            
            
            [[self view] addSubview:view1];
            
           // cardColor= RANDOM_COLOR;
            k+=CARDLENGTH/2;
            // Linking Pan Gesture Recogniser to entire view - as need to make it easier once item is dragged.
            
        }
        
        // [view setNeedsDisplay];
        j+=CARDWIDTH + GAPBETWEENCARDS;
        k=CARDSTARTPOS;
        
        // cardColor= RANDOM_COLOR;
        // Adding last card area in Each column as a draggable area.
        NSLog(@"Adding Drop Area ");
        NSLog(@"Frame f = %@", NSStringFromCGRect(aRect));
        // [_dropAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
        [_dropAreas addObject: view1];//Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
        NSLog(@"Just After A~dding  dropArea count =  %d",(int)[_dropAreas count]);
    }
    /*
     -(void)make_card: (float)j, (float)k, (float)l, (float) m
     {
     view1 = [[UIView alloc] initWithFrame:CGRectMake( j, k, l, m)];
     
     view1.backgroundColor = rndColor;
     [[self view] addSubview:view1];
     
     }
     */
    
   subviews = [self.view subviews] ;
    NSLog(@"subview count 1 %lu",(unsigned long)[subviews count]);
    
    // Create Aces Area
    
    int acesArea_YPos = (5* CARDLENGTH );
    int acesArea_XPos = self.view.bounds.size.width - 4*(CARDWIDTH + GAPBETWEENACECARDS);
    for (int i=0; i<(CARDWIDTH+GAPBETWEENACECARDS)*4; i+=CARDWIDTH+GAPBETWEENACECARDS)
    {
        
        CGRect cardRect = CGRectMake(acesArea_XPos+i, acesArea_YPos, CARDWIDTH,CARDLENGTH);
        NSLog(@"Frame cardRect f = %@", NSStringFromCGRect(cardRect));        UIView *aceView = [[UIView alloc] initWithFrame:cardRect];
        aceView.backgroundColor = [UIColor blackColor];
        [[self view] addSubview:aceView];
        
    }
    
    NSLog(@"Leaving Didload  dropArea count =  %d",(int )[_dropAreas count]);
    
}





- (void)dragDetected: (UIPanGestureRecognizer *)panGestureRecognizer
{
    
    // CGFloat width = CGRectGetWidth(self.view.bounds);
    //CGFloat height = CGRectGetHeight(self.view.bounds);}
    // Check if a card t this location.
    // if so ..
    // show card at finger location.
    // card should movde at this location
    
    //UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *) sender;
    
    NSArray *subviews = [self.view subviews];
    NSArray *dragviews;
    
    
    CGPoint locationInView = [panGestureRecognizer locationInView:self.view];
    float x = locationInView.x;
    float y = locationInView.y;
    float   dragCardOriginX=x;
    float   dragCardOriginY=y;
    static unsigned long CountOfStartingSubviews=0;
    
    
    
    NSLog(@"Drag Dectected %@", NSStringFromCGPoint(locationInView));
    
    
    switch (panGestureRecognizer.state)
    {
            
        case UIGestureRecognizerStateBegan:   //Drag Started
        {
            
            CountOfStartingSubviews=[subviews count];
            NSLog(@"**** UIGestureRecognizerStateBegan - Drag Started %@", NSStringFromCGPoint(locationInView));
            
            // NSLog(@"My view's frame is: %@", NSStringFromCGRect(self.view.frame));
            NSLog(@" Xpoint is %f",locationInView.x);
            // find view started
            unsigned long q = (unsigned long)[subviews count];
            NSLog(@"Subviews count %lu",(unsigned long) [subviews count]);
            NSLog(@"NOW FINd subview Point Location is in....");
            NSLog(@"Count of number of subviews = %lu",q);
            
            
            // -(UIView *)findTopMostViewForPoint : (CGPoint) point
            for (int  i=(int) q -(int) 1; i>=0; i--)
            {
                
                // [_dropAreas addObject:[NSValue valueWithCGRect:aRect]];//Add last Cartd which will be face up as A droppable Area - ACE's area will also need to be added.
                UIView *subview = [subviews objectAtIndex:i];
                //    if(!subview.hidden && CGRectContainsPoint(subview.frame, point))
                //CGPoint pointConverted = [self.view convertPoint:point toView:subview];
                //for (UIView *subview in self.view.subviews)
                
                NSLog(@"==>subview  i = %lu ",(unsigned long) i);
                CGRect viewRect =  [subview frame];
                
                // we want locations thtat are in top view except the last view.
                if (CGRectContainsPoint(viewRect, locationInView))
                {
                    dragCardOriginX=viewRect.origin.x;
                    dragCardOriginY=viewRect.origin.y;
                    // YES! Found Card to Drag
                    NSLog(@"Found REct  i=%d",i);
                    //NSLog("@")
                    NSLog(@"Frame found = %@", NSStringFromCGRect(viewRect));
                    
                    [self.view bringSubviewToFront :subview];
                    subview.backgroundColor = [UIColor blackColor];
                    //UIView *tmpView = [[UIView alloc] initWithFrame:viewRect];
                    // Find TopMOst view and amke if black.
                    //        UIView *ggg  = [subview findTopMostViewForPoint:locationInView];
                    // .backgroundColor = [UIColor blackColor];
                    //  [self.view addSubview:tmpView];
                    
                    // we want to gety co-ords from top of current view to bottem
                    // of last view placed
                    //CountOfStartingSubviews=i;
                    
                    break;
                }
            }
            
            
        }
            
        break;
        case UIGestureRecognizerStateChanged:  //While Dragging
        {
            
            UIColor *rndColor= RANDOM_COLOR;
            unsigned long dropAreaCount = [_dropAreas count];
            
            NSLog(@"Dragging ... UIGestureRecogniserChanged %@", NSStringFromCGPoint(locationInView));
            
            //view1 = [[UIView alloc] initWithFrame:aRect];
            
            //view1.backgroundColor = rndColor;
            dragCardOriginX =x-5;
            dragCardOriginY=y-5;
            CGRect tmpRect=CGRectMake( dragCardOriginX-2,dragCardOriginY-5 , CARDWIDTH, CARDLENGTH) ;
            UIView *tmpView = [[UIView alloc] initWithFrame: tmpRect];
            tmpView.backgroundColor = [UIColor redColor];
            [self.view addSubview: tmpView];
            
            
            
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
            NSLog(@"Leaving in Drag Detected dropArea count =  %lu",(unsigned long)[_dropAreas count]);
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
                for (int  i=(int) CurrentSubviewCount -(int) 1; i>=(int) CountOfStartingSubviews; i--)
                {
                    
                    UIView *subview = [subviews objectAtIndex:i];
                    
                    [subview removeFromSuperview];
                    //[NSThread sleepForTimeInterval:0.6];
                    
                }
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
    
    // landmine touched?
    //   CGRect playerRect = CCRectMake(200, 300, 10, 10);
    ///    CGRect mineRect = CGRectMake(10, 10, 20, 20);
    
    
    
    
    
    /*
     
     
     UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake( x, y, 33.0f, 60.0f)];
     view2.backgroundColor = RANDOM_COLOR;
     [[self view] addSubview:view2];
     [self.view setNeedsDisplay];
     }
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
    
    // Make Screen.h
    // Function to Make a 2 D array of 7 SCreen Columns
    // and 13 screen rows Pos and to create a card size and half card pos.
    







    
    
- (void)didReceiveMemoryWarning
        {
            [super didReceiveMemoryWarning];
            // Dispose of any resources that can be recreated.
        }
    
    
    
@end
    
