//
//  Student.h
//  mdtest
//
//  Created by F T on 28/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) NSString * studentName;
@property (nonatomic, retain) Course *onetoMany;

@end
