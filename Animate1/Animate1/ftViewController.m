//
//  ftViewController.m
//  Animate1
//
//  Created by Fergal Tobin on 09/12/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ftViewController.h"

@interface ftViewController ()

@end

@implementation ftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CALayer *container = [CALayer layer];
    container.frame = CGRectMake(0, 0, 640, 300);
    [self.view.layer addSublayer:container];
    
  
 (
     
     
    // Create a new rotation animation
    CALayer *layer;
    CAAnimation* rotatingAnimation;
    rotatingAnimation = [self animationForRotationX:0.5 Y:0.5 Z:0.5];
    
    // Assign this animation to the provided layer's opacity attribute.
    // Any subsequent change to the layer's opacity will
    // trigger the animation.
    [layer rotatingAnimation forKey:@"opacity"];
    
    // So let's trigger it now
    layer.opacity = 0.99;
    

    // - (NSObject *) defineZRotation {
        // Define rotation on z axis
   //     float degreesVariance = 90;
        // object will always take shortest path, so that
        // a rotation of less than 180 deg will move clockwise, and more than will move counterclockwise
    float radiansToRotate = M_PI /2; // DegreesToRadians( degreesVariance );
        CATransform3D zRotation;
        zRotation = CATransform3DMakeRotation(radiansToRotate, 0, 0, 1.0);
        // create an animation to hold "zRotation" transform
        CABasicAnimation *animateZRotation;
        animateZRotation = [CABasicAnimation animationWithKeyPath:@"transform"];
        // Assign "zRotation" to animation
        animateZRotation.toValue = [NSValue valueWithCATransform3D:zRotation];
        // Duration, repeat count, etc
        animateZRotation.duration = 1.5;//change this depending on your animation needs
        // Here set cumulative, repeatCount, kCAFillMode, and others found in
        // the CABasicAnimation Class Reference.
    
    //  return animateZRotation;
    }
    
  ( CAAnimation *)animationForRotationX:(float)x Y:(float)y andZ:(float)z {
     float x=0, y=0,z=1;
     // Create a transform to rotate in all three axes
     float radians = M_PI/2; // DegToRad( 360 );
     CATransform3D transform;
     transform = CATransform3DMakeRotation(radians, x, y, z);
     
     // Create a basic animation to animate the layer's transform
     CABasicAnimation* animation;
     animation = [CABasicAnimation animationWithKeyPath:@"transform"];
     
     // Now assign the transform as the animation's value. While
     // animating, CABasicAnimation will vary the transform
     // attribute of its target for all three axes.
     animation.toValue = [NSValue valueWithCATransform3D:transform];
     
     animation.duration = 2;  // two seconds
     animation.cumulative = YES;
     animation.repeatCount = 10000; //  "forever"
     //  return animation;
     
    
    
    
    
    
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
