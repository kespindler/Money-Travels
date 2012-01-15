//
//  NewPersonViewController.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPersonViewControllerDelegate <NSObject>

- (void)personWasAdded;

@end

@interface NewPersonViewController : UITableViewController<UITextFieldDelegate>

@property (nonatomic, assign) NSMutableArray *people;
@property (nonatomic, assign) id<NewPersonViewControllerDelegate> addPersonViewControllerDelegate;
@property (retain, nonatomic) UITextField *addPersonNameTextField;

@end
