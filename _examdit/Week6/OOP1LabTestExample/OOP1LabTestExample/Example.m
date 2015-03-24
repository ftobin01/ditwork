//
//  Example.m
//  OOP1LabTestExample
//
//  Created by Zachary Davison on 11/15/14.
//  Copyright (c) 2014 OO. All rights reserved.
//

#import "Example.h"

@implementation Example

+ (NSNumber*)add:(NSNumber*)x y:(NSNumber*)y{
  return @(x.doubleValue + y.doubleValue);
}

+ (NSString*)concatenate:(NSString*)x y:(NSString*)y{
  return [x stringByAppendingString:y];
}

@end
