//
//  Model.h
//  OOP1
//
//  Created by Zachary Davison on 10/13/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

// ? These import statements are a new addition to XCode, and provide a faster
//   import method than the traditional #import "file.h", leading to faster compile times!

@import Foundation;
@import UIKit;

// ? The below declares an @interface for a class 'User', that inherits from 'NSObject'
//   NSObject is the obj-c base class, and gives us a lot of nice features.

@interface User : NSObject

// ? The following 3 lines each declare a property with a class and a name, and various 'property attributes'
//   'nonatomic'  don't worry about this one for now, but if you are curious:
//                http://stackoverflow.com/questions/588866/whats-the-difference-between-the-atomic-and-nonatomic-attributes
//   'assign' is an attribute used to indicate that it refers to a primitive type (eg, an 'int') and will be
//            passed by VALUE.
//   'copy'   is an attribute used to indicate that any object set to it will be copied first. The equivalent of
//            sending the object an [object copy] message.
//   'strong' is an attribute used to indicate that the object will be retained by this User object until it
//            is released.
//   'weak'   not used here, 'weak' indicates that the object will not be retained, and may be released by
//            something else at some point.
//
//   There are more property attributes,

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, copy)   NSString  *name;
@property (nonatomic, strong) UIImage   *avatar;

// ? The below declares a class method called 'user' that returns a User object.

+ (User*)user;

// ? The below declares an instance method called 'initWithID:name:avatar:'

- (id)initWithID:(NSInteger)uid name:(NSString*)name avatar:(UIImage*)avatar;

@end
