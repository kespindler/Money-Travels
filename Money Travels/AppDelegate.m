//
//  AppDelegate.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "AppDelegate.h"
#import "EnterDataViewController.h"
#import "SettingsViewController.h"
#import "HistoryViewController.h"
#import "TotalsViewController.h"
#import "HelpViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController;
@synthesize people;
@synthesize history;

- (void)dealloc
{
    [_window release];
    [tabBarController release];
    [people release];
    [history release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.people = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    
    UIViewController *viewController = nil;
    
    viewController = [[[EnterDataViewController alloc] init] autorelease];
    [viewControllers addObject:viewController];
    
    viewController = [[[HistoryViewController alloc] init] autorelease];
    [viewControllers addObject:viewController];
    
    viewController = [[[TotalsViewController alloc] init] autorelease];
    [viewControllers addObject:viewController];
    
    SettingsViewController *settingsViewController = [[[SettingsViewController alloc] init] autorelease];
    settingsViewController.people = self.people;
    
    [viewControllers addObject:settingsViewController];
    
    viewController = [[[HelpViewController alloc] init] autorelease];
    [viewControllers addObject:viewController];
    
    [self.tabBarController setViewControllers:viewControllers];
    [self.tabBarController setSelectedIndex:4];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
