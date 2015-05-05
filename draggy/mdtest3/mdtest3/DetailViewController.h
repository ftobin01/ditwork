//
//  DetailViewController.h
//  mdtest3
//
//  Created by F T on 28/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detailCourseName;

@property (strong, nonatomic) id detailItem;


@property (weak, nonatomic) IBOutlet UILabel *detailCourseLecturer;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailCourseRoom;


@property(weak, nonatomic) IBOutlet UILabel *detailTimeStamp;




@end

