//
//  ModelChangedListener.h
//  app
//
//  Created by Rickard Hansson on 2012-06-17.
//  Copyright (c) 2012 cybercom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModelChangedListener <NSObject>

@required

//TODO: Add parameters (e.g. requestType?)
- (void) onModelChanged: (NSInteger) type;

@end

