//
//  ViewController.h
//  tableviewBasic
//
//  Created by F T on 03/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate , UITableViewDataSource >
@property (nonatomic, retain) NSArray *listdata;

@end

