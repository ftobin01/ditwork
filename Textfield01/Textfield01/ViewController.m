//
//  ViewController.m
//  Textfield01
//
//  Created by F T on 01/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mytextfield;

@end

@implementation ViewController 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading theview, typically from a nib.

    
    //[self turnOffKeyBoard];
    
    
    [_mytextfield becomeFirstResponder];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    //NSLog(@"You entered %@",_mytextfield.text);
    NSLog(@"here is my text = %@",_mytextfield.text);
//    [_mytextfield resignFirstResponder];
    
    //NSInteger nextTag = _mytextfield.tag ;
    _mytextfield.text=@"";    // Try to find next responder
    //UIResponder* nextResponder =
    //[_mytextfield.superview viewWithTag:nextTag];
    
    //[nextResponder becomeFirstResponder];

    [_mytextfield nextResponder];
    return YES;
    
}

-(void) turnOffKeyBoard
{
    UIView *dummyView = [UIView new];
_mytextfield.inputView = dummyView; // Hide keyboard, but show blinking cursor
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) backgroundTap : (id) sender {
    [_mytextfield resignFirstResponder];
    NSLog(@"BackGround Tap - Received");
}
@end
