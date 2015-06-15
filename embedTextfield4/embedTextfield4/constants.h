//
//  constants.h
//  simpleView1
//
//  Created by F T on 13/06/2015.
//  Copyright (c) 2015 FT. All rights reserved.
//

#ifndef simpleView1_constants_h
#define simpleView1_constants_h

#define OUT_MSG_COLOR   [UIColor blueColor];
#define IN_MSG_COLOR   [UIColor blueColor];



#define MSG_FONT_SIZE 45.0f
#define TIMESTAMP_FONT_SIZE  8.0f
#define MSG_TXT_COLOR blackColor // UIColor words
#define FONT_HELVETICA @"Helvetica-Light"
#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.4f]

#define TICK            @"\u2713"  // unicode correction mark
#define HEAVY_TICK      @"\u2714"  // Heavy Correction mark

#endif


// Dont Foreget to use to Speed up codelocation

// FIXME:

// ???:

// !!!:

// MARK:

// and
// #pragma mark
//
// To make code reading easier



/*
Head over to your project's item in the Project Navigator (usually at the very top)
Find your target in the list of targets on the left, select it
Head over to the "Build Phases" tab.
Click the "Add Build Phase" in the bottom right of this screen.
In the editor that appears insert the bash script shown below.

 Bash Script:
 
KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"

Extra tip: Make sure you're using phrases to describe your //TODO: comments like //TODO: Handle this error gracefully, and things like that. The phrases will show up in the issues list beside each warning.
 
 Errors will Appear with Shell Script Invocation Warning and Phrases yu have included
 
 https://deallocatedobjects.com/posts/show-todos-and-fixmes-as-warnings-in-xcode-4 
 */
 
