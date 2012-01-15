//
//  SettingsViewController2.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/15/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPersonViewController.h"

enum {
    SettingsSectionPeople,
    SettingsSectionReset,
    SettingsSectionNumSections,
};

enum {
    AlertViewTagDeletePerson,
    AlertViewTagReset,
};

@class PersonObject;

@interface SettingsViewController2 : UITableViewController<NewPersonViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) PersonObject *personToDelete;
@property (nonatomic, assign) NSMutableArray *people;
@property (nonatomic, assign) NSMutableArray *history;

- (IBAction)resetButtonPressed:(id)sender;

@end
