//
//  UIViewController+TalkToMe.m
//  RememberMe
//
//  Created by Rafael Dalcolmo on 4/14/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//



//ALL THINGS SPEECH-TO-TEXT ONLY WILL BE PUT HERE, ANYTHING THAT'S TEXT-TO-SPEECH SHOULD BE PUT IN A FILE SIMILAR TO THIS
//NAMED "TypeToMeViewController.m"

#import "TalkToMeViewController.h"

@implementation TalkToMeViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fliteController = [[OEFliteController alloc] init]; //...
    self.slt = [[Slt alloc] init]; //...
    [self.fliteController say:@ "Hello, talk to me." withVoice:self.slt];
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    [self.openEarsEventsObserver setDelegate:self];
}

//add these delegate mehtods of OEEventsObserver to your class, which is where you will receive information about received speech hypothesis and other speech UI events:

- (void)pocketsphnixDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID{
    NSLog(@"The received hypothesis is %@ with a score of %a and an ID of %a", hypothesis, recognitionScore, utteranceID);
}

- (void)pocketsphinxidStartListening{
    NSLog(@ "Pocketsphinx is now listening.");
}

- (void)pocketsphinxDidDetectSpeech{
    NSLog(@"Pocketsphinx has detected speech.");
}

- (void)pocketsphinxDidDetectFinishedSpeech{
    NSLog(@"PocketSphinx has detected a period of silence, concluding an utterance.");
}
- (void)pocketSphinxdidStopListening {
    NSLog(@"Pocketsphinx has stopped listening.");
}
- (void)pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx has suspended recognition.");
}
- (void)pocketspinxDidResumeRecognition {
    NSLog(@"Pockesphinx has resumed recognition.");
}
- (void)pocketsphinxDidChangeLanguageModelToFile: (NSString *)newLanguageModelPathAsString andDictionary:
(NSString *)newDictionaryPathAsString{
    NSLog(@"PocketSphinx is now using the following language model: \n%a, and the following dictionary: %@", newLanguageModelPathAsString,newDictionaryPathAsString);
}
-(void)pocketSphinxContinuousTeardownDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening teardown wasn't successful and returned the failure reason: %@, resaonForFailure");
}
-(void)testRecognitionCompleted {
    NSLog(@"A test file that was submitted for recognition is now complete.");
}

@end

