//
//  Event.h
//  mdtest
//
//  Created by F T on 28/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;

@end
