//
//  EnterDataViewController2.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/14/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//
//  TODO: write dealloc

#import "EnterDataViewController2.h"
#import "PersonObject.h"
#import "PaymentObject.h"

@implementation EnterDataViewController2

@synthesize people = _people;
@synthesize history = _history;
@synthesize amountTextField = _amountTextField;
@synthesize boughtOrPaidSegmentedControl = _boughtOrPaidSegmentedControl;
@synthesize keyboardToolbar = _keyboardToolbar;
@synthesize selectedPerson = _selectedPerson;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Add Payment", @"viewcontroller title");
        self.tabBarItem.image = [UIImage imageNamed:@"icn_tabbaradd.png"];
        // Custom initialization
    }
    return self;
}

- (id)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg_airplane.png"]] autorelease];
    backgroundView.contentMode = UIViewContentModeTop;
    self.tableView.backgroundView = backgroundView;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.boughtOrPaidSegmentedControl = nil;
    self.amountTextField = nil;
    self.keyboardToolbar = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    //addresses issue where selected person could be deleted when we're not on this screen
    if (![self.people containsObject:self.selectedPerson]) {
        self.selectedPerson = nil;
    }
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:EnterDataSectionPeople] withRowAnimation:UITableViewRowAnimationNone];
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return EnterDataSectionNumSections; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (section == EnterDataSectionPeople) rows = self.people.count ? self.people.count : 1;
    if (section == EnterDataSectionOtherFields) rows = EnterDataOtherFieldsNumRows;
    if (section == EnterDataSectionSubmit) rows = 1;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == EnterDataSectionPeople) {
        NSString *CellIdentifier = @"PeopleCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (self.people.count) {
            PersonObject *person = [self.people objectAtIndex:indexPath.row];
            cell.textLabel.text = person.name;
            if (person == self.selectedPerson) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        } else {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.text = NSLocalizedString(@"Add people in settings!", nil);
        }
    } else if (indexPath.section == EnterDataSectionOtherFields) {
        if (indexPath.row == EnterDataOtherFieldsBoughtOrPaidSegmentedControl) {
            NSString *CellIdentifier = @"SegmentControlCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            if (!self.boughtOrPaidSegmentedControl) {
                NSArray *segmentItems = [NSArray arrayWithObjects:
                                         [[self stringForSegment:0] capitalizedString],
                                         [[self stringForSegment:1] capitalizedString], nil];
                self.boughtOrPaidSegmentedControl = [[[UISegmentedControl alloc] initWithItems:segmentItems] autorelease];
                self.boughtOrPaidSegmentedControl.selectedSegmentIndex = BoughtOrPaidValueBought;
                self.boughtOrPaidSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
            }
            cell.accessoryView = self.boughtOrPaidSegmentedControl;
            cell.textLabel.text = NSLocalizedString(@"Action", nil);
        } else if (indexPath.row == EnterDataOtherFieldsAmountTextField) {
            NSString *CellIdentifier = @"AmountFieldCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            if (!self.amountTextField) {
                self.amountTextField = [[[UITextField alloc] initWithFrame:CGRectMake(225, 12, 60, 30)] autorelease];
                self.amountTextField.placeholder = NSLocalizedString(@"10.00", nil);
                self.amountTextField.keyboardType = UIKeyboardTypeNumberPad;
                self.amountTextField.delegate = self;
                if (!self.keyboardToolbar) {
                    self.keyboardToolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
                    UIBarButtonItem *i1 = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.amountTextField action:@selector(resignFirstResponder)] autorelease];
                    [self.keyboardToolbar setItems:[NSArray arrayWithObjects:i1, nil]];
                }
                self.amountTextField.inputAccessoryView = self.keyboardToolbar;
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@ ($)", NSLocalizedString(@"Amount", nil), nil];
            [cell.contentView addSubview:self.amountTextField];
        }
    } else if (indexPath.section == EnterDataSectionSubmit) {
        NSString *CellIdentifier = @"SubmitButtonCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.text = NSLocalizedString(@"Tap To Submit", nil);
        }
    }
    return cell;
}

- (NSString *)stringForSegment:(NSInteger)segment {
    NSString *string = nil;
    if (segment == BoughtOrPaidValueBought) string = NSLocalizedString(@"bought", nil);
    else if (segment == BoughtOrPaidValuePaid) string = NSLocalizedString(@"paid", nil);
    return string;
}

#pragma mark - UITableView delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == EnterDataSectionPeople && self.people.count) {
        self.selectedPerson = [self.people objectAtIndex:indexPath.row];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:EnterDataSectionPeople] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (indexPath.section == EnterDataSectionSubmit) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
        NSNumberFormatter *f = [[[NSNumberFormatter alloc] init] autorelease];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        CGFloat amount = [f numberFromString:self.amountTextField.text].floatValue;
        if (!amount) {
            self.amountTextField.text = @"";
            UIAlertView *alert = [[[UIAlertView alloc] 
                                   initWithTitle:NSLocalizedString(@"Invalid Amount", nil) 
                                   message:NSLocalizedString(@"You entered an invalid amount. Try again!", nil)
                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Okay", nil) otherButtonTitles:nil] autorelease];
            [alert show];
        } else if (!self.selectedPerson) {
            UIAlertView *alert = [[[UIAlertView alloc] 
                                   initWithTitle:NSLocalizedString(@"No Person Selected", nil) 
                                   message:NSLocalizedString(@"Select a person before adding an item. Try again!", nil)
                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Okay", nil) otherButtonTitles:nil] autorelease];
            [alert show];
        } else /*passed all validation */ {
            NSInteger selection = self.boughtOrPaidSegmentedControl.selectedSegmentIndex;
            NSString *message = nil;
            if (selection == BoughtOrPaidValueBought) message = NSLocalizedString(@"%@ bought items totalling $%.2f.", nil);
            else if (selection == BoughtOrPaidValuePaid) message = NSLocalizedString(@"%@ paid for items totalling $%.2f.", nil);
            message = [NSString stringWithFormat:message, self.selectedPerson.name, amount];
            if (selection == BoughtOrPaidValueBought) {
                amount *= -1;
            }
            PaymentObject *payment = [PaymentObject paymentObjectWithAmount:amount fromPerson:self.selectedPerson];
            [self.history addObject:payment];
            self.amountTextField.text = @"";
            self.selectedPerson = nil;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:EnterDataSectionPeople] withRowAnimation:UITableViewRowAnimationNone];
            UIAlertView *alert = [[[UIAlertView alloc] 
                                   initWithTitle:NSLocalizedString(@"Item Added", nil) 
                                   message:message
                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Okay", nil) otherButtonTitles:nil] autorelease];
            [alert show];
        }
    }
}

- (void)dealloc {
    [super dealloc];
}

@end
