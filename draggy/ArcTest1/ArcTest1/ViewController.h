//
//  ViewController.h
//  ArcTest1
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UISegmentedControl *colorControl;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *colorControl;

- (IBAction) changeColor: (id) sender;
- (IBAction) changeShape: (id)sender;

@end

