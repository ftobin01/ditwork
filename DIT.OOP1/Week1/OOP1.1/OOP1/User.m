//
//  Model.m
//  OOP1
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "User.h"
#import "NSString+MyCategory.h"

@implementation User

+ (User*)user{
  return [[User alloc] init];
}

- (id)init{
  self = [super init];
  if(!self) { return nil; }
  
  _userID = 1;
  _name   = @"Hudson Mohawke";
  _name   = [_name doubled];
  _avatar = [UIImage imageNamed:@"hudmo"];
  
  return self;
}

- (id)initWithID:(NSInteger)uid name:(NSString*)name avatar:(UIImage*)avatar{
  
  self = [super init];
  if(!self) { return nil; }
  
  _userID = uid;
  _name   = name;
  _avatar = avatar;
  
  return self;
}

@end
