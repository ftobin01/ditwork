//
//  ViewController.m
//  Blocks
//
//  Created by Zachary Davison on 11/3/14.
//  Copyright (c) 2014 ZD. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)buttonPressed:(id)sender{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  [manager GET:@"http://ip.jsontest.com/"
    parameters:nil
       success:^(AFHTTPRequestOperation *operation, id responseObject){
         NSDictionary *dictionary = (NSDictionary*)responseObject;
         _label.text = dictionary[@"ip"];
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
       }];
}

@end
