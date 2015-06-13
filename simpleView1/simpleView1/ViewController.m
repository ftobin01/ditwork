//
//  ViewController.m
//  simpleView1
//
//  Created by F T on 07/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//



// Programming Notes:
//
// Implemented a simple View as I did not feel that Whats App is based on a table.
// Basic functionality for writing messages to a view based on whats app look and feel have been implement.
// Test Data input is processed from a dictionary as this App
// is anticipated being used with JASON type data frm a network.
//
// It took several days before I gave up trying to get UTTextAlignnemnt to work for Right Justification.
//  Gave up in the end and managed it by checking width
//  length and Padding Space. I am amazed that a simple thing like this is not easy to do in IOS.
//
// It took another couple of days to Get bounding Rect with size to work - probably quicker to write from scratch.
//
// It took another few days to try everything except UIBezierPaths looking for another way .. eventually realized - it should be used.
//
// TO DO
// TO give  scrolling ability  add in a ScrollView the size of the Screen and then subclass it so everything moves at once - if I get time.
//
//  Put in Rounded Photgraph.
//
// Last UPdate: 12:08 Mon 14/6/2015


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#include "constants.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel   *speechLabel;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property(readwrite, copy, nonatomic) NSArray *tabStops;


-(CGRect) makeBoundingRect : (NSString *) textStr : (NSDictionary *) textAttributes;
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
    [self showResponseIn : @" bljllkjl text  In, loads of text, teasdfasa bbkkkbbbhj"];
    //[self drawDateBubble];
    //  UIGraphicsEndImageContext();
    /*
     [self makeBoundingRect : @"Hello there World"];
     [self makeBoundingRect : @"Hello there World,Hello there World, Hello there World,Hello there World"];
     [self makeBoundingRect : @"Hello there World, Hello there World , Hello there World "];
     [self makeBoundingRect : @"Hello there WorldHello there World,"];
     */
    
}
-(void) setUpView
{
    // (1) Creating a bitmap context, filling it with yellow as "background" color:
    CGSize size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), YES, 0.0);
    [[UIColor yellowColor] setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    _tabStops =[[NSArray alloc] init ];
    
}

-(void)showResponseOut : ( NSString *) textStr
{
    //CGRect smallRect = CGRectMake(50,200,200,100);
    CGRect smallRect3 =CGRectMake(150,100,200,100);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
    
    
    //[ UIGraphicsGetCurrentContext()] fill];
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4] ;
    
    UILabel *myLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 420, 320, 100)];
    CGPoint  t1=CGPointMake(smallRect3.origin.x+ smallRect3.size.width-3,smallRect3.origin.y);
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
    [self drawText :  textStr: smallRect3: textAttributes];
    
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
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
    
    
    //[ UIGraphicsGetCurrentContext()] fill];
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4] ;
    
    [self drawText :  @" 26 May 2015": smallRect3 :textAttributes ];
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

    
    UIColor *color = [UIColor MSG_TXT_COLOR]; /* Some color */
    //color,
    NSDictionary *textAttributes =
    @{NSFontAttributeName: [UIFont systemFontOfSize:MSG_FONT_SIZE],NSForegroundColorAttributeName: color};
    
    NSMutableAttributedString *timeString =[[NSMutableAttributedString alloc] initWithString: @"21:14:22    " ];
    
  //  NSDictionary *smallTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:25.0f]};
    
    
    CGRect txtRect = [self makeBoundingRect :textStr: textAttributes];
    
   // CGRect timeRect = [self makeBoundingRect :timeString: smallTextAttributes];
    CGFloat width = txtRect.size.width ; // whatever your desired width is
    CGRect timeRect = [timeString boundingRectWithSize:CGSizeMake(width, 10000) options:( NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading) context:nil];
    
    
    CGRect smallRect = CGRectMake(txtRect.origin.x,
                        txtRect.origin.y,
                        txtRect.size.width + timeRect.size.width,
                        txtRect.size.height +  timeRect.size.height);
    
    ;
    
    smallRect.origin.x = 50;
    smallRect.origin.y =270;
    
    CGRect msgRect = CGRectMake(50,270,smallRect.size.width+2,smallRect.size.height+4);
    
    UIColor *messageColor = [UIColor blueColor];
    
    
    NSMutableAttributedString *mainMessage = [[NSMutableAttributedString alloc] initWithString: textStr attributes: textAttributes];
  
    
    NSMutableAttributedString *timeStamp;
    
    timeStamp = [self makeTimeStamp: msgRect   ];
   
    [mainMessage appendAttributedString : timeStamp];
    
    
    
    
    [self makeBox : msgRect : messageColor];
    
    [self addTriangle : msgRect : messageColor];
    
    [self drawText5 : mainMessage : msgRect ];
  
    // [self drawTextAtEnd : @"\u2714" : msgRect : smallTextAttributes];
    
    // (5) Deriving a new UIImage instance from the bitmap context:
    UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
    // (6) Closing the context:
    //  UIGraphicsEndImageContext();
    // (7) Setting the image view's image property to the created image, and displaying
    UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
    
    
    [self.view addSubview:iv];
    
    
}


-(NSMutableAttributedString *) makeTimeStamp : (CGRect) smallRect// : BOOL msgRec : BOOL msgRead
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // [paragraphStyle tabStops]
    float width = smallRect.size.width;
    
    
    _tabStops = @[[[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentRight location:width - 12 options:nil], [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentRight location:width options:nil]];
    
    
    
    paragraphStyle.alignment = NSTextAlignmentRight;
    paragraphStyle.lineSpacing = TIMESTAMP_FONT_SIZE;
    paragraphStyle.tabStops = _tabStops;
    UIFont * labelFont = [UIFont fontWithName:FONT_HELVETICA size:TIMESTAMP_FONT_SIZE];
    UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor : BLACK_SHADOW];
    [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
    [shadow setShadowBlurRadius : 1];
    
   
    
   [paragraphStyle setAlignment:NSTextAlignmentRight];
    
    //make Time String
    CGFloat tabInterval = -width +20.f;
    paragraphStyle.defaultTabInterval = tabInterval;
   
    NSMutableArray *tabStops2;
    [tabStops2 addObject:[[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentRight location:tabInterval  options:nil]];

    [paragraphStyle setTabStops: tabStops2];
    
    NSMutableAttributedString *timeStamp =
    [[NSMutableAttributedString alloc]
     initWithString : @"\t12:15:75"
     attributes :
     @{ NSParagraphStyleAttributeName : paragraphStyle,
       NSKernAttributeName : @1.0,
       NSFontAttributeName : labelFont,
       NSForegroundColorAttributeName : labelColor,
       NSShadowAttributeName : shadow }];
    
    
    return (timeStamp);
}












-(void)makeBox : (CGRect) smallRect : (UIColor *) boxColor
{
    //[[UIColor boxColor] setStroke];
    [boxColor setStroke];
    [boxColor  setFill];
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect cornerRadius:4];
    [ _bezierPath stroke];
    [_bezierPath fill];
}


-(void)addTriangle : (CGRect) smallRect : (UIColor *) triangleColor
{
    CGPoint  tl1=CGPointMake(smallRect.origin.x+3,smallRect.origin.y-.3f);
    CGPoint tl2=CGPointMake( smallRect.origin.x-15,smallRect.origin.y-.1);
    CGPoint tl3=CGPointMake( smallRect.origin.x+3,smallRect.origin.y+15);
    
    _bezierPath.lineWidth = 0.0;
    [_bezierPath moveToPoint: tl1];
    [_bezierPath addLineToPoint:tl2];
    [_bezierPath addLineToPoint:tl3];
    // [_bezierPath addLineToPoint:tl1];
    
    [_bezierPath  closePath];
    [ _bezierPath stroke];
    [triangleColor setFill];
    [_bezierPath fill];
    
    
}

//Padding
/*
format TimeStamp
{
 const CGSize msgTextSize = [msgText sizeWithAttributes: userAttributes];
 const CGSize timestampTextSize = [timeStamp sizeWithAttributes: userAttributes];
 
 
 shareimprove this answer
	
- check length of Attributed String 1
-check lenght of Attributed String 2
if msgTextSize.width  + timeStampTextSize.width   > msgBox.width
    {
    - add a newlineand padd out nearly whole line first
    }
 else
    paddout to end of width
 return new timestamp.

    add newline to strng and pad it to end
newTimeStamp = [NSMutableArray alloc ] initWithFormat @"\n%*c%@", 14 - oldTimeStamp.length, ' ', oldTimeStamp);
}
*/

[[NSString alloc] initWithFormat:@”(%f,%f)”,center.x,center.y]
Moreover, 14is the width that you want.
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


-(CGRect) makeBoundingRect : (NSString *) textStr : (NSDictionary *) textAttributes
{
    NSAttributedString *header = [[NSAttributedString alloc ] initWithString : textStr
                                                                   attributes: textAttributes];
    
    
    // CGContextRef *currentContext = UIGraphicsGetCurrentContext();
    // Create text attributes
    //NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:5.0f]};
    
    // Create string drawing context
    NSStringDrawingContext *drawingContext = [[NSStringDrawingContext alloc] init];
    drawingContext.minimumScaleFactor = 0.5; // Half the font size
    
    //    UILabel *label = [[UILabel alloc] initWithFrame: drawRect];
    //  label.font = [UIFont systemFontOfSize: 18.0];
    
    //   CGSize maxSize = CGSizeMake(label.frame.size.width,MAXFLOAT);
    
    //   CGRect labelRect = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: label.font} context:drawingContext];
    float maxMsgWidth=150.0f;  // ScreenSize/2 - padding
    // actually it is screensize/2-origin.x
    CGRect boundingRect = [header boundingRectWithSize:CGSizeMake(maxMsgWidth, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                        context: nil];
    
    /*
     CGRect boundingRect = [header boundingRectWithSize:CGSizeMake(300.f, CGFLOAT_MAX)
     options : NSStringDrawingUsesLineFragmentOrigin
     context: nil];
     */
    NSLog(@"size %@", NSStringFromCGSize(boundingRect.size));
    
    
    
    
    //CGRect drawRect = CGRectMake(0.0, 0.0, 200.0, 100.0);
    //     [textStr drawWithRect:labelRect
    //                  options:NSStringDrawingUsesLineFragmentOrigin
    //               attributes:textAttributes
    //                  context:drawingContext];
    // }
    
    return (boundingRect);
}








-(void)drawText : (NSString *) textStr : (CGRect) drawRect :(NSDictionary *) textAttributes
{
    
    
    
    CGRect textRect = CGRectMake(drawRect.origin.x+2,drawRect.origin.y+1, drawRect.size.width, drawRect.size.height);
    
    [textStr drawWithRect:textRect
                  options:NSStringDrawingUsesLineFragmentOrigin
               attributes:textAttributes
                  context:nil] ; //]drawingContext];
}

-(void)drawText5 : (NSMutableAttributedString *) textStr : (CGRect) drawRect
{
    
    
    
    CGRect textRect = CGRectMake(drawRect.origin.x+2,drawRect.origin.y+1, drawRect.size.width, drawRect.size.height);
    
    [textStr drawWithRect:textRect
                  options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                  context:nil] ; //]drawingContext];
}






-(void)drawTextAtEnd : (NSString *) textStr : (CGRect) drawRect :(NSDictionary *) textAttributes
{
    
    //   [textStr appendAttributedString: textStr];
    
    CGRect textRect = CGRectMake(drawRect.origin.x+2,drawRect.origin.y+1, drawRect.size.width, drawRect.size.height);
    
    [textStr drawWithRect:textRect
                  options:0
               attributes:textAttributes
                  context:nil] ; //]drawingContext];
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
