//
//  ftViewController.m
//  hello world
//
//  Created by Fergal Tobin on 10/11/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ftViewController.h"

@interface ftViewController ()

@end

@implementation ftViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 //   NSLog(@"@","Hello World");
    _label.text= @"hello Julia";
    //IBAction


}


-(IBAction) buttonPressed: (id)sender
{
    //some action...
    _label.text= @"GoodBye Julia";
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
