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

UIBarButtonItem *btnBack;
AppAppDelegate *app;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];
        
        
        app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
        
        //Ändra barbutton till en egen knapp.
        btnBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(add)];
        [btnBack setEnabled:false];
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
    
    /* if (self.distanceLabel.text == @"Laddar distans")
    {
        //self.navigationItem.rightBarButtonItem.enabled = NO;
    } */
    
    /*
    do {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } while (self.distanceLabel.text == @"Laddar distans");

     if(self.distanceLabel.text != @"Laddar distans"){
     self.navigationItem.rightBarButtonItem.enabled = YES;
     }
    */
    //self.distanceLabel.text = @"Laddar distans";
   

    //self.navigationItem.rightBarButtonItem.enabled = NO;
    [PSLocationManager sharedLocationManager].delegate = self;
    [[PSLocationManager sharedLocationManager] prepLocationUpdates];
    [[PSLocationManager sharedLocationManager] startLocationUpdates];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[PSLocationManager sharedLocationManager] prepLocationUpdates];
    [[PSLocationManager sharedLocationManager] startLocationUpdates];
   // self.distanceLabel.text = @"Laddar distans";
    
    //self.distanceLabel.text = [NSString stringWithFormat:@"%.2f %@", [CLLocationDistance distance]/1000, NSLocalizedString(@"km", @"")];
  
}

-(void)viewWillDisappear:(BOOL)animated{
    //[[PSLocationManager sharedLocationManager] stopLocationUpdates];
    //self.distanceLabel.text = @"...";

}

- (void)viewDidUnload
{
    [self setMMapView:nil];
    [super viewDidUnload];
    
   
    // Release any retained subviews of the main view.
}



-(void) add{
    AppAppDelegate *app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:app.mModel.stopCoordinate completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            // Pick the best out of the possible placemarks
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *addressString = [placemark name];
            app.mModel.toString = addressString;
        }
    }];
    
   
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Vill du stoppa?" delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:@"OK", nil];
        [alert show];
    
   }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        
            app.mTabBarController.viewControllers = [NSArray arrayWithObjects:app.initsNavController, app.historyNavController, nil]; 
            AppAppDelegate *app = (AppAppDelegate*) [[UIApplication sharedApplication] delegate];
            HistoryObject *obj = [[HistoryObject alloc] init];
        
            obj.distance = self.distanceLabel.text;
            obj.fromString= app.mModel.fromString;
            obj.toString = app.mModel.toString;
            obj.type = @"Firma";
            obj.finalString = [obj.fromString stringByAppendingString:[@" till " stringByAppendingString:obj.toString]];
        
            [app.mModel.mHistoryArray addObject:obj]; 
            app.mModel.startCoordinate = nil;
            [[PSLocationManager sharedLocationManager] stopLocationUpdates];
            [[PSLocationManager sharedLocationManager] resetLocationUpdates];
        
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
    [btnBack setEnabled:TRUE];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f %@", distance/1000, NSLocalizedString(@"km", @"")];
}

- (void)locationManager:(PSLocationManager *)locationManager error:(NSError *)error {
    // location services is probably not enabled for the app
    self.strengthLabel.text = NSLocalizedString(@"Unable to determine location", @"");
}

- (void)dealloc {
    
   
}
 
@end