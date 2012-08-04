//
//  DetailViewController.h
//  app
//
//  Created by Rickard Hansson on 2012-08-04.
//  Copyright (c) 2012 cybercom. All rights reserved.
//
#import <MessageUI/MFMailComposeViewController.h>
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property NSInteger number;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UITextView *commentText;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (strong, nonatomic) IBOutlet UILabel *distLabel;

- (IBAction)segmentClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendKnapp;
- (IBAction)sendMail:(id)sender;

@end
