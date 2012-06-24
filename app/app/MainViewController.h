//
//  MainViewController.h
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSLocationManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController <PSLocationManagerDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet UILabel *strengthLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (retain, nonatomic) IBOutlet MKMapView *mMapView;
//@property (nonatomic, retain) IBOutlet UIBarButtonItem *stopButton;

@end