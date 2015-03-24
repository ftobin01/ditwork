//
//  NSArray+Second.m
//  OOP1.3
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "NSArray+Second.h"

@implementation NSArray (Second)

- (id)second{
  if(self.count >= 2){
    return self[1];
  }
  return nil;
}

@end
