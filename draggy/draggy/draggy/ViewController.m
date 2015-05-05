//
//  ViewController.m
//  draggy
//
//  Created by F T on 17/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"
#define NumViews            7

#define RANDOM_COLOR     [UIColor colorWithRed : (CGFloat)random() / (CGFloat)RAND_MAX green : (CGFloat)random() / (CGFloat)RAND_MAX blue : (CGFloat)random() / (CGFloat)RAND_MAX alpha : 1.0]


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *viewArray;
    viewArray = [[NSMutableArray alloc] init];
    
    // UIView *view7;
    
    
    
     [self.view addSubview : _view1];
     [self.view addSubview : _view2];
     [self.view addSubview : _view3];
     [self.view addSubview : _view4];
     [self.view addSubview : _view5];
     [self.view addSubview : _view6];

   //  UIView *aView = [viewArray addObject: aView];
    
    //change to a particular view
   // self.view =  (UIView*)[viewArray objectAtIndex:4];
    
    
     UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragDetected:)];
    
    [self.view addGestureRecognizer:panGesture];
// MOve All views to first view
    for (int i=0;i< NumViews; i++ )
        ;
   // Create View to Drag to
    UIView *dragFromView = (UIView *)[self.view.subviews objectAtIndex:2];
    CGRect dragToRect = dragFromView.frame;
    dragToRect.origin.x+=50;
    UIView *dragToView = [[UIView alloc] initWithFrame: dragToRect];
    dragToView.backgroundColor = [UIColor blackColor];
    [self.view addSubview: dragToView];
    NSLog(@"To View Created");
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    static int startShow=0;
    
    
    
        UIView *startview = [self.view.subviews objectAtIndex:2];
    
        CGRect startFrame = startview.frame;
    
        for (int i=3;i< NumViews+1; i++ )
        {
        UIView *next = (UIView*)[self.view.subviews objectAtIndex:i];
            CGRect nextframe = next.frame;
        
            // for ()
/*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    next.frame = startFrame;
    //self.v.frame = basketBottomFrame;
    
    [UIView commitAnimations];
 */
 
    [UIView animateWithDuration:0.5
                            delay:1.0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                            next.frame = startFrame;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
  UIView *tmp = [self.view.subviews objectAtIndex:i];
            tmp.frame = startFrame;
  }
        

        
}



- (void)dragDetected: (UIPanGestureRecognizer *)panGestureRecognizer
{
    //UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *) sender;
    
    NSArray *subviews = [self.view subviews];
    NSArray *dragviews;
    
    CGPoint locationInView = [panGestureRecognizer locationInView:self.view];
    
    float x = locationInView.x;
    
    float y = locationInView.y;
    
    float   dragCardOriginX=x;
    float   dragCardOriginY=y;
    float   dragObjectWidth=0;
    float   dragObjectHeight=0;
    
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
                dragObjectWidth=viewRect.size.width;
                dragObjectHeight=viewRect.size.height;
                    
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
            //     unsigned long dropAreaCount = [_dropAreas count];
            
            NSLog(@"Dragging ... UIGestureRecogniserChanged %@", NSStringFromCGPoint(locationInView));
            
            //view1 = [[UIView alloc] initWithFrame:aRect];
            NSLog(@"dragOBjectHEight = %f, dragObjectHEight  %f", dragObjectHeight,dragObjectWidth);
            //view1.backgroundColor = rndColor;
            dragCardOriginX =x-5;
            dragCardOriginY=y-5;
        CGRect tmpRect=CGRectMake( dragCardOriginX-2,dragCardOriginY-5 , dragObjectWidth, dragObjectHeight) ;
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
            //      NSLog(@"Leaving in Drag Detected dropArea count =  %lu",(unsigned long)[_dropAreas count]);
            //NSLog(@"DropAreaCounbt = %lu",dropAreaCount);
            UIColor *colorSave = Nil;
            //for (int j=0; j<(int) dropAreaCount; j++)
            //{
            //        UIView *dropView = [_dropAreas objectAtIndex:j];
            //      NSLog(@"Checking dragrect in dropArea %@\nj= %d",dropView,j);
            
            //    CGRect checkViewRect=[dropView frame];
            // NSLog(@"About to compare Intersection of  dropArea j= %d",j);
            
            //  NSLog(@"tmpRect =%@",NSStringFromCGRect(tmpRect));
            //NSLog(@"CheckViewRect =%@",NSStringFromCGRect(checkViewRect));
            
            
            //  if (CGRectIntersectsRect(tmpRect, checkViewRect))  //they interSect
            //{
            //  colorSave= dropView.backgroundColor;
            NSLog(@"Found interection....");
            
            //dropView.backgroundColor = [UIColor blueColor];
            // tmpView.backgroundColor  = [UIColor blueColor];
            
            //  }
            
            //else
            //{
            //  if (dropView.backgroundColor == [UIColor blueColor])
            //{
            //  dropView.backgroundColor = RANDOM_COLOR;
            //}
            //}
            
            //}
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
    
    
    
    
    
    
    
    
    


// viewB = [[UIView alloc] initWithFrame:CGRectMake(0, 220, 320, 200)];

/*
    - (void)snapToOriginalPosition {
        [UIView animateWithDuration:0.3 animations:^() {
            CGPoint originalPointInSuperView = [_draggedView.superview convertPoint:_originalPosition fromView:_originalView];
            _draggedView.frame = CGRectMake(originalPointInSuperView.x, originalPointInSuperView.y, _draggedView.frame.size.width, _draggedView.frame.size.height);
        } completion:^(BOOL finished) {
            _draggedView.frame = CGRectMake(_originalPosition.x, _originalPosition.y, _draggedView.frame.size.width, _draggedView.frame.size.height);
            [_draggedView removeFromSuperview];
            [_originalView addSubview:_draggedView];
        }];
    }
    
    
    
*/
    

    // Do any additional setup after loading the view, typically from a nib.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
