//
//  ViewController.m
//  ArcTest2
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     NSLog(@"In Draw REct");
    // CALayer *container = [[CALayer alloc] init];
    
    CALayer *container =[CALayer layer];
    
    container.frame = CGRectMake(100.0f, 20.0f, 200.0f, 400.0f);
    UIColor *backgroundColor = [UIColor greenColor];
    
 //   container.backgroundColor = backgroundColor.CGColor;
     // CGColorRef backgroundColor;
    
    [self.view.layer addSublayer:container];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4.0);
    UIColor *currentColor = [UIColor redColor];
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddLineToPoint(context, 20.0f, 20.0f);
    CGContextStrokePath(context);
}

/*
-(void) drawRect:(CGRect) rect {
    
    
    
  
  //  CGContextDrawPath(context, kCGPathFillStroke);
    [self.view.layer setNeedsDisplay];
   // CGRect theRect = CGMakeRect(0,0,100,100);
    
}

*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
