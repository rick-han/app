//
//  MainViewController.m
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import "MainViewController.h"
#import "AppAppDelegate.h"
#import "HistoryObject.h"
#import "PSLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize strengthLabel = _strengthLabel;
@synthesize distanceLabel = _distanceLabel;
@synthesize mMapView;
//@synthesize stopButton;

AppAppDelegate *app;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
        //self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Karta" image:nil tag:0];
        
        app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mMapView.showsUserLocation = TRUE;
    mMapView.userTrackingMode = TRUE;
    mMapView.userInteractionEnabled = FALSE;
    
       
    self.navigationItem.title = @"Karta";
    
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:nil action:@selector(stopButton:)];          
    [self.navigationItem setRightBarButtonItem: stopButton animated:YES];
    
    [PSLocationManager sharedLocationManager].delegate = self;
    [[PSLocationManager sharedLocationManager] prepLocationUpdates];
    [[PSLocationManager sharedLocationManager] startLocationUpdates];
}

- (void)viewDidUnload
{
    [self setMMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(IBAction)stopButton:(id)sender
{
 
    
            
       

}

-(void) add{
   AppAppDelegate *app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
    HistoryObject *obj = [[HistoryObject alloc] init];
    
    obj.distance = @"234";
    obj.fromString= @"spånga";
    obj.toString = @"sdada";
    [app.mModel.mHistoryArray addObject:obj]; 
    
    for(int k=0;k<[app.mModel.mHistoryArray count];k++){
        HistoryObject *s = [app.mModel.mHistoryArray objectAtIndex:k];
           }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark PSLocationManagerDelegate

- (void)locationManager:(PSLocationManager *)locationManager signalStrengthChanged:(PSLocationManagerGPSSignalStrength)signalStrength {
    NSString *strengthText;
    if (signalStrength == PSLocationManagerGPSSignalStrengthWeak) {
        strengthText = NSLocalizedString(@"Weak", @"");
    } else if (signalStrength == PSLocationManagerGPSSignalStrengthStrong) {
        strengthText = NSLocalizedString(@"Strong", @"");
    } else {
        strengthText = NSLocalizedString(@"...", @"");
    }
    
    self.strengthLabel.text = strengthText;
}

- (void)locationManagerSignalConsistentlyWeak:(PSLocationManager *)locationManager {
    self.strengthLabel.text = NSLocalizedString(@"Consistently Weak", @"");
}

- (void)locationManager:(PSLocationManager *)locationManager distanceUpdated:(CLLocationDistance)distance {
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f %@", distance, NSLocalizedString(@"meters", @"")];
}

- (void)locationManager:(PSLocationManager *)locationManager error:(NSError *)error {
    // location services is probably not enabled for the app
    self.strengthLabel.text = NSLocalizedString(@"Unable to determine location", @"");
}

- (void)dealloc {
    
   
}
 
@end