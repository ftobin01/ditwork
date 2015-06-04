//
//  ViewController.m
//  tableviewBasic
//
//  Created by F T on 03/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"
#import "creativeCell.h"


@interface ViewController ()
//@property (nonatomic, retain) NSArray *listdata;



@end

@implementation ViewController

- (void)viewDidLoad {
   
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *array = [[NSArray alloc] initWithObjects:@"Sleepy1",@"Sleepy2",@"Sleepy3",@"Sleepy4",@"Sleepy5",@"Sleepy6",nil ];
    self.listdata=array;
 [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table View




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_listdata count];
}
static NSString *cellIdentifier = @"Cell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ccell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (ccell==nil){
        ccell = [[creativeCell  alloc] initWithStyle:UITableViewCellStyleDefault                                   reuseIdentifier : cellIdentifier];
        ccell.backgroundView=[[creativeCell alloc] init];
        UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:ccell.frame];
        [selectedBackgroundView setBackgroundColor:[UIColor whiteColor]];
         ccell.selectedBackgroundView=[self viewWithMask:selectedBackgroundView];
    }
        // [self configureCell:cell atIndexPath:indexPath];
    
    //creativeCell *ccell = [[creativeCell alloc] init];
    
    NSUInteger row = [indexPath row];
    ccell.textLabel.text = [_listdata objectAtIndex: row];
    return ccell;
}

/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        //   CustomColoredAccessory *accessory = [CustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:157.0/255.0 green:145.0/255.0 blue:196.0/255.0 alpha:1.0]];
        //   self.accessoryView =accessory;
        
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewForBaselineLayout.bounds.size.width, 44)];
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        backgroundView.alpha=0.6;
        [self setBackgroundView:[self viewWithMask:backgroundView]];
    }
    return self;
}

*/

-(UIView *) viewWithMask:(UIView *)view
{
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(7, 1, view.frame.size.width-14, 40) cornerRadius: 5];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = roundedRectanglePath.CGPath;
    [view.layer setMask:shapeLayer];
    view.translatesAutoresizingMaskIntoConstraints = YES;
    return view;
    
}



/*

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    creativeCell *ccell = [[creativeCell alloc] init];
    cell.backgroundView=[[creativeCell alloc] init];
    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBackgroundView setBackgroundColor:[UIColor whiteColor]];
    cell.selectedBackgroundView=[ccell viewWithMask:selectedBackgroundView];
    return cell;
}
*/


// Editing Swithced off
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
*/

/*
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];

 }

*/







@end
