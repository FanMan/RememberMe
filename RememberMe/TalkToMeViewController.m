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
#import <OpenEars/OEPocketsphinxController.h>
#import <OpenEars/OEAcousticModel.h>
#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OEAcousticModel.h>
#import <OpenEars/OEEventsObserver.h>

@interface ViewController : UIViewController <OEEventsObserverDelegate>
@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;
@end

@implementation TalkToMeViewController

- (IBAction)onMicrophonePress:(id)sender {
    // Do any additional setup after loading the view, typically from a nib.
    OELanguageModelGenerator *lmGenerator = [[OELanguageModelGenerator alloc] init];
    
    NSArray *words = [NSArray arrayWithObjects: @"What chores did you have to do when you were growing up?", @"When you were a teenager, what did you and your friends do for fun?", @"What are some of the most valuable things you learned from your parents?", @"What did your grandparents and great grandparents do for a living?", @"When you were growing up, what did you dream you would do with your life?" @"What accomplishments in your life are you most proud of?" @"How would you like to be remembered?", nil];
    NSString *name = @"NameIWantForMyLanguageModelFiles";
    NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"]];
    
    NSString *lmPath = nil;
    NSString *dicPath = nil;
    
    if(err == nil) {
        
        lmPath = [lmGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:@"NameIWantForMyLanguageModelFiles"];
        dicPath = [lmGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:@"NameIWantForMyLanguageModelFiles"];
        
    } else {
        NSLog(@"Error: %@",[err localizedDescription]);
    }
    //method where you want to recognize speech
    
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    [self.openEarsEventsObserver setDelegate:self];
    
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:lmPath dictionaryAtPath:dicPath acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to perform Spanish recognition instead of English
    
    //    self.fliteController = [[OEFliteController alloc] init]; //...
    //    self.slt = [[Slt alloc] init]; //...
    //    [self.fliteController say:@ "Hello, talk to me." withVoice:self.slt];
    //    [self.fliteController say:@ "A short statement" withVoice:self.slt];

}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    OELanguageModelGenerator *lmGenerator = [[OELanguageModelGenerator alloc] init];
    
    NSArray *words = [NSArray arrayWithObjects: @"What chores did you have to do when you were growing up?", @"When you were a teenager, what did you and your friends do for fun?", @"What are some of the most valuable things you learned from your parents?", @"What did your grandparents and great grandparents do for a living?", @"When you were growing up, what did you dream you would do with your life?" @"What accomplishments in your life are you most proud of?" @"How would you like to be remembered?", nil];
    NSString *name = @"NameIWantForMyLanguageModelFiles";
    NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"]];
    
    NSString *lmPath = nil;
    NSString *dicPath = nil;
    
    if(err == nil) {
        
        lmPath = [lmGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:@"NameIWantForMyLanguageModelFiles"];
        dicPath = [lmGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:@"NameIWantForMyLanguageModelFiles"];
        
    } else {
        NSLog(@"Error: %@",[err localizedDescription]);
    }
    //method where you want to recognize speech
    
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    [self.openEarsEventsObserver setDelegate:self];
    
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:lmPath dictionaryAtPath:dicPath acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to perform Spanish recognition instead of English
    
    //    self.fliteController = [[OEFliteController alloc] init]; //...
    //    self.slt = [[Slt alloc] init]; //...
    //    [self.fliteController say:@ "Hello, talk to me." withVoice:self.slt];
    //    [self.fliteController say:@ "A short statement" withVoice:self.slt];

}


- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
    
    NSString *parsedInputString = [hypothesis stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
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
             
             NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSString *finalResponse = [resultDictionary objectForKey:@"responses"];
             
             [self.fliteController say:finalResponse withVoice:self.slt];
             
             NSLog(@"reply: %@", finalResponse);
         }
         else
         {
             NSLog(@"Sorry, I did not understand that.");
         }
     }];

}

- (void) pocketsphinxDidStartListening {
    NSLog(@"Pocketsphinx is now listening.");
}

- (void) pocketsphinxDidDetectSpeech {
    NSLog(@"Pocketsphinx has detected speech.");
}

- (void) pocketsphinxDidDetectFinishedSpeech {
    NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
}

- (void) pocketsphinxDidStopListening {
    NSLog(@"Pocketsphinx has stopped listening.");
}

- (void) pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx has suspended recognition.");
}

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx has resumed recognition.");
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
    NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening setup wasn't successful and returned the failure reason: %@", reasonForFailure);
}

- (void) pocketSphinxContinuousTeardownDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening teardown wasn't successful and returned the failure reason: %@", reasonForFailure);
}

- (void) testRecognitionCompleted {
    NSLog(@"A test file that was submitted for recognition is now complete.");
}


@end


