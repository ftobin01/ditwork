//
//  DetailViewController.m
//  mdtest3
//
//  Created by F T on 28/04/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
     //   self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"courseName"] description];
        
        self.detailCourseName.text = [[self.detailItem valueForKey:@"courseName"] description];
        
        
        _detailCourseRoom.text = [[self.detailItem valueForKey:@"courseRoom"] text];
/*
       _detailCourseRoom.text = (NSString *)) _detailItem.courseName];
        
*/        
    /*    self.detailCourseLecturer.text = [[self.detailItem valueForKey:@"courseLecturer"] description];
      */
        _detailCourseLecturer.text = [[self.detailItem valueForKey:@"courseLecturer"] description];
        
        
        self.detailTimeStamp.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
