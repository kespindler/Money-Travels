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
@synthesize activeTextField = _activeTextField;
@synthesize amountTextField = _amountTextField;
@synthesize boughtOrPaidSegmentedControl = _boughtOrPaidSegmentedControl;
//@synthesize submitButton = _submitButton;
@synthesize keyboardToolbar = _keyboardToolbar;
@synthesize selectedPerson = _selectedPerson;

- (id)initWithStyle:(UITableViewStyle)style
{
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
    self.clearsSelectionOnViewWillAppear = NO;
    UIImageView *backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg_airplane.png"]] autorelease];
    backgroundView.contentMode = UIViewContentModeTop;
    self.tableView.backgroundView = backgroundView;
    NSNotificationCenter *noc = [NSNotificationCenter defaultCenter];
    [noc addObserver:self selector:@selector(keyboardEvent:) name:UIKeyboardDidShowNotification object:nil];
    [noc addObserver:self selector:@selector(keyboardEvent:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.boughtOrPaidSegmentedControl = nil;
    self.amountTextField = nil;
//    self.submitButton = nil;
    self.keyboardToolbar = nil;
}

- (void)viewWillAppear:(BOOL)animated {
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = UITextAlignmentLeft;
    }
    if (indexPath.section == EnterDataSectionPeople) {
        if (self.people.count) {
            cell.textLabel.text = [[self.people objectAtIndex:indexPath.row] name];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        } else {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.text = NSLocalizedString(@"Add people in settings!", nil);
        }
    } else if (indexPath.section == EnterDataSectionOtherFields) {
        if (indexPath.row == EnterDataOtherFieldsBoughtOrPaidSegmentedControl) {
            if (!self.boughtOrPaidSegmentedControl) {
                NSArray *segmentItems = [NSArray arrayWithObjects:
                                         [[self stringForSegment:0] capitalizedString],
                                         [[self stringForSegment:1] capitalizedString], nil];
                self.boughtOrPaidSegmentedControl = [[[UISegmentedControl alloc] initWithItems:segmentItems] autorelease];
                self.boughtOrPaidSegmentedControl.selectedSegmentIndex = BoughtOrPaidValueBought;
                self.boughtOrPaidSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//                CGRect frame = self.boughtOrPaidSegmentedControl.frame;
//                frame.size.height = 30;
//                self.boughtOrPaidSegmentedControl.frame = frame;
            }
            cell.accessoryView = self.boughtOrPaidSegmentedControl;
            cell.textLabel.text = NSLocalizedString(@"Action", nil);
        } else if (indexPath.row == EnterDataOtherFieldsAmountTextField) {
            if (!self.amountTextField) {
                self.amountTextField = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 60, 30)] autorelease];
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
            cell.accessoryView = self.amountTextField;
            cell.textLabel.text = [NSString stringWithFormat:@"%@ ($)", NSLocalizedString(@"Amount", nil), nil];
        }
    } else if (indexPath.section == EnterDataSectionSubmit) {
//        if (!self.submitButton) {
//            self.submitButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 31)] autorelease];
//            self.submitButton.titleLabel.text = NSLocalizedString(@"Add Item", nil);
//            [self.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        cell.accessoryView = self.submitButton;
        cell.textLabel.text = NSLocalizedString(@"Tap To Submit", nil);
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - UIKeyboard notifications
- (void)keyboardEvent:(NSNotification *)note {
    if (note.name == UIKeyboardWillShowNotification) {
        CGSize keyboardSize = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        keyboardSize.height += self.activeTextField.inputAccessoryView.frame.size.height; //is 0 if no input accessory view.
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
        CGRect rect = self.view.frame;
        rect.size.height -= keyboardSize.height;
        if (!CGRectContainsRect(rect, self.activeTextField.frame)) {
            CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y - (keyboardSize.height - 15));
            [self.tableView setContentOffset:scrollPoint animated:YES];
        }
    } else if (note.name == UIKeyboardWillHideNotification) {
        self.tableView.contentInset = UIEdgeInsetsZero;
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }
}

#pragma mark - UITextFieldDelegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeTextField = nil;
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
    } else if (indexPath.section == EnterDataSectionSubmit) {
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
            if (selection == BoughtOrPaidValueBought) message = NSLocalizedString(@"%@ bought items totalling $%f.", nil);
            else if (selection == BoughtOrPaidValuePaid) message = NSLocalizedString(@"%@ paid for items totalling $%f.", nil);
            message = [NSString stringWithFormat:message, self.selectedPerson.name, amount];
            if (selection == BoughtOrPaidValueBought) {
                amount *= -1;
            }
            PaymentObject *payment = [PaymentObject paymentObjectWithAmount:amount fromPerson:self.selectedPerson];
            [self.history addObject:payment];
            self.amountTextField.text = @"";
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
