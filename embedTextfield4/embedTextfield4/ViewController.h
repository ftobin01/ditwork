//
//  ViewController.h
//  embedTextfield4
//
//  Created by F T on 13/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate >
@property (weak, nonatomic) IBOutlet UIView *mainMsgView;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

-(void)drawText : (NSString *) textStr : (CGRect) drawRect :(NSDictionary *) textAttributes;

@end

