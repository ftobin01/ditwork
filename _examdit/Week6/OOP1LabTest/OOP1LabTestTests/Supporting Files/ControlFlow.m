//
//  ControlFlow.m
//  OOP1LabTest
//
//  Created by Fergal Tobin on 18/11/2014.
//  Copyright (c) 2014 OO. All rights reserved.
//

#import "ControlFlow.h"

@implementation ControlFlow

-(NSString) fizzQ:(BOOL ) x {
    if (x) return (@"Fizz");
    return(@"Buzz");
}


- (NSMutableArray *)intsPlus10: (NSInteger )x {
    NSArray NSInteger myInts[10];
    NSinteger y;
    for (y=x; y<x+10; y++)
        myInts[i] = y;
}



-(NSMutableArray *)intPlus10mk2 : (NSInteger ) x {
    NSArray NSInteger myInts[10];
for (NSNumber *n in myInts) {
    [n intValue] = [n intValue + x++];

      }
    return (myInts);
    
// Quesry regarding if release of NSarray occurs when function ends;
}




-(NSArray *)IntPlus1: (NSArray* ) x {
    int i;
    int elemCount=[x count];
    NSMutableArray NSNumber *mutArray = [NSMutableArray arrayWithCapacity: elemCount  ];
    
    for (i=0;i<elemCount; i++)
        mutArray[i] = [x[i] intValue]+1;
    }



-(NSInteger) divBy2:  (NSInteger ) x  {
    int y=0;
    int z=[x intValue];
    while (  (z%2)  >=2)
    {
        ++y;
        z=z/2;
    }
    return y;
}
@end






