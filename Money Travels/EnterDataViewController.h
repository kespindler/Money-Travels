//
//  EnterDataViewController.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    BoughtOrPaidValueBought = 0,
    BoughtOrPaidValuePaid = 1,
    };

@interface EnterDataViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign) NSArray *people;
@property (nonatomic, assign) NSMutableArray *history;

@property (retain, nonatomic) IBOutlet UITableView *peopleTableView;
@property (retain, nonatomic) IBOutlet UITextField *amountTextField;
@property (retain, nonatomic) IBOutlet UISegmentedControl *boughtOrPaidSegmentedControl;

- (IBAction)submitButtonPressed:(id)sender;

@end
