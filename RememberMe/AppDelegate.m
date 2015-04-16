//
//  AppDelegate.m
//  RememberMe
//
//  Created by Rafael Dalcolmo on 4/14/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *message = @"I feel alone";
    
    NSString *parsedInputString = [message stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *url = [NSString stringWithFormat:@"https://aiaas.pandorabots.com/talk/1409611776855/rememtest?input=" @"%@" @"&user_key=b9332f7819d3df78debaafce36fafeee", parsedInputString];
    // Override point for customization after application launch.
    // Create the request.
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [postRequest setHTTPMethod:@"POST"];
    // Create the NSMutableData to hold the received data.
    // receivedData is an instance variable declared elsewhere.
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
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
     }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


@end

