//
//  TableAndCellsAppDelegate.h
//
//  http://iPhoneDeveloperTips.com
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface TableAndCellsAppDelegate : NSObject <UIApplicationDelegate>
{
  UIWindow 						*window;
	MainViewController	*mainVC;  
}

@property (nonatomic, retain) UIWindow *window;

@end
