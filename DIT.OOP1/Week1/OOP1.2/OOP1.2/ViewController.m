//
//  ViewController.m
//  OOP1.2
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
  
  NSArray *array = @[@1,@2];
  NSDictionary *dictionary = @{@"key":@"value"};
  NSString *string = @"My name is";
  
  [self logCountOfObject:array];
  [self logCountOfObject:dictionary];
  [self logCountOfObject:string];
}

- (void)logCountOfObject:(id)object{
  if([object respondsToSelector:@selector(count)]){
    NSInteger count = [object count];
    NSLog(@"%@ COUNT %ld",[object class], count);
  }else{
    NSLog(@"%@ does not respond to 'count'", [object class]);
  }
}

@end
