//
//  MainViewController.h
//  app
//
//  Created by Rickard Hansson on 2012-06-17.
//  Copyright (c) 2012 cybercom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSLocationManager.h"
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController <PSLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet UILabel *strengthLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (retain, nonatomic) IBOutlet MKMapView *mMapView;

@end