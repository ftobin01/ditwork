//
//  ViewController.m
//  embedTextfield2
//
//  Created by F T on 13/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mytextfield;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_mytextfield becomeFirstResponder];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
