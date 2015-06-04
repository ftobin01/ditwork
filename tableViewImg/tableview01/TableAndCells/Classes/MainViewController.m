//
//  MainViewController.m
//
//  http://iPhoneDeveloperTips.com
//

#import "MainViewController.h"
#import "CustomCell.h"

@implementation MainViewController

- (id)init
{
  if (self = [super init]) 
  {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];

		// Setup the background
		UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:background];
		
    // Create table view
    theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 11, 320, 460) style: UITableViewStylePlain];
    [theTableView setDelegate:self];
    [theTableView setDataSource:self];
    
    // This should be set to work with the image height
    [theTableView setRowHeight:68];

    // Transparent, so we can see the background
    [theTableView setBackgroundColor:[UIColor clearColor]];
    [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [theTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];

		[self.view addSubview:theTableView];

	}

	return self;

}


#pragma mark -
#pragma mark Table Management

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
  return 1;
}

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 8;
}

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
  CustomCell *cell= [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (cell == nil) {
       
        
    }  // Default to no selected style and not selected
  cell.selectionStyle = UITableViewCellSelectionStyleNone;

	// Set the image for the cell  
  [cell setTheImage:[UIImage imageNamed:[NSString stringWithFormat:@"Arrows%ld.png", indexPath.row + 1]]];

	return cell;
}

/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
}

@end
