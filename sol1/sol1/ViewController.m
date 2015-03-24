//
//  ViewController.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

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
    
    
    // makeCard()
    
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(20.0f, 20.0f, 200.0f, 200.0f)];
    view1.backgroundColor = [UIColor redColor];
    
    [[self view] addSubview:view1];
    
    [view1 setNeedsDisplay];
    
    
    NSLog(@"about to creatview 2");
    
    UIView* view2 = [[UIView alloc] initWithFrame:CGRectInset(view1.bounds, 20.0f, 20.0f)];
    view2.backgroundColor = [UIColor yellowColor];
    
    [view1 addSubview:view2];
    
    
    [view1 setNeedsDisplay];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
