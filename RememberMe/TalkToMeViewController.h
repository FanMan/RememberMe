//
//  UIViewController+TalkToMe.h
//  RememberMe
//
//  Created by Rafael Dalcolmo on 4/14/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Slt/Slt.h>
#import <OpenEars/OEFliteController.h>
#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OEAcousticModel.h>
#import <OpenEars/OEEventsObserver.h>

@interface TalkToMeViewController : UIViewController
- (IBAction)onMicrophonePress:(id)sender;
@property (strong, nonatomic) OEFliteController *fliteController; //...
@property (strong, nonatomic) Slt *slt; //...
@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;
@property NSMutableArray *objects;

@end



