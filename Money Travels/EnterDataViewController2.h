//
//  EnterDataViewController2.h
//  Money Travels
//
//  Created by Kurt Spindler on 1/14/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    EnterDataSectionPeople,
    EnterDataSectionOtherFields,
    EnterDataSectionSubmit,
    EnterDataSectionNumSections, 
    };

enum {
    EnterDataOtherFieldsBoughtOrPaidSegmentedControl,
    EnterDataOtherFieldsAmountTextField,
    EnterDataOtherFieldsNumRows,
};

enum {
    BoughtOrPaidValueBought,
    BoughtOrPaidValuePaid,
};

@class PersonObject;

@interface EnterDataViewController2 : UITableViewController <UITextFieldDelegate>

@property (nonatomic, assign) NSArray *people;
@property (nonatomic, assign) NSMutableArray *history;
@property (nonatomic, assign) PersonObject *selectedPerson;

@property (nonatomic, retain) UITextField *amountTextField;
@property (nonatomic, retain) UISegmentedControl *boughtOrPaidSegmentedControl;
//@property (nonatomic, retain) UIButton *submitButton;
@property (nonatomic, retain) UIToolbar *keyboardToolbar;

@property (nonatomic, assign) UITextField *activeTextField;

//todo; should be private
- (NSString*)stringForSegment:(NSInteger)segment;

@end
