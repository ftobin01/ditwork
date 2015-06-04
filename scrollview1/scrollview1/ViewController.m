//
//  ViewController.m
//  scrollview1
//
//  Created by F T on 03/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"
#import "ScrollCell.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *responseOut;
@property (nonatomic, strong) NSArray *responseIn;

- (void)updateScreenView:(int *)loadIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   /*
    ScrollCell *scrollView= [[ScrollCell alloc] initWithFrame :self.view.frame];
    scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview : scrollView];

    */
    
    _responseIn= [[NSArray alloc] init];
    _responseOut = [[NSArray alloc] init];
    
    UIView *myView = [[UIView alloc] initWithFrame : CGRectMake(100,100,200,200)];
    myView.backgroundColor = [UIColor redColor];
    //[scrollView addSubview: myView];
    
        self.view.backgroundColor = [UIColor redColor];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   /*
    scrollView.pagingEnabled = YES;
    NSInteger numberOfViews = 3;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIView *awesomeView = [[UIView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        awesomeView.backgroundColor = [UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1];
        [scrollView addSubview:awesomeView];
        
    
    
scrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height);
    [self.view addSubview:scrollView];}
    */
    
    
    
     UIScrollView* sv = [[UIScrollView alloc] initWithFrame:
     [[UIScreen mainScreen] applicationFrame]];
     sv.backgroundColor = [UIColor whiteColor];
    
   
    
    self.view = sv;
     CGFloat y = 10;
    
     for (int i=0; i<30; i++) {
         UILabel* lab = [UILabel new];
         CGRect f = lab.frame;
         
         f.origin = CGPointMake(10,y);
         lab.frame = f;
         
         lab.text = [NSString stringWithFormat:@"This is label %i", i+1];
         [lab sizeToFit];
        [sv addSubview : lab];
        
                  y += lab.bounds.size.height + 5;
         
         CGSize sz = sv.bounds.size;
         sz.height = 10.0f;// y;
         sv.contentSize = sz;
 
     
     }
    
     // This is the crucial lineThe contentSize is just the sum of the widths of the three UIViews, if the width of each UIView is 320, and we have three UIViews, your contentSize width will be 920.
}


-(void) delayView : (UIScrollView *) sv
{
    
     double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       
        NSLog(@"Do some work");
    });
    
}



-(void) updateCarousel: (NSArray *)response{
    if(_responseIn && _responseIn.count>0){
        int i=0;
        _scrollView.hidden=NO;
        [_scrollView setNeedsDisplay];
       // _view.pagingMode.hidden=NO;
        //_scrollView pagingMode.hidden=NO;
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        //for (Business *business in response){
          //  if (i >= MAX_INITAL_SEARCH_RESULTS)
            //    break;
            
            CGRect frame;
            frame.origin.x = self.scrollView.frame.size.width * i;
            frame.origin.y = 0;
            
            frame.size = _scrollView.frame.size;
            
            //CardView *cardView = [[CardView alloc] initWithBusinessData:business andFrame:frame];
            
            
               // [self.scrollView addSubview:cardView];
            
            
            //cardView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
           // i++;
            
            self.scrollView.contentSize = CGSizeMake(i*(self.scrollView.frame.size.width), self.scrollView.frame.size.height);
           // self.pageControl.numberOfPages=i;
            
        }
}


NSNumber
        
- (void) updateScreenView:(NSNumber *)loadIdx
        {
            int loadIndex = [NSNumber numberWithInt: loadIdx];
            //loadIdx;
            if (_responseIn && _responseIn.count > 0)
            {
                // Here add only a subview corresponding to loadIndex
                
                UIView *responseView = [_responseIn objectAtIndex:   loadIndex];
                [self.scrollView addSubview: _responseIn];
                
                // Here we schedule another call of this function if there is anything
                if (loadIndex < _responseIn.count - 1)
                {
                    [self performSelector:@selector(updateScreenView:) withObject:[NSNumber numberWithInt:(loadIndex+1) afterDelay:0.5f];
                     }
                     }
                     
                     }
                     


























-(void)alertView2
{
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL"
                      
                                message:@"Dee dee doo doo."
                                delegate:self
                            cancelButtonTitle:@"OK"
                        otherButtonTitles:nil];
}                     [alert show];








- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        // do something here...
    }
}







-(void) alertView
{
UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                               message:@"This is an alert."
                                                        preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {}];

[alert addAction:defaultAction];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
