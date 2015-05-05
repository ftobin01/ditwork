//
//  Course.h
//  mdtest
//
//  Created by F T on 28/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSNumber * lecturerName;
@property (nonatomic, retain) NSNumber * roomNo;
@property (nonatomic, retain) Student *oneToMany;

@end
