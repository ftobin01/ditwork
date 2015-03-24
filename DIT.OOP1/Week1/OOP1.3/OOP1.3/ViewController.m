//
//  ViewController.m
//  OOP1.3
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Second.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad{
  
  NSArray *array = @[@0,@1,@2];
  id second = [array second];
  
  NSLog(@"SECOND: %@",second);
  
}

@end
