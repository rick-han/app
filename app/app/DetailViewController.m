//
//  DetailViewController.m
//  app
//
//  Created by Rickard Hansson on 2012-08-04.
//  Copyright (c) 2012 cybercom. All rights reserved.
//

#import "DetailViewController.h"
#import "AppAppDelegate.h"
#import "HistoryObject.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize sendKnapp;
AppAppDelegate *app;
@synthesize number;
@synthesize fromLabel;
@synthesize toLabel;
@synthesize commentText;
@synthesize segControl;
@synthesize distLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
    HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:number];
    
    self.fromLabel.text = obj.fromString;
    self.toLabel.text = obj.toString;
    self.distLabel.text = obj.distance;
    if(obj.comment != nil)
        self.commentText.text = obj.comment;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:number];
    obj.comment = commentText.text;
    [self setFromLabel:nil];
    [self setToLabel:nil];
    [self setCommentText:nil];
    [self setSegControl:nil];
    [self setDistLabel:nil];
    [self setSendKnapp:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)segmentClick:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger index = [segmentedControl selectedSegmentIndex];
    
    HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:number];
    if(index == 0){
        obj.type = @"Privat";
    } else {
        obj.type = @"Firma";
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)shareEmail{
     HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:number];
    NSString *msg_title = [[NSString alloc] init];
    msg_title = [msg_title stringByAppendingString:obj.type];
    msg_title = [msg_title stringByAppendingString:@": "];
    msg_title = [msg_title stringByAppendingString:obj.finalString];
    msg_title = [msg_title stringByAppendingString:@" distans: "];
    msg_title = [msg_title stringByAppendingString:obj.distance];
    
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"EN KÖRNING"];
    [controller setMessageBody:msg_title isHTML:NO]; 
    NSLog(@"%@", @"dsa");
    [self presentModalViewController:controller animated:YES];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    if (result == MFMailComposeResultSent) {

    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:number];
    obj.comment = commentText.text;
}
- (IBAction)sendMail:(id)sender {
    [self shareEmail];
}
@end
