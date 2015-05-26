//
//  Cards.h
//  sol1
//
//  Created by Fergal Tobin on 23/03/2015.
//  Copyright (c) 2015 Fergal Tobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic) int          cardSuit;

@property (nonatomic)   int        cardVal;

@property (nonatomic)   NSString  *cardPic;

@property (nonatomic)   bool      cardFaceUp;

@property (nonatomic)   CGRect    cardRect;

@end
