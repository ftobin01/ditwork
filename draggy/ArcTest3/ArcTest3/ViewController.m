//
//  ViewController.m
//  ArcTest3
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#define degreeToRadians(x) (M_PI * (x) / 180.0)

#include "ArcView.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) ArcView *arcview;
@end

@implementation ViewController


- (IBAction)pressedButton:(id)sender {
    NSLog(@"Button Pressed");
    [ArcView beginAnimations:nil context:NULL];
    [ArcView setAnimationBeginsFromCurrentState:YES];
    [ArcView setAnimationDuration:0.1];
    [ArcView setAnimationCurve: UIViewAnimationCurveLinear];
    // other animation properties
    
    // set view properties
    
    [ArcView commitAnimations];
    
 
  
    
    
    // for (int i=0; i<360; i++)
         
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(100,25,200,300);
    _arcview = [[ArcView alloc] initWithFrame:rect];
    _arcview.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_arcview];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetLineWidth(context, 20.0f);
    UIColor *currentColor = [UIColor blackColor];
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
     CGContextMoveToPoint(context, 50.0f, 50.0f);
    
    // CGContextAddLineToPoint(context, 80.0f, 20.0f);
    //CGContextStrokePath(context);
    
    CGContextAddArc(context, 100, 100, 65, degreeToRadians(0), degreeToRadians(10), 0);
    
    //fill or draw the path
    //CGContextDrawPath(context, kCGPathStroke);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextStrokePath(context);
    
}


- (void) viewDidAppear:(BOOL)animated
{
    CALayer* layer = [CALayer layer];
    
    [layer setCornerRadius:48];
    [layer setBorderColor:[UIColor redColor].CGColor];
    [layer setBorderWidth:15];
    
    [layer setFrame:CGRectMake(145, 100, 110, 110)];
    [layer setBackgroundColor:[UIColor yellowColor].CGColor];
    [self.view.layer addSublayer:layer];
    
    [layer setDelegate:self];
    [layer setNeedsDisplay];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [animation setDuration:2.0];
    [animation setRepeatCount:INT_MAX];
    [animation setFromValue:[NSNumber numberWithFloat:0] ];
    [animation setToValue:[NSNumber numberWithFloat:M_PI * 2.0]];
    [layer addAnimation:animation forKey:nil];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
