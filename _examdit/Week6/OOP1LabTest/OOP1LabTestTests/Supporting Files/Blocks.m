//
//  Blocks.m
//  OOP1LabTest
//
//  Created by Fergal Tobin on 18/11/2014.
//  Copyright (c) 2014 OO. All rights reserved.
//

#import "Blocks.h"

@implementation Blocks


NSNumber block;

-void (myBlock) () = ^{
    NSNumber __block *value = @0;
    [Blocks invokeBlock:^{
        value = @1;
    }];


-(void)invokeBlock : ( void (^)( void) ) myBlock {
}


-(void)invokeParameterBlock : (void) (^) (NSInteger)myBlock)

    
    
-NSNumber (^returnBlock)() = ^{
        return ((NSNumber ) @5);
    }
@end











