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
@synthesize fromString;
@synthesize toString;

- (id) init 
{
    self = [super init];
    
    if(self) {
        mHistoryArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSString *)documentsDirectory
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
    [archiver encodeObject: mHistoryArray  forKey:@"Historik"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}



@end
