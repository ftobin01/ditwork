//
//  NSString+MyCategory.m
//  OOP1
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "NSString+MyCategory.h"

@implementation NSString (MyCategory)

- (NSString*)doubled{
  return [NSString stringWithFormat:@"%@ %@",self,self];
}

@end

@implementation NSString (SomeoneElseCategory)

- (NSString*)doubled{
  return [NSString stringWithFormat:@"%@ %@ %@",self,self,self];
}

@end