//
//  QuartzTest.m
//  ArcTest1
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "QuartzTest.h"
#import "UIColor_Random.h"


/*
@interface QuartzTest
{
@property CGPoint firstTouch;
@property CGPoint lastTouch;
@property (nonatomic, retain)  UIColor *currentColor;
@property (nonatomic, retain) UIImage *drawImage;
@property (nonatomic) ShapeType shapeType;
@property (nonatomic) BOOL useRandomColor;
}
@end

*/

//@property BOOL useRandomColor;


@implementation QuartzTest

- (id) initWithCoder:(NSCoder *)coder
{
    if ( self = [super initWithCoder: coder]) {
        currentColor = [UIColor redColor];
        useRandomColor = NO;
        if (drawImage == nil)
            drawImage = [ UIImage imageNamed : @"iphone.png"];
    }
    
 return self;
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
    
    switch (shapeType) {
        case kLineShape:
            CGContextMoveToPoint(context, firstTouch.x, firstTouch.y);
            CGContextAddLineToPoint(context,lastTouch.x, lastTouch.y);
            CGContextStrokePath(context);
            break;
        case kRectShape:
            break;
        case KEllipseShape:
            break;
        case kImageShape:
            break;
        default:
            break;
    }
}




- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *)event {
    if (useRandomColor)
        self.currentColor = [UIColor randomColor];

    UITouch *touch = [touches anyObject];
    firstTouch = [touch locationInView:self];
    lastTouch = [touch locationInView:self];
    [self setNeedsDisplay];
    

}

- (void) touchesEnded: (NSSet *)touches withEvent: (UIEvent *) event {
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    
    [self setNeedsDisplay];
}


- (void) touchesMoved: (NSSet *) touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    
    [self setNeedsDisplay];
}



@end
