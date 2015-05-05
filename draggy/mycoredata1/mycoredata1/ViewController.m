//
//  ViewController.m
//  mycoredata1
//
//  Created by F T on 25/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
#import "ViewController.h"
#import "CoreDataStack.h"
#import "Entry.h"

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
    
    Entry *entry = [self createEntry];
    entry.value = _textField.text;
    [[CoreDataStack sharedInstance] save];
    
    [_entries addObject:entry];
    [_tableView reloadData];
}

- (Entry*)createEntry{
    NSManagedObjectContext *context = [CoreDataStack sharedInstance].managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:context];
    Entry *entry = [[Entry alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
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
    Entry *entry = _entries[indexPath.row];
    cell.textLabel.text = entry.value;
    return cell;
    
}

@end
Status API Training Shop Blog About
© 2015 GitHub, Inc. Terms Privacy Security Contact