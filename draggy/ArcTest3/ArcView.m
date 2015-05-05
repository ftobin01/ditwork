//
//  ArcView.m
//  ArcTest3
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#define degreeToRadians(x) (M_PI * (x) / 180.0)

#import "ArcView.h"

@implementation ArcView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
 
    CGContextSetLineWidth(context, 20.0f);
    UIColor *currentColor = [UIColor blackColor];
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
   // CGContextMoveToPoint(context, 20.0f, 20.0f);
   
    // CGContextAddLineToPoint(context, 80.0f, 20.0f);
    //CGContextStrokePath(context);
    
    CGContextAddArc(context, 100, 100, 65, degreeToRadians(0), 30, 0);
    CGContextStrokePath(context);
    //fill or draw the path
     CGContextDrawPath(context, kCGPathStroke);
     CGContextDrawPath(context, kCGPathFill);
 //   CGContextAddArc(context, 50, 50, 50, 0, 30, 0);
 //   CGContextFillPath(context);
   CGContextStrokePath(context);
 
 
    //set the fill or stroke color
   // CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
 //    CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 0.0f, 1.0);
    
    
    
 //   CGContextAddArc(context, 100, 100, 65, degreeToRadians(0), 30, 0);
    
    //fill or draw the path
   // CGContextDrawPath(context, kCGPathStroke);
   // CGContextDrawPath(context, kCGPathFill);
    
   // ------------------------------
   
  //  [self drawFullCircle];
    //set the fill or stroke color
     //CGContextSetRGBFillColor(context, 0.0, 100.0, 100.0, 1.0);
   
  //  CGContextSetLineWidth(context, 10.0f);
   // CGContextSetRGBStrokeColor(context, 0.0f, 100.0f, 100.0f, 1.0);
  //  CGContextAddArc(context, 100, 100, 65, degreeToRadians(10), degreeToRadians(85), 0);    //set the fill or stroke color
   // CGContextSetRGBFillColor(context, 1, 0.5, 0.5, 1.0);
   // CGContextSetRGBStrokeColor(context, 0.5, 1, 0.5, 1.0);
    
    //fill or draw the path
   CGContextDrawPath(context, kCGPathStroke);
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);}


- (void) drawLayer:(CALayer*) layer inContext:(CGContextRef) ctx
{
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineWidth(ctx,18);
    
    CGContextMoveToPoint(ctx, 80.0f, 20.0f);
 //   CGContextAddLineToPoint(ctx, 100, 100);
  
    
     CGContextSetStrokeColorWithColor(ctx, [UIColor yellowColor].CGColor);
    
    CGContextSetRGBFillColor(ctx, 255.0, 0.0, 0.0, 1.0);

   CGContextDrawPath(ctx, kCGPathStroke);
    CGContextDrawPath(ctx, kCGPathFill);
    CGContextAddArc(ctx, 100, 100, 65, degreeToRadians(0), degreeToRadians(360), 0);
    
    //fill or draw the path
    
    CGContextStrokePath(ctx);
}
*/

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextDrawPath(context, kCGPathFill);
    CGContextAddArc(context, 100, 126, 86, 0, 30, 0);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    
    
    int radius = 70;
    int strokeWidth = 15;
    CGColorRef color = [UIColor blueColor].CGColor;
    int timeInSeconds = 5;
    
    CGFloat startAngle = 0;
    CGFloat endAngle = 1.0;
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-100.0, -44, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
    
    circle.position = CGPointMake(CGRectGetMidX(self.frame)-radius, CGRectGetMidY(self.frame)-radius);
    
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = color;
    circle.lineWidth = strokeWidth;
    
    [self.layer addSublayer:circle];
    
 

    circle.strokeEnd = endAngle;
    
    //  Apply the animation.
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = timeInSeconds;
    drawAnimation.fromValue = [NSNumber numberWithFloat:startAngle];
    drawAnimation.toValue   = [NSNumber numberWithFloat:endAngle];
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    
    
    
}





-(void)drawFullCircle
{
     CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0f);
    CGContextSetRGBStrokeColor(context, 0.0f, 100.0f, 100.0f, 1.0);
    for (int i=0; i<360;i+=10)
    {
    CGContextAddArc(context, 100, 100, 65, degreeToRadians(0), degreeToRadians(i), 0);
        //fill or draw the path
        CGContextDrawPath(context, kCGPathStroke);
        CGContextDrawPath(context, kCGPathFill);
        
        [self setNeedsDisplay ];
    }

}

/*

- (void) drawLayer:(CALayer*) layer inContext:(CGContextRef) ctx
{
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 5);
    
    CGContextMoveToPoint(ctx, 5, 5);
    CGContextAddLineToPoint(ctx, 95, 95);
    
    CGContextStrokePath(ctx);
}


*/




@end
