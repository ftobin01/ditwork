//
//  Constants.h
//  ArcTest1
//
//  Created by F T on 04/05/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#ifndef ArcTest1_Constants_h
#define ArcTest1_Constants_h




typedef enum {
    kLineShape =0,
    kRectShape,
    KEllipseShape,
    kImageShape
}ShapeType;

typedef enum {
    kRedColorTab=0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
}ColorTabIndex;




#define degreeToRadians(x) (M_PI * (x) / 180.0) 

#endif
