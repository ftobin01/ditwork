//
//  ViewController.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#define RANDOM_COLOR                                                           \
[UIColor colorWithRed : (CGFloat)random() / (CGFloat)RAND_MAX green : (CGFloat)random() / (CGFloat)RAND_MAX blue : (CGFloat)random() / (CGFloat)RAND_MAX alpha : 1.0]
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
    UIView *view;
    
    UIColor *rndColor= RANDOM_COLOR;
    
    for (z=0; z<13; z++)
    {
        for ( i=0; i<7; i++)
            {
                UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake( j, k, l, m)];
                view1.backgroundColor = rndColor;
    
                [[self view] addSubview:view1];
    
       
        
        
       // [view1 setNeedsDisplay];
        j+=43;
        //k+=30;
        
    }
    // [view setNeedsDisplay];
    j=15;
    k+=32;
    rndColor= RANDOM_COLOR;
        
    }
    /*
        
     [view setNeedsDisplay];
        j=15;
        k=50;
        l=33;
        m=60;
        for ( i=0; i<7; i++)
        {
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake( j, k, l, m)];
            view1.backgroundColor = [UIColor blueColor];
            
            [[self view] addSubview:view1];
             j+=43;
        }
        
    */
    
    
    
    NSLog(@"about to creatview 2");
 /*
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectInset(view1.bounds, 20.0f, 20.0f)];
    view2.backgroundColor = [UIColor yellowColor];
    
    [view1 addSubview:view2];
    
    
    [view1 setNeedsDisplay];
   */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
