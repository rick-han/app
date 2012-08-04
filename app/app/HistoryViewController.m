//
//  HistoryViewController.m
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import "HistoryViewController.h"
#import "AppAppDelegate.h"
#import "AppModel.h"
#import "HistoryObject.h"
#import "DetailViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
@synthesize mKnapp;

AppAppDelegate *app;

/*- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return  documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"app.plist"];
}

- (void)saveHistoryItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject: app.mModel.mHistoryArray  forKey:@"Historik"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}
*/
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
           
       

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
        //göra egen image och använda som tabBarItem
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Historik" image:[UIImage imageNamed:@"test1.png"] tag:0];
        self.tabBarItem = tabBarItem;
        UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(shareEmail)];
        [btnBack setEnabled:true];
        self.navigationItem.RightBarButtonItem = btnBack;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  //  NSLog(@"Documents folder is %@", [self documentsDirectory]);
  //  NSLog(@"Data file path is %@", [self dataFilePath]); 
    
    self.navigationItem.title = @"Historik";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setMKnapp:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [app.mModel.mHistoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
	}

    
    HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:indexPath.row];    

    cell.textLabel.text = obj.finalString;
    cell.detailTextLabel.text = obj.distance;
    
    //[self saveHistoryItems];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [app.mModel.mHistoryArray removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tableView.reloadData;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger mSelectedItem = indexPath.row;
    DetailViewController *mDetail = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    mDetail.number = mSelectedItem;
    [self.navigationController pushViewController:mDetail animated:YES];
}

-(void)shareEmail{
    NSString *msg_title = [[NSString alloc] init];
    for(int k=0; k<[app.mModel.mHistoryArray count];k++){
        HistoryObject *obj = [app.mModel.mHistoryArray objectAtIndex:k];
        if(obj.type == nil)
            obj.type = @"0";
        msg_title = [msg_title stringByAppendingString:obj.type];
        msg_title = [msg_title stringByAppendingString:@": "];
        msg_title = [msg_title stringByAppendingString:obj.finalString];
        msg_title = [msg_title stringByAppendingString:@" distans: "];
        msg_title = [msg_title stringByAppendingString:obj.distance];
         msg_title = [msg_title stringByAppendingString:@"\n"];
        
    }
       
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"KÖRNINGAR"];
    [controller setMessageBody:msg_title isHTML:NO]; 
    NSLog(@"%@", @"dsa");
    [self presentModalViewController:controller animated:YES];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    if (result == MFMailComposeResultSent) {
        
    }
    [self dismissModalViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


- (IBAction)sendAll:(id)sender {
    [self shareEmail];
}
@end
