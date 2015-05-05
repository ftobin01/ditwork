//
//  QuartzTest.h
//  ArcTest1
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@interface QuartzTest : UIView

{
    CGPoint     firstTouch;
    CGPoint     lastTouch;
    UIColor     *currentColor;
    ShapeType   shapeType;
    UIImage     *drawImage;
    BOOL        useRandomColor;

}
@property (nonatomic) CGPoint firstTouch;
@property (nonatomic) CGPoint lastTouch;
@property (nonatomic, retain)  UIColor *currentColor;
@property (nonatomic, retain) UIImage *drawImage;
@property (nonatomic) ShapeType shapeType;
@property (nonatomic) BOOL useRandomColor;

@end
