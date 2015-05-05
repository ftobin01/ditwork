//
//  UIColor_Random.m
//  ArcTest1
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "UIColor_Random.h"

@implementation UIColor (Random)
+ (UIColor *)randomColor {
    static BOOL seeded = NO;
    if (!seeded){
        seeded= YES;
        srandom((unsigned ) time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
}
@end
