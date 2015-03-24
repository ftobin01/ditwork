//
//  NSString+MyCategory.h
//  OOP1
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyCategory)

- (NSString*)doubled;

@end

//// - Another file, somewhere

@interface NSString : (SomeoneElseCategory)

- (NSString*)doubled;

@end