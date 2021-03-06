//
//  AppAppDelegate.m
//  app
//
//  Created by kj on 2012-06-17.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppAppDelegate.h"
#import "MainViewController.h"
#import "HistoryObject.h"

@implementation AppAppDelegate

@synthesize mModel;
@synthesize window;
@synthesize viewController;
@synthesize mTabBarController;
@synthesize historyViewController;
@synthesize mainNavController;
@synthesize historyNavController;
@synthesize initsNavController;
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
    initsNavController = [[UINavigationController alloc] initWithRootViewController:initViewController];
    mainNavController = [[UINavigationController alloc] initWithRootViewController:viewController];
    historyNavController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    self.mTabBarController.viewControllers = [NSArray arrayWithObjects:initsNavController, historyNavController, nil];    
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
    //store the array
    NSString *localPath = @"Documents/app.archive";
    NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:localPath];
    NSArray *array = [[NSArray alloc] initWithArray:mModel.mHistoryArray];
    [NSKeyedArchiver archiveRootObject:array toFile:fullPath];
     NSLog(@"%@",array);
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //load the array
    NSString *localPath = @"Documents/app.archive";
    NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:localPath];

    NSArray* myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
    if(myArray != nil)
        mModel.mHistoryArray = [myArray mutableCopy];
    NSLog(@"%@",myArray);

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
    [archiver encodeObject: mModel.mHistoryArray  forKey:@"Historik"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: [self dataFilePath]];

   }


- (void)applicationWillTerminate:(UIApplication *)application
{
     /* for(int k=0; k<[mModel.mHistoryArray count];k++){
            
        HistoryObject *obj = [mModel.mHistoryArray objectAtIndex:k];
        NSString *str = obj.finalString;
        str = [str stringByAppendingString:[@"%" stringByAppendingString:obj.distance]];     
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"history"];

    }*/
       
    
/*
    jsonstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"forcast_data"];
    if(jsonstr != nil) {
        NSData* data=[jsonstr dataUsingEncoding:NSUTF8StringEncoding];
        arr = [[MSBParser parseForecast:data] retain];   
    }
*/

    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

