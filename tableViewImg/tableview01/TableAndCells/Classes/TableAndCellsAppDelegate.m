//
//  TableAndCellsAppDelegate.m
//
//  http://iPhoneDeveloperTips.com
//

#import "TableAndCellsAppDelegate.h"
#import "MainViewController.h"

@implementation TableAndCellsAppDelegate

@synthesize window;

/*-------------------------------------------------------------
*
*------------------------------------------------------------*/
- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
	mainVC = [[MainViewController alloc] init];
  
  [window addSubview:mainVC.view];

  // Override point for customization after application launch
  [window makeKeyAndVisible];
}



@end
