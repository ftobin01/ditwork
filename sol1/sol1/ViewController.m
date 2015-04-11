//
//  ViewController.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#define RANDOM_COLOR                                                           \
[UIColor colorWithRed : (CGFloat)random() / (CGFloat)RAND_MAX green : (CGFloat)random() / (CGFloat)RAND_MAX blue : (CGFloat)random() / (CGFloat)RAND_MAX alpha : 1.0]


#define  MAXCARDROWS        7
#define  MAXCARDCOLUMNS     7



#import "ViewController.h"



@interface ViewController ()



// -(void) make_card:(float), (float), (float),  (float);

@property NSMutableArray* rectArray;
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
    float k=20;
    float l=33;
    float m=60;
    
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
    
    for (z=0; z<MAXCARDCOLUMNS; z++)
    {
        for ( i=0; i<7; i++)
            {
     //           make_card(j, k, l,  m);
                aRect = CGRectMake( j, k, l, m);
                
                [rectArray addObject:[NSValue valueWithCGRect:aRect]];
                NSLog(@"rect_Array count = %lu", [rectArray count]);
                
                view1 = [[UIView alloc] initWithFrame:aRect];
                
                view1.backgroundColor = rndColor;
                [[self view] addSubview:view1];
                
                j+=43;
                //k+=30;
            // Linking Pan Gesture Recogniser to entire view - as need to make it easier once item is dragged.
                
    UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDetected:)];
                [self.view addGestureRecognizer:panGesture];
                
        }
        
   // [view setNeedsDisplay];
    j=15;
    k+=32;
        
    rndColor= RANDOM_COLOR;
        
        
        
        
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
    
    CGPoint locationInView = [panGestureRecognizer locationInView:self.view];
    float x = locationInView.x;
    float y = locationInView.y;
    
    
    NSLog(@"Drag Dectected %@", NSStringFromCGPoint(locationInView));
    
    
    switch (panGestureRecognizer.state) {
        
        case UIGestureRecognizerStateBegan:   //Drag Started
            {
                        NSLog(@"**** UIGestureRecognizerStateBegan - Drag Started %@", NSStringFromCGPoint(locationInView));
                
               // NSLog(@"My view's frame is: %@", NSStringFromCGRect(self.view.frame));
                NSLog(@" Xpoint is %f",locationInView.x);
                // find view started
                unsigned long q = (unsigned long)[subviews count];
                NSLog(@"Subviews count %lu",(unsigned long) [subviews count]);
                NSLog(@"NOW FINd subview Point Location is in....");
                NSLog(@"Coubt of number of subviews = %lu",q);
                
                
               // -(UIView *)findTopMostViewForPoint : (CGPoint) point
                for (int  i=(int) q -(int) 1; i>=0; i--)
                {
                    UIView *subview = [subviews objectAtIndex:i];
                //    if(!subview.hidden && CGRectContainsPoint(subview.frame, point))
                        //CGPoint pointConverted = [self.view convertPoint:point toView:subview];
                //for (UIView *subview in self.view.subviews)
                    
                    NSLog(@"==>subview  i = %lu ",(unsigned long) i);
                    CGRect viewRect =  [subview frame];
                        
                        // we want locations thtat are in top view except the last view.
                        if (CGRectContainsPoint(viewRect, locationInView))
                        {
                            
                // YES! Found Card to Drag
                            NSLog(@"Found REct  i=%lu",i);
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
                            
                            break;
                        }
                        
                    }
                
            }
            
            break;
        case UIGestureRecognizerStateChanged:  //While Dragging
            {
                
                NSLog(@"Dragging ... UIGestureRecogniserChanged %@", NSStringFromCGPoint(locationInView));
                                    ;
            }
            break;
        case UIGestureRecognizerStateEnded:    //Drop - Dragging Ended
        {
            CGPoint dropLocationInView = [panGestureRecognizer locationInView:self.view];
            NSLog(@"DROPPED UIGestureRecogniserStateEnded %@", NSStringFromCGPoint(dropLocationInView));
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
*/
 
 }







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




// Make Screen.h
// Function to Make a 2 D array of 7 SCreen Columns
// and 13 screen rows Pos and to create a card size and half card pos.
    
    
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

