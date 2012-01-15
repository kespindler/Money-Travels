//
//  AppDelegate.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonObject;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *people;
@property (nonatomic, retain) NSMutableArray *history;

#pragma mark - PersonObject data interaction methods
//TODO: should be moved into separate class
- (PersonObject *)personForPersonId:(NSInteger)personId;
- (PersonObject *)newPersonWithName:(NSString *)name;

- (void)saveData;

@end
