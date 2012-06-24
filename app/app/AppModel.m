//
//  AppModel.m
//  app
//
//  Created by Rickard Hansson on 2012-06-17.
//  Copyright (c) 2012 cybercom. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

@synthesize mHistoryArray;
@synthesize startCoordinate;
@synthesize stopCoordinate;
@synthesize fromString;
@synthesize toString;

- (id) init {
    
    self = [super init];
    
    if(self) {
        mHistoryArray = [[NSMutableArray alloc] init];
    }
 
    return self;
}


@end
