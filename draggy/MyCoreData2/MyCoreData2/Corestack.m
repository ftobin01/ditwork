//
//  Corestack.m
//  mycoredata1
//
//  Created by F T on 25/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//


#import "CoreStack.h"

@interface CoreDataStack()

@property (nonatomic, strong) NSManagedObjectContext        *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel          *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator  *persistentStoreCoordinator;

@end

@implementation CoreDataStack

+ (instancetype)sharedInstance {
    static CoreDataStack *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataStack alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if(!self) { return nil; }
    
    // Setup Managed Object Model
    _managedObjectModel         = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Setup Persistent Store Coordinator
    NSError *error = nil;
    NSURL *documentsDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    NSURL *storeURL = [documentsDirectory URLByAppendingPathComponent:@"CoreDataStack.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    
    if(error){
        NSLog(@"ERROR: %@", error);
        abort();
    }
    
    // Setup Managed Object Context
    _managedObjectContext       = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    
    return self;
}

- (void)save{
    NSError *error = nil;
    if(_managedObjectContext.hasChanges && ![_managedObjectContext save:&error]){
        NSLog(@"Error saving Core Data context: %@", error);
        abort();
    }
}

@end
