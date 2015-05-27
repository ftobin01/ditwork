//
//  cards.m
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 Fergal Tobin. All rights reserved.
//

#import "cards.h"

@interface Card  (NSObject)

@property (nonatomic) int          cardSuit;

@property (nonatomic)   int        cardVal;

@property (nonatomic)   NSString  *cardPic;

@property (nonatomic)   bool      cardFaceUp;

@property (nonatomic)   CGRect    cardRect;


@end




@implementation Card

{
    
      }



// view1 will be positioned at x = 30, y = 20 starting the top left corner of [self view]
// [self view] could be the view managed by a UIViewController


//makeCard()

//UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(30.0f, 20.0f, 400.0f, 400.0f)];
//view1.backgroundColor = [UIColor redColor];

//[[self view] addSubview:view1];




//[[UIColor blackColor] setFill];
//UIRectFill((CGRect){0,200,rect.size.width,1});



@end
