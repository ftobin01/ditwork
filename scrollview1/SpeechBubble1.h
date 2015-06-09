//
//  SpeechBubble1.h
//  scrollview1
//
//  Created by F T on 04/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SpeechBubble1 : UIView


@property (nonatomic, copy) NSString *text;

- (id)initAtPoint:(CGPoint)point withText:(NSString *)string;
- (void)drawOutlineInContext:(CGContextRef)context;
- (void)drawTextInContext:(CGContextRef)context;

@end

