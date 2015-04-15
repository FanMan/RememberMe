//
//  DetailViewController.h
//  RememberMe
//
//  Created by Rafael Dalcolmo on 4/14/15.
//  Copyright (c) 2015 dotCOM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

