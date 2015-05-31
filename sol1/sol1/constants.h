//
//  constants.h
//  sol1
//
//  Created by F T on 30/05/2015.
//  Copyright (c) 2015 F T. All rights reserved.
//

#ifndef sol1_constants_h
#define sol1_constants_h



#define RANDOM_COLOR                                                           \
[UIColor colorWithRed : (CGFloat)random() / (CGFloat)RAND_MAX green : (CGFloat)random() / (CGFloat)RAND_MAX blue : (CGFloat)random() / (CGFloat)RAND_MAX alpha : 1.0]

//#ifdef NDEBUG
#ifdef NDEBUG              // NO DEBUG or RELEASE MODE   - Tiredof stopping for mispelt NSLOG DEbug mssages
#define          MYLOG  MyLog(...)
#define          MYLOg  MyLog(...)
#define          MYLog  MyLog(...)
#define          MYlog  MyLog(...)
#define          Mylog  MyLog(...)
#define          MyLOG  MyLog(...)
#define          MYloG  MyLog(...)

#define          MYLONGLOG
#else
#define             MYLOG  NSLog
#define             MYLOg  NSLog
#define             MYLog  NSLog
#define             MYlog  NSLog
#define             Mylog  NSLog
#define             MyLOG  NSLog
#define             MYloG  NSLog

#define             MYLONGLOG     NSLog(@"%_func %s, _line %d, _file %s, calling _func %s", __func__, __Line__, __File__, __PRETTY_FUNCTION__);
#endif


#define     CARDWIDTH           33.0
#define     CARDLENGTH          60.0

#define     GAPBETWEENCARDS     8
#define     GAPBETWEENACECARDS  5

#define     MAXCARDROWS         8
#define     MAXCARDCOLUMNS      7

#define     CARDOVERLAYGAP     CARDLENGTH/2

#define     CARDSTARTPOS        40
#define     CARDSTARTROW        GAPBETWEENCARDS

#define     ACECARDSTARTPOS     xx

#define     DECKCARD_XPOS       14
#define     DECKCARD_YPOS    ( (MAXCARDROWS-2) * CARDLENGTH )



#define     HEARTS      0
#define     SPADES      1
#define     CLUBS       2
#define     DIAMONDS    3

#define     CARDREVERSE     @"card reverse 2.jpeg"






#endif
