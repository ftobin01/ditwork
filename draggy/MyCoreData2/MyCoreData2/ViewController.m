//
//  ViewController.m
//  mycoredata1
//
//  Created by F T on 25/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//



#import "ViewController.h"
#import "CoreStack.h"
#import "Entity.h"


@interface ViewController () <UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *entries;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _entries = [self existingEntries].mutableCopy ?: [NSMutableArray array];
}

- (NSArray*)existingEntries{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
    NSArray *results = [[CoreDataStack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return results;
}

- (IBAction)saveButtonPressed:(id)sender{
    
    Entity *entry = [self createEntry];
    entry.entry = _textField.text;
    [[CoreDataStack sharedInstance] save];
    
    [_entries addObject:entry];
    [_tableView reloadData];
}

- (Entity*)createEntry{
    NSManagedObjectContext *context = [CoreDataStack sharedInstance].managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:context];
    Entity *entry = [[Entity alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    return entry;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Entity *entry = _entries[indexPath.row];
    cell.textLabel.text = entry.entry;
    return cell;
    
}

@end