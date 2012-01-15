//
//  AppDelegate.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "AppDelegate.h"
#import "HistoryViewController.h"
#import "TotalsViewController.h"
#import "HelpViewController.h"
#import "EnterDataViewController2.h"
#import "SettingsViewController2.h"

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

- (NSString *)storageFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"Storage.plist"];
    return filename;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSArray *values = [[NSArray alloc] initWithObjects:self.people, self.history, nil];
	[values writeToFile:[self storageFilePath] atomically:YES];
	[values release];
}

- (void)createUserDataObjects {
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[self storageFilePath]];
	if (fileExists) {
		NSArray *values = [[[NSArray alloc] initWithContentsOfFile:[self storageFilePath]] autorelease];
		self.people = [values objectAtIndex:0];
		self.history = [values objectAtIndex:1];
	} else {
        self.people = [[[NSMutableArray alloc] initWithCapacity:3] autorelease];
        self.history = [[[NSMutableArray alloc] initWithCapacity:25] autorelease];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self createUserDataObjects];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    
    UINavigationController *nc = nil;
    
    EnterDataViewController2 *edvc = [[[EnterDataViewController2 alloc] init] autorelease];
    edvc.people = self.people;
    edvc.history = self.history;
    nc = [[[UINavigationController alloc] initWithRootViewController:edvc] autorelease];
    [viewControllers addObject:nc];
    
    HistoryViewController *hvc = [[[HistoryViewController alloc] init] autorelease];
    hvc.history = self.history;
    nc = [[[UINavigationController alloc] initWithRootViewController:hvc] autorelease];
    [viewControllers addObject:nc];
    
    TotalsViewController *tvc = [[[TotalsViewController alloc] init] autorelease];
    nc = [[[UINavigationController alloc] initWithRootViewController:tvc] autorelease];
    [viewControllers addObject:nc];
    
    SettingsViewController2 *svc = [[[SettingsViewController2 alloc] init] autorelease];
    svc.people = self.people;
    svc.history = self.history;
    nc = [[[UINavigationController alloc] initWithRootViewController:svc] autorelease];
    [viewControllers addObject:nc];
    
    HelpViewController *helpvc = [[[HelpViewController alloc] init] autorelease];
    nc = [[[UINavigationController alloc] initWithRootViewController:helpvc] autorelease];
    [viewControllers addObject:nc];
    
;
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
