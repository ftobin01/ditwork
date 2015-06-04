//
//  creativeCell.m
//  tableviewBasic
//
//  Created by F T on 03/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "creativeCell.h"

@implementation creativeCell



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
     //   CustomColoredAccessory *accessory = [CustomColoredAccessory accessoryWithColor:[UIColor colorWithRed:157.0/255.0 green:145.0/255.0 blue:196.0/255.0 alpha:1.0]];
     //   self.accessoryView =accessory;
        
        UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewForBaselineLayout.bounds.size.width, 44)];
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        backgroundView.alpha=0.6;
        [self setBackgroundView:[self viewWithMask:backgroundView]];
    }
    return self;
}


-(UIView *) viewWithMask:(UIView *)view
{
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(7, 1, view.frame.size.width-14, 40) cornerRadius: 5];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = roundedRectanglePath.CGPath;
    [view.layer setMask:shapeLayer];
    view.translatesAutoresizingMaskIntoConstraints = YES;
    return view;

}


@end
