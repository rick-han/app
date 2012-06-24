//
//  AppAppDelegate.m
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppAppDelegate.h"
#import "MainViewController.h"

@implementation AppAppDelegate

@synthesize mModel;
@synthesize window;
@synthesize viewController;
@synthesize mTabBarController;
@synthesize historyViewController;
@synthesize mainNavController;
@synthesize historyNavController;
@synthesize initNavController;
@synthesize initViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.mModel = [[AppModel alloc] init];
    self.mTabBarController = [[UITabBarController alloc] init];
    
   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        self.historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
        self.initViewController = [[InitViewController alloc] initWithNibName:@"InitViewController" bundle:nil];
    } 
    initNavController = [[UINavigationController alloc] initWithRootViewController:initViewController];
    mainNavController = [[UINavigationController alloc] initWithRootViewController:viewController];
    historyNavController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    self.mTabBarController.viewControllers = [NSArray arrayWithObjects:initNavController, historyNavController, nil];    
    self.mTabBarController.delegate=self;
    
    self.window.rootViewController = self.mTabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

