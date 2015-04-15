//
//  Bot.m
//  RememberMe
//
//  Created by Angela Gigliotti on 4/15/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *message = @"Hello";

NSString *url = [NSString stringWithFormat:@"https://aiaas.pandorabots.com/talk/1409611776855/remembertest?input=%@&user_key=b9332f7819d3df78debaafce36fafeee", message];
// Override point for customization after application launch.
// Create the request.

NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
[postRequest setHTTPMethod:@"POST"];
// Create the NSMutableData to hold the received data.

// receivedData is an instance variable declared elsewhere.
NSOperationQueue *queue = [[NSOperationQueue alloc] init];

[ [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
 {
     if ([data length] > 0 && error == nil) {
         NSLog(@"success");
         NSString *reply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"reply: %@", reply);
         //[delegate receivedData:data];
     } else if ([data length] == 0 && error == nil)
         NSLog(@"empty");
     //[delegate emptyReply];
     else if (error != nil && error.code == NSURLErrorTimedOut)
         NSLog(@"timeout");
     //[delegate timedOut];
     else if (error != nil)
         NSLog(@"error");
     //[delegate downloadError:error];
 }]]