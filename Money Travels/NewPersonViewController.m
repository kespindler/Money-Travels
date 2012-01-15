//
//  NewPersonViewController.m
//  Money Travels
//
//  Created by Kurt Spindler on 1/13/12.
//  Copyright (c) 2012 Brown University. All rights reserved.
//

#import "NewPersonViewController.h"
#import "PersonObject.h"
#import "AppDelegate.h"

@implementation NewPersonViewController

@synthesize people = _people;
@synthesize addPersonNameTextField = _addPersonNameTextField;
@synthesize addPersonViewControllerDelegate = _addPersonViewControllerDelegate;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"New Person", nil);
        UIBarButtonItem *btn;
        btn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed)] autorelease];
        self.navigationItem.rightBarButtonItem = btn;
        btn = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)] autorelease];
        self.navigationItem.leftBarButtonItem = btn;
    }
    return self;
}

- (id)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)saveButtonPressed {
    if (self.addPersonNameTextField.text.length) {
        AppDelegate *ad = [UIApplication sharedApplication].delegate;
        [self.people addObject:[ad newPersonWithName:self.addPersonNameTextField.text]];
        [ad saveData];
    }
    [self.addPersonViewControllerDelegate personWasAdded];
}

- (void)cancelButtonPressed {
    self.addPersonNameTextField.text = @"";
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.addPersonNameTextField) {
        self.addPersonNameTextField = [[[UITextField alloc] initWithFrame:CGRectMake(100, 12, 185, 30)] autorelease];
        self.addPersonNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.addPersonNameTextField.placeholder = NSLocalizedString(@"John Doe", nil);
    }
    cell.textLabel.text = NSLocalizedString(@"Name", nil);
    [cell.contentView addSubview:self.addPersonNameTextField];
    return cell;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.addPersonNameTextField = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.addPersonNameTextField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
   [self.addPersonNameTextField release];
   [super dealloc];
}


@end
