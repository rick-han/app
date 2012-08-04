//
//  HistoryObject.h
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryObject : NSObject <NSCoding>

@property (nonatomic, strong) NSString *fromString;
@property (nonatomic, strong) NSString *toString;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *finalString;
@property (nonatomic, strong) NSString *comment;

@end
