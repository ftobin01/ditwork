//
//  tweet.m
//  twits2
//
//  Created by media temp on 04/11/2014.
//  Copyright (c) 2014 media temp. All rights reserved.
//

#import "tweet.h"

@implementation Tweet


{

*tweet[50] = [[Tweet alloc] init];
    
    
    
}


- BOOL makeTest Tweets()
//Test instance 1
picture
@"paradise_garage_bot"
@"@garage..."
@"22m"
@"Electric Mind - ZWEI"
@"bit.ly/bMool"
0,0,0

//Test Instance 2
picture
@"Bodytonic
@"@bodytonic"
@24m
@RT @LovinDublin: NOt at the £websummit? Check out the livestream!
@lovindublin.com/dublin/not-at--...
0,0,0

// Test INstance 3
picture
Gary BernHardt
@garybernhardt
27m
pretty mad about the power structures in the industry lately,
you may have noticed
0,3,4


- BOOL getTweets( param1  ){
    
    // function to retrive next 50 tweets

// use AFNetwork - to access next 50 tweet
    
    
}

@end

// use this to get key
http://twitter.com/auth

// use this to get tweets - which username to use ?
http://twitter.com/<username>/tweets


// Code to get tweet from JAson into object

oid (^completionBlock)(AFHTTPRequestOperation *operation, id responseObject){
    NSDictionary *jsonDictionary = (NSDictionary*)responseObject;
    Tweet *tweet     = [][Tweet alloc] init];
    tweet.name       = jsonDictionary[@"name"];
    tweet.username   = jsonDictionary[@"username"];
    tweet.text       = jsonDictionary[@"tweet"];
    tweet.avatarURL  = jsonDictionary[@"avatar"];
    tweet.time       = jsonDictionary[@"time"];
    
    [_tweets addObject:tweet];
}


//
Once we have these tweets, our UITableView can reloadData and display a cell for each tweet in tableView:cellForRowAtIndexPath:.