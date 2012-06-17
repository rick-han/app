//
//  AppAppDelegate.h
//  app
//
//  Created by Rickard Hansson on 2012-06-16.
//  Copyright (c) 2012 cybercom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;

@end

