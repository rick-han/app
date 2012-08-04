//
//  HistoryViewController.h
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//
#import <MessageUI/MFMailComposeViewController.h>
#import <UIKit/UIKit.h>

@interface HistoryViewController : UITableViewController <NSCoding, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *mKnapp;

- (IBAction)sendAll:(id)sender;

@end
