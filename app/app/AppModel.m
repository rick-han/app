//
//  AppModel.m
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

@synthesize mHistoryArray;
@synthesize startCoordinate;
@synthesize stopCoordinate;

- (id) init {
    
    self = [super init];
    
    if(self) {
        mHistoryArray = [[NSMutableArray alloc] init];
    }
 
    return self;
}


@end
