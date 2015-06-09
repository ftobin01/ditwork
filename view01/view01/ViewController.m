//
//  ViewController.m
//  view01
//
//  Created by F T on 06/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//
#define DEVICE_SIZE [[[[UIApplication sharedApplication] keyWindow] rootViewController].view convertRect:[[UIScreen mainScreen] bounds] fromView:nil].size

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *viewsArray;
@property (nonatomic, strong )UIScrollView *paintView;
@end

@implementation ViewController

static CGFloat mCurrentWidth;
static CGFloat mCurrentHeight;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     mCurrentWidth = DEVICE_SIZE.width;
    mCurrentHeight = DEVICE_SIZE.height;
    
    mCurrentWidth = self.view.frame.size.width;
    mCurrentHeight = self.view.frame.size.height;
    
    //Oritentation check - if width > height - reverse
    
    
    NSLog(@"Current Height = %f",mCurrentWidth);// CreateView
    _viewsArray = [[NSMutableArray alloc]init];
    _paintView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mCurrentWidth, mCurrentHeight)];
    self.view.autoresizesSubviews = NO;
     [_paintView setBackgroundColor:[UIColor yellowColor]];
    //self.view =_paintView;
    _paintView.autoresizesSubviews = NO;
    [self.view addSubview: _paintView];
    [self makeView1];
    [self makeView2];
    [self nextView ];
    [self nextView ];
    [self nextView2];
    //[self nextView ];
    //[self nextView ];
    //[self showViews];

}

-(void) viewWillAppear:(BOOL)animated
{
    
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     // _svArray = [self.myModel retrieveAttachments]; //Suppose this takes a long time
     for (UIView *image in self.viewsArray)
     {
     dispatch_async(dispatch_get_main_queue(), ^{
     [self addImageToScrollView:image animated:YES]; });
     }
     
     });
}








#define ADD_IMAGE_APPEARING_ANIMATION_SPEED  10.0f

-(void) addImageToScrollView: (UIView *) image animated: (BOOL) animated
{
    
    
    
    //Create image view
    UIView *imageView = [[UIView alloc] init];
  //  (UIImage *)imageView;
    imageView = image;
    
  // imageView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
   if(animated)
    {
        imageView.alpha = 0;
        [self.paintView addSubview:imageView];
        [UIView animateWithDuration:ADD_IMAGE_APPEARING_ANIMATION_SPEED animations:^{
            imageView.alpha = 1;
        }];
    }
    else
    {
        [self.paintView addSubview:imageView];
    }
  
}


-(void) addImageToScrollView2 : (UIView *) image animated: (BOOL) animated
{
    static BOOL  first= TRUE;
   // image - if not first scroll up others!
    float heightFromBottom  = self.view.frame.origin.y-image.frame.size.height;
    CGRect bottomRect=CGRectMake(0, 0, 100, 100);
    bottomRect.origin.y = heightFromBottom;
    UIView *bottomView = [[UIView alloc] initWithFrame :bottomRect];
    if (first)
    {
        //start at bottom of screen no animation
        [self.paintView addSubview:bottomView];
        first=FALSE;
        return;
    }
    //Create image view
    
    //(UIImage *)imageView;
    //imageView = image;
    
    // imageView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    if(animated)
    {
        bottomView.alpha = 0;
        [self.paintView addSubview:bottomView];
        [UIView animateWithDuration:ADD_IMAGE_APPEARING_ANIMATION_SPEED animations:^{
            bottomView.alpha = 1;
        }];
    }
    else
    {
        [self.paintView addSubview:bottomView];
    }
    
}

-(void) scrollUp: (float) height
{
// Increase Size of reame before Adding next View!
   xtendedView=CGRectMake(_paintView.bounds., <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>).bounds.center.x  = _paintView.bounds.center.x;
    //float newHeight = oldView.size.height + height
    extendedView.size.height+=height;
    [self.paintView setFrame: extendedView ];

}
    
-(void)nextView
//Ad view to the bottom
{
    
    CGFloat bottomHeightPos =_paintView.center.y - 100/2;   //_paintView.contentOffset.y;//+
    NSLog (@"nextView bottomHeightPos =%f\n, _paintView.contentOffset.y; = %f,\n_paintView.frame.origin.y=%f",bottomHeightPos,_paintView.contentOffset.y,_paintView.frame.origin.y);
    
    CGFloat bottomXPos=_paintView.center.x*2;
    //  float bottomHeightPos =  _paintView.frame.size.height + paintView.frame.origin.y ;
    
    // _paintView.contentOffset=CGPointMake(_paintView.frame.origin.x,bottomHeightPos);
     [self scrollUp: 100];
    UIView *myView = [[UIView alloc] initWithFrame : CGRectMake(bottomXPos+50,bottomHeightPos,100,100)];
    
    myView.backgroundColor = [UIColor blueColor];
   
    //[self.view addSubview: myView];
   
    [self.paintView setNeedsDisplay];
    [_viewsArray addObject:myView];
  //  _paintView.frame.size.height =100;
}

-(void)nextView2
//Ad view to the bottom
{
    
    CGFloat bottomHeightPos =   _paintView.contentSize.height;//
   // NSLog (@"nextView bottomHeightPos =%f\n, _paintView.contentOffset.y; = %f,\n_paintViewContentSize.y=%f",bottomHeightPos,_paintView.contentOffset.y,_paintView.contentSize.y);
    
    CGFloat bottomXPos=_paintView.center.x*2;
    //  float bottomHeightPos =  _paintView.frame.size.height + paintView.frame.origin.y ;
    
    //_paintView.contentOffset=CGPointMake(_paintView.frame.origin.x,bottomHeightPos);
    [self scrollUp: 200];
    UIView *myView = [[UIView alloc] initWithFrame : CGRectMake(bottomXPos,bottomHeightPos-100,100,100)];
    
    myView.backgroundColor = [UIColor redColor];
    
    //[self.view addSubview: myView];
    
   // [self.paintView setNeedsDisplay];
    [_viewsArray addObject:myView];
    //  _paintView.frame.size.height =100;
}
-(void)makeView1
{
UIView *myView = [[UIView alloc] initWithFrame : CGRectMake(100,50,100,100)];
myView.backgroundColor = [UIColor redColor];
    //[self.view addSubview: myView];
    [_viewsArray addObject:myView];
}


-(void)makeView2
{
    UIView *myView = [[UIView alloc] initWithFrame : CGRectMake(100,250,50,50)];
    myView.backgroundColor = [UIColor blueColor];
     //[self.view addSubview: myView];
    [_viewsArray addObject:myView];
}


-(void) showViews
{
    for (UIView *v  in _viewsArray)
        [self.view addSubview: v];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
