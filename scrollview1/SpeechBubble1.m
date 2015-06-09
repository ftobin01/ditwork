//
//  SpeechBubble1.m
//  scrollview1
//
//  Created by F T on 04/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "SpeechBubble1.h"
//#import <CGBase.h>

@implementation SpeechBubble1


    static const CGFloat kArrowOffset = 0.0f;
    
    static const CGFloat kStrokeWidth = 2.0f;
    static const CGFloat kArrowSize = 14.0f;
    static const CGFloat kFontSize = 12.0f;
    static const CGFloat kMaxWidth = 196.0f;
    static const CGFloat kMaxHeight = CGFLOAT_MAX;
    static const CGFloat kPaddingWidth = 12.0f;
    static const CGFloat kPaddingHeight = 10.0f;
    



// TODO make some of these instance variables to add more customization.




#pragma mark NSObject


#pragma mark UIView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self drawOutlineInContext:contextRef];
    [self drawTextInContext:contextRef];
}

#pragma mark TipBalloon

- (id)initAtPoint:(CGPoint)point withText:(NSString *)string
{
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:kFontSize] constrainedToSize:CGSizeMake(kMaxWidth, kMaxHeight) lineBreakMode:UILineBreakModeWordWrap];

    CGRect rect = CGRectMake(point.x, point.y, size.width+kPaddingWidth*2.0f, size.height+kPaddingHeight*2.0f+kArrowSize);
    if ((self = [super initWithFrame:rect])) {
        self.text = string;
        UIColor *clearColor = [[UIColor alloc] initWithWhite:0.0f alpha:0.0f];
        self.backgroundColor = clearColor;
        
    }
    return self;
}

- (void)drawOutlineInContext:(CGContextRef)context {
    CGRect rect = self.bounds;
    rect.origin.x += (kStrokeWidth/2.0f);
    rect.origin.y += kStrokeWidth + kArrowSize;
    rect.size.width -= kStrokeWidth;
    rect.size.height -= kStrokeWidth*1.5f + kArrowSize;
    
    CGFloat radius = 11.0f;
    CGFloat x_left = rect.origin.x;
    CGFloat x_right = x_left + rect.size.width;
    CGFloat y_top = rect.origin.y;
    CGFloat y_bottom = y_top + rect.size.height;
    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, kStrokeWidth);
    CGContextSetRGBStrokeColor(context, 0.0f/255.0f, 255.0f/255.0f, 0.0f/255.0f, 1.0f); // green
    CGContextSetGrayFillColor(context, 1.0f, 1.0f); // white background
    CGContextMoveToPoint(context, x_left+radius, y_top);
    CGContextAddLineToPoint(context, x_left+radius+kArrowOffset, y_top);
    
    // Draw triangle.
    CGContextAddLineToPoint(context, x_left+radius+kArrowOffset+kArrowSize/2.0f, y_top-kArrowSize);
    
    CGContextAddLineToPoint(context, x_left+radius+kArrowOffset, y_top-kArrowSize);
    CGContextAddLineToPoint(context, x_left+radius+kArrowOffset+kArrowSize, y_top);
    
    static const CGFloat F_PI = (CGFloat)M_PI;
    CGContextAddArc(context, x_right-radius, y_top+radius, radius, 3.0f*F_PI/2.0f, 0.0f, 0);
    CGContextAddArc(context, x_right-radius, y_bottom-radius, radius, 0.0f, F_PI/2.0f, 0);
    CGContextAddArc(context, x_left+radius, y_bottom-radius, radius, F_PI/2.0f, F_PI, 0);
    CGContextAddArc(context, x_left+radius, y_top+radius, radius, F_PI, 3.0f*F_PI/2.0f, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawTextInContext:(CGContextRef)context {
    CGRect rect = self.bounds;
    rect.origin.x += kPaddingWidth;
    rect.origin.y += kPaddingHeight + kArrowSize;
    rect.size.width -= kPaddingWidth*2.0f;
    rect.size.height -= kPaddingHeight*2.0f;
    
    CGContextSetGrayFillColor(context, 0.0f, 1.0f); // black text
    [_text drawInRect:rect withFont:[UIFont systemFontOfSize:kFontSize]
       lineBreakMode:UILineBreakModeWordWrap];
}

    

@end
