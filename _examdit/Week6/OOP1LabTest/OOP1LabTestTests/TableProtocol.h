//
//  TableProtocol.h
//  OOP1LabTest
//
//  Created by Fergal Tobin on 18/11/2014.
//  Copyright (c) 2014 OO. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableProtocol <NSObject>


@required
-(UITableViewDataSource) conformsToTableViewDataSource;

@end
