//
//  AppAppDelegate.h
//  app
//
//  Created by Rickard Hansson on 2012-06-16.
//  Copyright (c) 2012 cybercom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "HistoryViewController.h"
#import "InitViewController.h"

@class MainViewController;

@interface AppAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppModel *mModel;
@property (strong, nonatomic) UITabBarController *mTabBarController;
@property (strong, nonatomic) MainViewController *viewController;
@property (strong, nonatomic) HistoryViewController *historyViewController;
@property (strong, nonatomic) InitViewController *initViewController;
@property (strong, nonatomic) UINavigationController *mainNavController;
@property (strong, nonatomic) UINavigationController *historyNavController;
@property (strong, nonatomic) UINavigationController *initNavController;


@end

