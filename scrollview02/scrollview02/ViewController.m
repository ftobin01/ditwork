//
//  ViewController.m
//  scrollview02
//
//  Created by F T on 05/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIScrollView *myScrollView;
@property (nonatomic, strong) NSMutableArray *svArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    // Do any additional setup after loading the view, typically from a nib.
    _svArray= [[NSMutableArray alloc] init];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame: self.view.frame];
    
    myScrollView.backgroundColor = [UIColor redColor];
    
    UIImage *bubble = [[UIImage imageNamed:@"greyBubble.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 21, 0, 21)];
//UIImageView *imgView =[[UIImageView alloc] initWithImage:bubble];
    [_svArray addObject : bubble];
    // Create Scrollview = ScreenSize
    // Load Test Image to test
    [self.view addSubview:_myScrollView];
    NSLog(@"About to Add image");
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bubble];
    //imageView.image = bubble;
    [self.myScrollView addSubview:imageView];
    
    
    NSLog(@"Added image");
    
      _myScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 1 , self.view.frame.size.height);
     //}
  //  [self addImageToScrollView:  bubble animated: YES];
    _myScrollView.contentSize = CGSizeMake(self.view.frame.size.width , self.view.frame.size.height);
*/
    [self addScrollView];
    [self addScrollView2];
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addScrollView{
    _myScrollView = [[UIScrollView alloc]initWithFrame:
                    CGRectMake(0, 50, 480, 420)];
    //_myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    _myScrollView.backgroundColor = [UIColor redColor];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:
               [UIImage imageNamed:@"greyBubble"]];
    
    [_myScrollView addSubview:imgView];
    _myScrollView.minimumZoomScale = 0.5;
    _myScrollView.maximumZoomScale = 3;
    

    _myScrollView.contentSize = CGSizeMake(imgView.frame.size.width,imgView.frame.size.height+100);
    _myScrollView.contentOffset = CGPointMake(5, -420);
    // //_myScrollView.contentSize = CGSizeMake(100,380);
    _myScrollView.delegate = self;
    [self.view addSubview:_myScrollView];
}


-(void)addScrollView2{
  //  _myScrollView = [[UIScrollView alloc]initWithFrame:
                 //    CGRectMake(0, 50, 480, 420)];
    //_myScrollView.accessibilityActivationPoint = CGPointMake(100, 100);
    //_myScrollView.backgroundColor = [UIColor redColor];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:
                            [UIImage imageNamed:@"greyBubble"]];
    
    [_myScrollView addSubview:imgView];
    _myScrollView.minimumZoomScale = 0.5;
    _myScrollView.maximumZoomScale = 3;
    
    
    _myScrollView.contentSize = CGSizeMake(imgView.frame.size.width,imgView.frame.size.height);
   _myScrollView.contentOffset = CGPointMake(5, -200);
    // //_myScrollView.contentSize = CGSizeMake(100,380);
   // _myScrollView.delegate = self;
    [self.view addSubview:_myScrollView];
}








-(void) viewWillAppear:(BOOL)animated
{
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // _svArray = [self.myModel retrieveAttachments]; //Suppose this takes a long time
        for (UIImage *image in self.svArray)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addImageToScrollView:image animated:YES]; });
        }
    
                   });
     */
}


#define ADD_IMAGE_APPEARING_ANIMATION_SPEED  .5f

-(void) addImageToScrollView: (UIImage *) image animated: (BOOL) animated
{
    //Create image view
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.image = image;
    
    if(animated)
    {
        imageView.alpha = 0;
        [self.myScrollView addSubview:imageView];
        [UIView animateWithDuration:ADD_IMAGE_APPEARING_ANIMATION_SPEED animations:^{
            imageView.alpha = 1;
        }];
    }
    else
    {
        [self.myScrollView addSubview:imageView];
    }
}


@end
