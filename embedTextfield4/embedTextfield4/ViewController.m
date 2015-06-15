//
//  ViewController.m
//  embedTextfield4
//
//  Created by F T on 13/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

// Programming Notes

// Ok  REached Deadline without full functionality being
// implemented.
//
// Decide to go with a 'simple' UIView - as is supposed to be able to recive and process events. And scrolling should have been able to be simulated at least - or so i thought.

// the requirments seemed pretty simple however as It will be apparent on testing I had - routines  with CGGraphics contexts and subviews could do with some touching up.

// Despite masterng UIBEzierPAth to create a message shape and have it displayed I could not get scrolling work despite coming at if from a variety of angles.


// Thinking initially that all this would be straight forward
// I went ahead an wrote the back end for message processing - while I was researching - fully expecting to be implementing in time.

// So I am dissapponted its not finished; this is what I could do in the time allowed.

// FT

#include <time.h>
#import "ViewController.h"
#include "constants.h"


@interface ViewController ()
@property (nonatomic) CALayer *blueLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property(readwrite, copy, nonatomic) NSArray *tabStops;
@property (nonatomic, strong) UIScrollView *WZScrollView;

-(CGRect) makeBoundingRect : (NSString *) textStr : (NSDictionary *) textAttributes;@property NSTimer *timer;
-(void)onTick : (NSTimer *)aTimer;
@end


@implementation ViewController

// Message Storage Dictionaries
static NSMutableDictionary *commsInArray;
static NSMutableDictionary *commsOutArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpView];
 
    /*
     _WZScrollView = [[UIScrollView  alloc] initWithFrame : CGRectMake(5,60,400,500)];
     _WZScrollView.contentSize = CGSizeMake(320, 400);
     _WZScrollView.showsHorizontalScrollIndicator = NO;                ;
     
     _WZScrollView.backgroundColor = [UIColor grayColor];
     
     [self.view addSubview:_WZScrollView];
     */
    //[self turnOffKeyBoard];
    NSLog(@"Creating timer...");
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                              target:self
                                            selector:@selector(onTick:)
                                            userInfo:nil
                                             repeats:YES];
    [_myTextField becomeFirstResponder];
}




//TODO: Finish Timer Call commsArrayProcessing function

// This function runs every 5 seconds _ I intend using it to call a methjod every  5 seconds to see if input has been recieved - to make sure screen messages are outputted correctly in Time order.


-(void)onTick:(NSTimer *)aTimer {
    NSLog(@"Listening for Messages In...");
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
   //[self showResponseIn : _myTextField.text : @"10/7/58 :12:22:36"];
    [self showResponseOut : _myTextField.text ];
     _myTextField.text=@"";
    [_myTextField nextResponder];
    return YES;
}


//TODO: Handle Keyboard situation properly - Scroll UP screen for input and down when not - need delegate.
-(void) turnOffKeyBoard
{
    UIView *dummyView = [UIView new];
    _myTextField.inputView = dummyView; // Hide keyboard, but show blinking cursor
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) setUpView
{
    //_mainMsgView.scrollEnable = YES; - when scroll view
    
    // (1) Creating a bitmap context, filling it with yellow as "background" color:
//!!!:
    //CGSize size = CGSizeMake(self.mainMsgView.bounds.size.width, self.mainMsgView.bounds.size.height);
//!!!:
    //UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height+100), YES, 0.0);
    //[[UIColor yellowColor] setFill];
    //UIRectFill(CGRectMake(0, 0, size.width, size.height-80));
    
    //_tabStops =[[NSArray alloc] init ];
    
    //done= FALSE;
    //   [[rectView layer] renderInContext:UIGraphicsGetCurrentContext()];
    NSLog(@"initialsised Context on SetUp");
    //}
    
    
}

#pragma mark Routines to Prepare  Message Boxes for Screen


// Will  Routine be called to prepare  Message Out and store in CommsOut Array

-(NSDictionary *) makeOutGoingMsg : (NSString *)textStr
{
    NSString *dateStr =
    [[NSString alloc] initWithString : [self ISO8601TimeAndDateString]];
    NSDictionary *newMsg = [NSDictionary dictionaryWithObject : dateStr forKey: textStr];
    // assign Dictionaery element to date srt and
    
    //[self showResponseOut: textStr : dateStr]; // thizs will become assign to commsOutArray - when everything working
    
    return (newMsg);
}



// For Messages In
// Currently workin on Response Out - when that is working Fully
// will use it to make this method.
-(void)showResponseIn : (NSString *) textStr : (NSString *) timmeStamp
{
    //CGRect smallRect = CGRectMake(50,200,200,100);
    CGRect smallRect3 =CGRectMake(150,100,200,100);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
    
   // [ UIGraphicsGetCurrentContext()] fill];
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4] ;
  
    CGPoint  t1=CGPointMake(smallRect3.origin.x+ smallRect3.size.width-3,smallRect3.origin.y);
    CGPoint t2=CGPointMake( smallRect3.origin.x+smallRect3.size.width+10,smallRect3.origin.y);
    CGPoint t3=CGPointMake( smallRect3.origin.x+smallRect3.size.width,smallRect3.origin.y+15);
    
    [_bezierPath moveToPoint: t1];
    [_bezierPath addLineToPoint:t2];
    [_bezierPath addLineToPoint:t3];
    
    [_bezierPath  closePath];
    
    _bezierPath.lineWidth = 0.0;
    
    [_bezierPath stroke];
    [[UIColor redColor] setFill];
    [_bezierPath fill];
   // [self drawText5 :  textStr: smallRect3 ];
    
    // (5) Deriving a new UIImage instance from the bitmap context:
    UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
    // (6) Closing the context:
    //UIGraphicsEndImageContext();
    // (7) Setting the image view's image property to the created image, and displaying
    UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
    [_mainMsgView addSubview :iv];
    
}


-(void) drawDateBubble : (NSString *) dateStr
{
    //CGRect smallRect = CGRectMake(50,200,200,100);
    CGRect smallRect3 =CGRectMake(200,300,20,50);
    
    NSDictionary *dateTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
    
    
    //[ UIGraphicsGetCurrentContext()] fill];
    _bezierPath = [UIBezierPath bezierPathWithRoundedRect:smallRect3 cornerRadius:4] ;
    
    [self drawText :  @" 26 May 2015": smallRect3 :dateTextAttributes ];
   
    
    
        UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
        UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
    [_mainMsgView addSubview:iv];
    
    
}



//MARK:

-(void)showResponseOut: ( NSString *) textStr
{
    static CGRect txtRect;
   // txtRect.origin.x=0;
    //txtRect.origin.y=0;
    UIColor *color = [UIColor MSG_TXT_COLOR]; /* Some color */
    //color,
    NSDictionary *textAttributes =
    @{NSFontAttributeName: [UIFont systemFontOfSize:MSG_FONT_SIZE],NSForegroundColorAttributeName: color};
     txtRect = [self makeBoundingRect :textStr: textAttributes];
    
    txtRect.origin.x=10;
    txtRect.origin.y+=200;
    // CGRect timeRect = [self makeBoundingRect :timeString: smallTextAttributes];
    
    
    NSMutableAttributedString *timeStamp;
    timeStamp = [self makeTimeStamp: 8 ];//NSMutableAttributedString timeString=@"15:53";
  
    CGRect timeRect = [timeStamp boundingRectWithSize:CGSizeMake(txtRect.size.width, 10000) options:( NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading) context:nil];
    
    CGRect smallRect = CGRectMake(txtRect.origin.x,
                                  txtRect.origin.y,
                                  txtRect.size.width + timeRect.size.width,
                                  txtRect.size.height +  timeRect.size.height);
    
    CGRect screenRect=_mainMsgView.frame;
    CGSize size = CGSizeMake(screenRect.size.width, screenRect.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), YES, 0.0);
    static BOOL done1=FALSE;
   
    smallRect.origin.y+=smallRect.size.height + 10; // change 10 to #define
    CGRect msgRect = CGRectInset(smallRect,2,4);
   
    UIColor *messageColor = OUT_MSG_COLOR;
    NSMutableAttributedString *mainMessage = [[NSMutableAttributedString alloc] initWithString: textStr attributes: textAttributes];
    
    [mainMessage appendAttributedString : timeStamp];
    
    [self makeBox : msgRect : messageColor];
    
    [self addTriangle : msgRect : messageColor];
    
    [self drawText5 : mainMessage : msgRect ];
    UIImage *fImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:fImg];
    [_mainMsgView addSubview:iv];
    UIGraphicsEndImageContext();
    //[self scrollView:_mainMsgView :20];
    // Now SCroll Up
    [self scrollAll_3 : -20];
    [_mainMsgView setNeedsDisplay];

}


// Alot of trouble - to try and get Right Justification working
// by using NSTextALignment and then Tabs - after  days - resorted to /n and padding. most  this stuff can prob. be removed now with no effect.

-(NSMutableAttributedString *) makeTimeStamp: (float) width // : BOOL msgRec : BOOL msgRead
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // [paragraphStyle tabStops]
   // float //width = 150.0f ;//smallRect.size.width;
    
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
    
    NSString *timeStr = [NSString stringWithFormat:@"\n          %@", [self  timeFromISO860String ]];
   // Newline Pad out String in lieu of Right Justification
    NSString *newTimeStamp = [[NSString alloc ] initWithFormat: @"\n%*c%@", (int)(14 - timeStr.length), ' ', timeStr];
    NSMutableAttributedString *timeStamp =
    [[NSMutableAttributedString alloc]
     initWithString : newTimeStamp
     attributes :
     @{ NSParagraphStyleAttributeName : paragraphStyle,
        NSKernAttributeName : @1.0,
        NSFontAttributeName : labelFont,
        NSForegroundColorAttributeName : labelColor,
        NSShadowAttributeName : shadow }];
    return (timeStamp);
}


#pragma mark  - different Scrolling routines


-(void)scrollAll_1 : (float) height
{
    static BOOL done=FALSE;
    if (!done)
    {
        //NSAffineTransform *
 /*
         CGAffineTransform * xform = CGAffineTransformIdentity;
        CGAffineTransform  xform  CGAffineTransformIdentity;        [xform translateXBy:50.0 yBy:20.0]
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGAffineTransform transform;
        CGAffineTransformTranslate(transform, CGRectGetMidX(tileFrame),
                                   CGRectGetMidY(tileFrame));
        CGContextConcatCTM(context, transform);
   */;
   }
}

-(void)scrollAll_2 : (float) height
{
    
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(),0 ,height);
        
}



-(void)scrollAll_3 : (float) height
{
   
    CGAffineTransform transform = CGAffineTransformTranslate(_mainMsgView.transform,0 , -20);
    self.view.transform =  transform;
    CGRect rect = _mainMsgView.frame;
    rect.size.height+=50.f;
    _mainMsgView.frame =rect;
    NSLog(@"");
}
    
-(void)scrollAll_4
{
    CGAffineTransform transform = CGAffineTransformTranslate(_mainMsgView.transform,0 , -20);
    CGContextConcatCTM ( UIGraphicsGetCurrentContext(), transform );
}
    
-(void)ScrollUp : (float) scrollHeight
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = _mainMsgView.frame;
    
        rect.origin.y += scrollHeight;
        rect.size.height -= scrollHeight;
    
    _mainMsgView.frame = rect;
    
    [UIView commitAnimations];
}


-(void) scrollAllViews : (float) scrollHeight
{
    for (UIView *aView in _mainMsgView.subviews)
        [self  scrollView : aView : scrollHeight ];
    [_mainMsgView setNeedsDisplay];
}


-(void)scrollView : (UIView *) viewtoScroll :(float) scrollHeight
{
    
   [UIView beginAnimations:nil context:NULL];
[UIView setAnimationDuration:0.3];
    CGRect rect = viewtoScroll.frame;
    rect.origin.y += scrollHeight;
   // rect.size.height -= scrollHeight;
    viewtoScroll.frame = rect;
    [UIView commitAnimations];
}

#pragma mark  - UIBezier Drawing Routines

-(void)makeBox : (CGRect) smallRect : (UIColor *) boxColor
{
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


-(CGRect) makeBoundingRect : (NSString *) textStr : (NSDictionary *) textAttributes
{
    NSAttributedString *header = [[NSAttributedString alloc ] initWithString : textStr
             attributes: textAttributes];
    
    // Create string drawing context
    NSStringDrawingContext *drawingContext = [[NSStringDrawingContext alloc] init];
    drawingContext.minimumScaleFactor = 0.5;
      float maxMsgWidth=150.0f;
    
    CGRect boundingRect = [header boundingRectWithSize:CGSizeMake(maxMsgWidth, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context: nil];
    
    NSLog(@"size %@", NSStringFromCGSize(boundingRect.size));
    
    return (boundingRect);
}



-(void)drawText : (NSString *) textStr : (CGRect) drawRect :(NSDictionary *) textAttributes
{
    
    //  [self  setUpView];
    CGRect textRect = CGRectMake(drawRect.origin.x+2,drawRect.origin.y+1, drawRect.size.width, drawRect.size.height);
    
    [textStr drawWithRect:textRect
                  options:NSStringDrawingUsesLineFragmentOrigin
               attributes:textAttributes
                  context:nil] ; //]drawingContext];
}



// !!!: Main Drawing Function
-(void)drawText5 : (NSMutableAttributedString *) textStr : (CGRect) drawRect
{
    [textStr drawWithRect:drawRect
                  options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
    context:nil] ; //]drawingContext];
   
    }




#pragma mark - Comms Array Processing

/*
 
 Logic  for Processing Comms
 
 Read Comms In Array -
 While not Empty
 - Read Comms Out Array
 Show Data from one with earliest time stamp
 Keep REading from Quesue whileit has ealrliler time stamp
 
 
// Code
 NSDictionary *msgDictIn = [[NSDictionary alloc] init];
 NSDictionary *msgDictOut  = [[NSDictionary alloc] init];
 
 msgDictIn = [self readCommsInArray];
 msgDictOut = [self readCommsOutArray];
 
 Do
 {
 readCommsInArray
 readCommsOutArray
 
 while msgIN and  MSG out are n ot nil
 {
 msgInTime  = seperateTimeStamp : msgDictIn;
 msgOutTime = seperateTimeStamp : msgDictOut;
 while MsgOutTime < MsgInTime
 readCommsOutToTimeStamp : MsgInTime
 while MSGTimeIn < MSgOutTime
 readCommsOutToTimeStamp : MSgOutTime
 }
 if msgDictOut== nil and (!msgDictIn)
 readCommsInToTimeStamp : Long Future Date time_t
 if msgDictIn ==Nil and (!msgDictOut)
 readCommsOutToTimeStamp :Long FutureDate
 } <Every 10Second>s
 
 
 readAndShowCommsInToTimeStamp : (NSString *) timeStamp
 {
 do {
 msg readCommsInArray
 seperate msgtimeStamp
 show Message
 } while msgTimeStamp <= timeStamp
 }
 
 
 
 
 -(void) compareTimeStamps (NSString *) timeStamp1: (NSString *) timestanmp2
 {
 // look up time date functions for method for this
 }
 
 
 -(NSDictionary*) readCommsInArray
 {
 //In live system would be converting from JSon here
 NSDictionary *msg = [[NSDictionary alloc] init];        if (!commsInArray)
 {
 // Copy ??
 msg =[self _commsInArray objectAtIndex: 0];
 [_commsInArray removeObjectAtIndex : 0];
 }
 return (msg);
 }
 
 -(NSDictionary*) readCommsOutArray
 {
 //In live system would be converting from JSon here
 NSDictionary *msg = [[NSDictionary alloc] init];
 if (!commsOutArray)
 {
 msg =[self _commsOutArray objectAtIndex: 0];
 [_commsInArray removeObjectAtIndex : 0];
 }
 return (msg);
 }
 */



-(void) makeTestComms
{
    commsInArray = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                    @"17/3/2015 20:31:15",
                    @"Happy St Patricks Day! Still pretty wrecked! ",
                    @"18/4/2015 15:34:16",
                    @"Gonna send You a Video soon! Weather has been good so I haven't put the hoop down",
                    @"18/4/2015 19:30:31",
                    @"Awesome",
                    nil];
    
    commsOutArray = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                     @"17/3/2015 2:59:01",
                     @"Need to go next time",
                     @"17/03/2015 2:59:05",
                     @"When I come to Visit :)",
                     @"17/3/2015 20:03:16",
                     @"Happy Irish Day *&&&* have fun :)",
                     nil];
    
}





#pragma mark   - Time and Date to International Standard ISO860




-(NSString *)timeFromISO860String
{
    
    int ISODATE=0;
    int ISOTIME=1;
    int ISOSECONDSFRACTION=2;
    int ISOTZ=3;
    
    NSString *timeStamp =[self ISO8601TimeAndDateString];    NSArray *ISOcomponents  = [timeStamp componentsSeparatedByCharactersInSet:
                                                                                        [NSCharacterSet characterSetWithCharactersInString:@"T.+"]];
    
    NSLog(@"getTimefromISO... ISOcomponents = %@", ISOcomponents);
    return(ISOcomponents[ISOTIME]);
}





// Using C functions to save up to 7s of time with each message







- (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) {
        return nil;
    }
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    
    
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}


-(NSString *)ISO8601TimeAndDateString {
    struct tm *timeinfo;
    char buffer[80];
    time_t rawtime = [[NSDate date] timeIntervalSince1970] - [[NSTimeZone localTimeZone] secondsFromGMT];
    timeinfo = localtime(&rawtime);
    
    strftime(buffer, 80, "%Y-%m-%dT%H:%M:%S%z", timeinfo);
    
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}









@end



#pragma mark - Future Storage Area


/*
 
 -(void) makePhotoCircle
 {
 // (2) Create a circle via a bezier path and stroking+filling it in the bitmap context:
 //
 //  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:140 startAngle:0 endAngle:2 * M_PI clockwise:YES];
 }
 */









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

//height for baseline
// Get height of text using font???
//   CGSize size = [myText sizeWithFont:myFont forWidth:myFontWidth.0 lineBreakMode:UILineBreakModeWordWrap];
// Reduce Base Line by heigth of message and GAP
// Scroll up Screen by this amount


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


