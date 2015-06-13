//
//  ViewController.m
//  embedTextfield4
//
//  Created by F T on 13/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self turnOffKeyBoard];
    
    [_myTextField becomeFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    //NSLog(@"You entered %@",_mytextfield.text);
    NSLog(@"here is my text = %@",_myTextField.text);
    //    [_mytextfield resignFirstResponder];
    
    //NSInteger nextTag = _mytextfield.tag ;
    _myTextField.text=@"";    // Try to find next responder
    //UIResponder* nextResponder =
    //[_mytextfield.superview viewWithTag:nextTag];
    
    //[nextResponder becomeFirstResponder];
    
    [_myTextField nextResponder];
    return YES;
    
}

-(void) turnOffKeyBoard
{
    UIView *dummyView = [UIView new];
    _myTextField.inputView = dummyView; // Hide keyboard, but show blinking cursor
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
