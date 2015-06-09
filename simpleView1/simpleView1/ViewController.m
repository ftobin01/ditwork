//
//  ViewController.m
//  simpleView1
//
//  Created by F T on 07/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic, strong) UILabel   *speechLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 //   [self makeLabel2];
    //[self drawTriangle2];
    //[self.view.layer display];
 //   [self drawRect2:self.view.frame];
    [self setUpView];
}

-(void) setUpView
{
// (1) Creating a bitmap context, filling it with yellow as "background" color:
CGSize size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), YES, 0.0);
[[UIColor yellowColor] setFill];
    
UIRectFill(CGRectMake(0, 0, size.width, size.height));
    CGRect smallRect = CGRectMake(50,200,200,100);
    CGRect smallRect3 =CGRectMake(57,100,200,100);
// (2) Create a circle via a bezier path and stroking+filling it in the bitmap context:
//
  //  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:140 startAngle:0 endAngle:2 * M_PI clockwise:YES];
   
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect cornerRadius:4];
    [[UIColor greenColor] setFill];
    [bezierPath  fill];
    
    
    //[desiredStrokeColor setStroke];
    //[desiredFillColor setFill];
     [[UIColor greenColor] setFill];
    [bezierPath  fill];
    bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4];
    CGPoint  t1=CGPointMake(smallRect3.origin.x+ smallRect3.size.width-2,smallRect3.origin.y);
    CGPoint t2=CGPointMake( smallRect3.origin.x+smallRect3.size.width+10,smallRect3.origin.y);
    CGPoint t3=CGPointMake( smallRect3.origin.x+smallRect3.size.width,smallRect3.origin.y+15);
    
    [bezierPath moveToPoint: t1];
    [bezierPath addLineToPoint:t2];
    [bezierPath addLineToPoint:t3];
    
    [[UIColor blueColor] setStroke];
    [[UIColor blueColor] setFill];
    CGPoint  tl1=CGPointMake(smallRect3.origin.x-2,smallRect3.origin.y);
    CGPoint tl2=CGPointMake( smallRect3.origin.x-10,smallRect3.origin.y);
    CGPoint tl3=CGPointMake( smallRect3.origin.x-10,smallRect3.origin.y+15);
    
    [bezierPath moveToPoint: t1];
    [bezierPath addLineToPoint:t2];
    [bezierPath addLineToPoint:t3];
    
    [bezierPath  closePath];
    
    [[UIColor greenColor] setFill];
    [bezierPath  fill];
    [bezierPath moveToPoint: tl1];
    [bezierPath addLineToPoint:tl2];
    [bezierPath addLineToPoint:tl3];
    
    
   // [bezierPath addLineToPoint:t3];
    [bezierPath  closePath];
    bezierPath.lineWidth = 1.0;
    [[UIColor blueColor] setFill];
    [bezierPath fill];
    [bezierPath stroke]  ;
[[UIColor blackColor] setStroke];
bezierPath.lineWidth = 0.0;
    
[bezierPath stroke];
[[UIColor redColor] setFill];
[bezierPath fill];
    [[UIColor greenColor] setFill];
   // [bezierPath2 fill];
    
/*
// (3) Creating an array of images:
NSArray *rocks = @[[UIImage imageNamed:@"rock1"],
                   [UIImage imageNamed:@"rock2"],
                   [UIImage imageNamed:@"rock3"],
                   [UIImage imageNamed:@"rock4"],
                   [UIImage imageNamed:@"rock5"],
                   [UIImage imageNamed:@"rock6"],
                   [UIImage imageNamed:@"rock7"],
                   [UIImage imageNamed:@"rock8"],
                   [UIImage imageNamed:@"rock9"]];

// (4) Drawing rocks in a loop, each chosen randomly from the image set and drawn at a random position in a circular pattern:
for ( int i = 0; i < 100; i++)
{
    int idx = arc4random() % rocks.count;
    NSLog(@"idx = %d", idx);
    int radius = 100;
    int revolution = 360;
    float r = (float)(arc4random() % radius);
    float angle = (float)(arc4random() % revolution);
    float x = size.width/2 + r * cosf(angle * M_PI/180.0);
    float y = size.height/2 + r * sinf(angle * M_PI/180.0);
    CGSize rockSize = ((UIImage *)rocks[idx]).size;
    [rocks[idx] drawAtPoint:CGPointMake(x-rockSize.width/2, y-rockSize.height/2)];
}

 */
// (5) Deriving a new UIImage instance from the bitmap context:
UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
// (6) Closing the context:
UIGraphicsEndImageContext();
// (7) Setting the image view's image property to the created image, and displaying
UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
[self.view addSubview:iv];

}













-(void) createLabel
{
    _speechLabel = [[UILabel alloc] init];
}


-(void) fillLabel
{
    
    
    _speechLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greyBubble"]];
}


-(void) showLabel
{
    [self.view addSubview: _speechLabel];
}



-(void)makeLabel2
{
UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 420, 320, 100)];
myLabel.text=@"LAbel Text Hurray";
UIImage *img = [UIImage imageNamed:@"greyBubble"];
   // myLabel.setOpaque =NO;
CGSize imgSize = myLabel.frame.size;

UIGraphicsBeginImageContext( imgSize );
UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0);
[img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
    [self drawRect2:CGRectMake(imgSize.width,imgSize.height,50,50)];

UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

    
UIGraphicsEndImageContext();

myLabel.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
   
    
    myLabel.layer.cornerRadius = 5.0;
    myLabel.layer.masksToBounds = YES;
    
myLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:myLabel];
}

-(void)makeLabel3
{
    
    UIImage *bubble = [[UIImage imageNamed:@"greyBubble.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0,0 , 10)];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bubble];
    imgView.frame = CGRectZero;
    
    [UIView animateWithDuration:0.9
                     animations:^(void) {
                         imgView.frame = CGRectMake(50, 50, 200, 100);
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [self.view addSubview:imgView];
}

/*
- (void)drawRect:(CGRect)rect
{
    
 
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    for(int idx = 0; idx < self.points.count; idx++)
    {
        
        point = [self.points objectAtIndex:idx];//Edited
        if(idx == 0)
        {
            // move to the first point
            CGContextMoveToPoint(context, point.x, point.y);
        }
        else
        {
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
    
    CGContextStrokePath(context);

  }
*/


-(void)drawTriangle
{

    
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0) ;//start from here
    CGPathAddLineToPoint(path, nil, 20, 44);
    CGPathAddLineToPoint(path, nil, 40, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
}




-(void)drawRect2:(CGRect)rect {
    // Drawing code
    UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 420, 320, 100)];
    CGSize imgSize = myLabel.frame.size;
    CGFloat width = self.view.layer.frame.size.width;
    CGFloat height = self.view.layer.frame.size.height;
    
    UIGraphicsBeginImageContext( imgSize );    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
   // CGContextFillPath(context);
    

    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddPath(context, path);
    //  CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //  CGContextFillPath(path);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.frame = self.view.layer.bounds;
    
    CGPathMoveToPoint(path, nil, 30, 0);
    CGPathAddLineToPoint(path, nil, width, 0);
    CGPathAddLineToPoint(path, nil, width, height);
    CGPathAddLineToPoint(path, nil, 0, height);
    CGPathAddLineToPoint(path, nil, 30, 0);
    CGPathCloseSubpath(path);
    
    
    
    
    
    mask.path = path;
    CGPathRelease(path);
    UIGraphicsEndImageContext();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
