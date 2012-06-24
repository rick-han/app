//
//  AppModel.h
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AppModel : NSObject

@property (nonatomic, retain) NSMutableArray *mHistoryArray;

@property CLLocation *startCoordinate;
@property CLLocation *stopCoordinate;
@property (strong ,nonatomic) NSString *fromString;
@property (strong, nonatomic) NSString *toString;

@end
