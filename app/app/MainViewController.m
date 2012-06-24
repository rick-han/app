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
        
        
        UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
        self.navigationItem.RightBarButtonItem = btnBack;
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

-(void)viewWillAppear:(BOOL)animated{
    [[PSLocationManager sharedLocationManager] prepLocationUpdates];
    [[PSLocationManager sharedLocationManager] startLocationUpdates];
    self.distanceLabel.text = @"";
}

-(void)viewWillDisappear:(BOOL)animated{
    [[PSLocationManager sharedLocationManager] stopLocationUpdates];
    self.distanceLabel.text = @"";

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
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:app.mModel.stopCoordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            // Pick the best out of the possible placemarks
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *addressString = [placemark name];
            app.mModel.toString = addressString;
        }
    }];
    
    obj.distance = self.distanceLabel.text;
    obj.fromString= app.mModel.fromString;
    obj.toString = app.mModel.toString;
    
    [app.mModel.mHistoryArray addObject:obj]; 
    
    UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Avbryt?" message:@"Vill du stoppa?" delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:@"OK", nil];
    [alrt show];
    
     app.mTabBarController.viewControllers = [NSArray arrayWithObjects:app.initsNavController, app.historyNavController, nil]; 
    
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
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f %@", distance/1000, NSLocalizedString(@"KM", @"")];
}

- (void)locationManager:(PSLocationManager *)locationManager error:(NSError *)error {
    // location services is probably not enabled for the app
    self.strengthLabel.text = NSLocalizedString(@"Unable to determine location", @"");
}

- (void)dealloc {
    
   
}
 
@end