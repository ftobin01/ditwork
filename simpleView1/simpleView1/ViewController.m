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
@property (nonatomic, strong) UIBezierPath *bezierPath;
@end

@implementation ViewController

static NSDictionary *commsInArray;
static NSDictionary *commsOutArray;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 //   [self makeLabel2];
    //[self drawTriangle2];
    //[self.view.layer display];
 //   [self drawRect2:self.view.frame];
    [self setUpView];
  //  UIGraphicsEndImageContext();
    
   [self showResponseOut : @"text Out"];
        [self showResponseIn : @"text  In"];
    [self drawDateBubble];
    UIGraphicsEndImageContext();
}
-(void) setUpView
{
// (1) Creating a bitmap context, filling it with yellow as "background" color:
CGSize size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), YES, 0.0);
[[UIColor yellowColor] setFill];
UIRectFill(CGRectMake(0, 0, size.width, size.height));

}

-(void)showResponseOut : ( NSString *) textStr
{
    //CGRect smallRect = CGRectMake(50,200,200,100);
    CGRect smallRect3 =CGRectMake(150,100,200,100);

    //[ UIGraphicsGetCurrentContext()] fill];
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4] ;
    
    UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 420, 320, 100)];
    CGPoint  t1=CGPointMake(smallRect3.origin.x+ smallRect3.size.width-2,smallRect3.origin.y);
    CGPoint t2=CGPointMake( smallRect3.origin.x+smallRect3.size.width+10,smallRect3.origin.y);
    CGPoint t3=CGPointMake( smallRect3.origin.x+smallRect3.size.width,smallRect3.origin.y+15);
    
    [_bezierPath moveToPoint: t1];
    [_bezierPath addLineToPoint:t2];
    [_bezierPath addLineToPoint:t3];
    
    [_bezierPath  closePath];
    
   
    // [bezierPath addLineToPoint:t3];
  //  [bezierPath  closePath];
    _bezierPath.lineWidth = 0.0;
 /*
    [[UIColor blackColor] setStroke];
bezierPath.lineWidth = 0.0;
   */
[_bezierPath stroke];
[[UIColor redColor] setFill];
[_bezierPath fill];
   
[self drawText :  textStr: smallRect3];
// (5) Deriving a new UIImage instance from the bitmap context:
UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
// (6) Closing the context:
//UIGraphicsEndImageContext();
// (7) Setting the image view's image property to the created image, and displaying
UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
[self.view addSubview:iv];

}


-(void) drawDateBubble
{
            //CGRect smallRect = CGRectMake(50,200,200,100);
        CGRect smallRect3 =CGRectMake(200,300,20,50);
        
        //[ UIGraphicsGetCurrentContext()] fill];
        _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4] ;
    
        
        
        // [bezierPath addLineToPoint:t3];
        //  [bezierPath  closePath];
        _bezierPath.lineWidth = 0.0;
        /*
         [[UIColor blackColor] setStroke];
         bezierPath.lineWidth = 0.0;
         */
        [_bezierPath stroke];
        [[UIColor redColor] setFill];
        [_bezierPath fill];
        
        [self drawText :  @" 26 May 2015": smallRect3];
        // (5) Deriving a new UIImage instance from the bitmap context:
        UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
        // (6) Closing the context:
        //UIGraphicsEndImageContext();
        // (7) Setting the image view's image property to the created image, and displaying
        UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
        [self.view addSubview:iv];
        
    
}




-(void)showResponseIn: ( NSString *) textStr
{
    CGRect smallRect = CGRectMake(10,150,200,100);
    //CGRect smallRect3 =CGRectMake(57,100,200,100);
    
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect cornerRadius:4];
  /*
    
    CGPoint  tl1=CGPointMake(smallRect.origin.x-2,smallRect.origin.y);
    CGPoint tl2=CGPointMake( smallRect.origin.x-10,smallRect.origin.y);
    CGPoint tl3=CGPointMake( smallRect.origin.x-10,smallRect.origin.y+15);
  
    [_bezierPath moveToPoint: tl1];
    [_bezierPath addLineToPoint:tl2];
    [_bezierPath addLineToPoint:tl3];
    
   
    // [bezierPath addLineToPoint:t3];
    
   
   [_bezierPath  closePath];
   */
   
   _bezierPath.lineWidth = 0.0;
   
    
    [_bezierPath stroke];
   
    [[UIColor greenColor] setFill];
    [_bezierPath fill];
    
    [self drawText : textStr : smallRect];
    // (5) Deriving a new UIImage instance from the bitmap context:
    UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
    // (6) Closing the context:
  //  UIGraphicsEndImageContext();
    // (7) Setting the image view's image property to the created image, and displaying
    UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
    [self.view addSubview:iv];
    
  
}


-(void) makePhotoCircle
{
// (2) Create a circle via a bezier path and stroking+filling it in the bitmap context:
//
//  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:140 startAngle:0 endAngle:2 * M_PI clockwise:YES];
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

/*

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

*/ 
 
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


-(void)drawText : (NSString *) textStr : (CGRect) drawRect
{
    
   // CGContextRef *currentContext = UIGraphicsGetCurrentContext();
// Create text attributes
NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0]};

// Create string drawing context
NSStringDrawingContext *drawingContext = [[NSStringDrawingContext alloc] init];
drawingContext.minimumScaleFactor = 0.2; // Half the font size
    UILabel *label = [[UILabel alloc] initWithFrame: drawRect];
    label.font = [UIFont systemFontOfSize: 18.0];
    CGSize maxSize = CGSizeMake(label.frame.size.width,MAXFLOAT);
    
CGRect labelRect = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: label.font} context:drawingContext];
    
    NSLog(@"size %@", NSStringFromCGSize(labelRect.size));
    
    
    
    
//CGRect drawRect = CGRectMake(0.0, 0.0, 200.0, 100.0);
[textStr drawWithRect:labelRect
             options:NSStringDrawingUsesLineFragmentOrigin
          attributes:textAttributes
             context:drawingContext];
}


/* Creates an image with a home-grown graphics context, burns the supplied string into it. */
/*
- (UIImage *)burnTextIntoImage:(NSString *)text :(UIImage *)img {
    
    NSFont *font = [NSFont fontWithName:@"Palatino-Roman" size:14.0];
    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil]
    
    
    
    
    UIGraphicsBeginImageContext(img.size);
    
    CGRect aRectangle = CGRectMake(0,0, img.size.width, img.size.height);
    [img drawInRect:aRectangle];
    
    [[UIColor redColor] set];           // set text color
    NSInteger fontSize = 14;
    if ( [text length] > 200 ) {
        fontSize = 10;
    }
    UIFont *font = [UIFont boldSystemFontOfSize: fontSize];     // set text font
    
    [ text drawInRect : aRectangle                      // render the text
             withFont : font
        lineBreakMode : NSLineBreakByTruncatingTail  // clip overflow from end of last line
            alignment : NSTextAlignmentCenter ];
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();   // extract the image
    UIGraphicsEndImageContext();     // clean  up the context.
    return theImage;
}

*/










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



/*
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

 
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) makeTestComms
{
    commsInArray = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"10:15",@"Hello", nil];
}


@end
