//
//  TypeToMeViewController.m
//  RememberMe
//
//  Created by Media Services on 4/16/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import "TypeToMeViewController.h"

@interface TypeToMeViewController ()

@end


@implementation TypeToMeViewController
@synthesize typeToMeBox;
@synthesize typeToMeResponse;

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fliteController = [[OEFliteController alloc] init]; //...
    self.slt = [[Slt alloc] init]; //...
    [self.fliteController say:@ "Hello, type to me." withVoice:self.slt];
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    [self.openEarsEventsObserver setDelegate:self];
    
}
- (IBAction)typeToMeReturn:(id)sender
{
    NSString *message = typeToMeBox.text;
    
    NSString *parsedInputString = [message stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *url = [NSString stringWithFormat:@"https://aiaas.pandorabots.com/talk/1409611776855/rememberme?input=" @"%@" @"&user_key=b9332f7819d3df78debaafce36fafeee", parsedInputString];
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
             //NSLog(@"success");
             
             NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSArray* arr = [resultDictionary objectForKey:@"responses"];
             NSString *reply = [arr objectAtIndex:0];
             NSLog(@"reply: %@", reply);
             
             [self.fliteController say:reply withVoice:self.slt];
             
             typeToMeResponse.text = reply;
             
             //NSLog(@"reply: %@", finalResponse);
             //[delegate receivedData:data];
         } /*else if ([data length] == 0 && error == nil)
            NSLog(@"empty");
            //[delegate emptyReply];
            else if (error != nil && error.code == NSURLErrorTimedOut)
            NSLog(@"timeout");
            //[delegate timedOut];
            else if (error != nil)
            NSLog(@"error");
            //[delegate downloadError:error];*/
            else
            {
            //typeToMeResponse.text = @"Sorry, I did not understand that.";
            NSLog(@"Sorry, I did not understand that.");
            }
    }];
}

- (void)didReceiveMemoryWarning {
    
    // Releases the view if it doesn't have a superview.
    
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
}

- (void)viewDidUnload {
    
    // Release any retained subviews of the main view.
    
    // e.g. self.myOutlet = nil;
    
}

@end