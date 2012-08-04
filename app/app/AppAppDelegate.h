//
//  AppAppDelegate.h
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
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
@property (strong, nonatomic) UINavigationController *initsNavController;

@end

