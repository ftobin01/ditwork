//
//  ViewController.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#define RANDOM_COLOR                                                           \
[UIColor colorWithRed : (CGFloat)random() / (CGFloat)RAND_MAX green : (CGFloat)random() / (CGFloat)RAND_MAX blue : (CGFloat)random() / (CGFloat)RAND_MAX alpha : 1.0]


#define  MAXSUITSIZE 7

#import "ViewController.h"

@interface ViewController ()

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
    
    for (z=0; z<MAXSUITSIZE; z++)
    {
        for ( i=0; i<7; i++)
            {
                 view1 = [[UIView alloc] initWithFrame:CGRectMake( j, k, l, m)];
                
                view1.backgroundColor = rndColor;
                [[self view] addSubview:view1];
                j+=43;
                //k+=30;
            
             UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector (dragDetected:)];
                [view1 addGestureRecognizer:panGesture];
                
        }
        
   // [view setNeedsDisplay];
    j=15;
    k+=32;
        
    rndColor= RANDOM_COLOR;
        }

    
   
  
}
- (void)dragDetected:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
   // CGFloat width = CGRectGetWidth(self.view.bounds);
    //CGFloat height = CGRectGetHeight(self.view.bounds);}
    // Check if a card t this location.
    // if so ..
    // show card at finger location.
    // card should movde at this location
    
    CGPoint locationInView = [panGestureRecognizer locationInView:self.view];
    NSLog(@"Drag DEctected %@", NSStringFromCGPoint(locationInView));
    NSLog(@"My view's frame is: %@", NSStringFromCGRect(self.view.frame));
    NSLog(@" Xpoint is %f",locationInView.x);
    float x = locationInView.x;
    float y = locationInView.y;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake( x, y, 15, 32)];
        [[self view] addSubview:view1];
        [self.view setNeedsDisplay];
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

