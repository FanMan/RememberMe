//
//  UIViewController+TalkToMe.m
//  RememberMe
//
//  Created by Rafael Dalcolmo on 4/14/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import "TalkToMeViewController.h"
#import <Slt/Slt.h>
#import <OpenEars/OEFliteController.h>

@interface TalkToMeViewController ()
@property (strong, nonatomic) OEFliteController *fliteController; //...
@property (strong, nonatomic) Slt *slt; //...
@property NSMutableArray *objects;
@end

@implementation TalkToMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fliteController = [[OEFliteController alloc] init]; //...
    self.slt = [[Slt alloc] init]; //...
}


@end

