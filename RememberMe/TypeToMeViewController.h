//
//  TypeToMeViewController.h
//  RememberMe
//
//  Created by Media Services on 4/16/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Slt/Slt.h>
#import <OpenEars/OEFliteController.h>
#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OEAcousticModel.h>
#import <OpenEars/OEEventsObserver.h>

@interface TypeToMeViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *typeToMeBox;
@property (weak, nonatomic) IBOutlet UILabel *typeToMeResponse;
@property (strong, nonatomic) OEFliteController *fliteController; //...
@property (strong, nonatomic) Slt *slt; //...
@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;
@property NSMutableArray *objects;

- (IBAction)typeToMeReturn:(id)sender;

@end
