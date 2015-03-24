//
//  ftViewController.h
//  hello world
//
//  Created by Fergal Tobin on 10/11/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ftViewController : UIViewController

@property (nonatomic, strong) IBOutlet    UILabel  *label;
@property (nonatomic, weak ) IBOutlet     UIButton *button1;

@property (nonatomic, weak) NSString *hw;

// IBAction *b-utton;
-(IBAction) buttonPressed: (id)sender;


@end
