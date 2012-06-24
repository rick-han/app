//
//  ModelChangedListener.h
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModelChangedListener <NSObject>

@required

//TODO: Add parameters (e.g. requestType?)
- (void) onModelChanged: (NSInteger) type;

@end

