//
//  UIViewController+TalkToMe.m
//  RememberMe
//
//  Created by Rafael Dalcolmo on 4/14/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import "TalkToMeViewController.h"
#import <Slt/slt.h>
#import <OpenEars/OEFliteController.h>
#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OEAcousticModel.h>
#import <OpenEars/OEEventsObserver.h>

@interface TalkToMeViewController ()
@property (strong, nonatomic) OEFliteController *fliteController; //...
@property (strong, nonatomic) Slt *slt; //...
@property NSMutableArray *objects;
@interface ViewController : UIViewController <OEEventsObserverDelegate>
@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;

@end

@implementation TalkToMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fliteController = [[OEFliteController alloc] init]; //...
    self.slt = [[Slt alloc] init]; //...
    [self.fliteController say:@ "A short statement" withVoice:self.slt];
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    [self.openEarsEventsObserver setDelegate:self];
}


@end

