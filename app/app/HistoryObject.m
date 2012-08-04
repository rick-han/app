//
//  HistoryObject.m
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import "HistoryObject.h"

@implementation HistoryObject

@synthesize fromString;
@synthesize toString;
@synthesize distance;
@synthesize type;
@synthesize finalString;
@synthesize comment;

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.fromString         forKey:@"from"];
    [aCoder encodeObject:self.toString         forKey:@"to"];
    [aCoder encodeObject:self.distance         forKey:@"distance"];
    [aCoder encodeObject:self.type         forKey:@"type"];
    [aCoder encodeObject:self.finalString   forKey:@"final"];
    [aCoder encodeObject:self.comment   forKey:@"comment"];

    
   }

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        self.fromString = [aDecoder decodeObjectForKey:@"from"];
        self.toString = [aDecoder decodeObjectForKey:@"to"];
        self.distance    = [aDecoder decodeObjectForKey:@"distance"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.finalString = [aDecoder decodeObjectForKey:@"final"];
        self.comment = [aDecoder decodeObjectForKey:@"comment"];
               
            }
    return self;
}

@end
