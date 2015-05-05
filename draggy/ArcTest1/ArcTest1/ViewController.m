//
//  ViewController.m
//  ArcTest1
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"
#import "QuartzTest.h"
#import "Constants.h"



@interface ViewController ()
@@end



@implementation ViewController : UIViewController


-(IBAction) changeColor :(id) sender {
    UISegmentedControl *control = sender;
    NSInteger index =[control selectedSegmentedIndex];
    QuartzTest *quartzView = (QuartzTest *)self.view;



    switch   (index) {
        case kRedColorTab:
            quartzView.CurrentColor = [UIColor redColor];
            quartzView.useRandomColor = NO;
            break;
        case kBlueColorTab:
            quartzView.CurrentColor = [UIColor blueColor];
            quartzView.useRandomColor = NO;
            break;
    
        case kYellowColorTab:
            quartzView.CurrentColor = [UIColor yellowColor];
            quartzView.useRandomColor = NO;
            break;
            
        case kGreenColorTab:
            quartzView.CurrentColor = [UIColor greenColor];
            quartzView.useRandomColor = NO;
            break;
        case kRandomColorTab:
            quartzView.useRandomColor = YES;
            break;
        default:
            break;
    }
    

}


-(IBAction)changeShape:(id)sender
{
    UISegmentedControl *control = sender;
    [(QuartzTest *)self.view setShapeType:[control selectedSegmentIndex]];
    
    
    if ([control selectedSegmentIndex] == kImageShape)
        colorControl.hidden = YES;
    else
        colorControl.hidden = NO;
}















- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
