//
//  SettingsViewController.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPersonViewController.h"

@interface SettingsViewController : UITableViewController<NewPersonViewControllerDelegate>

@property (nonatomic, assign) NSMutableArray *people;

- (IBAction)resetButtonPressed:(id)sender;

@end
